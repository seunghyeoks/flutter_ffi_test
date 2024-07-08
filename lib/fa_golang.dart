import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ffi/ffi.dart';

import 'bindings_generated.dart';

const String _pkgName = 'fa_golang';
const String _libName = 'go_library';

/// The dynamic library for each platform
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_pkgName.framework/$_pkgName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_pkgName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final FaGolangBindings _bindings = FaGolangBindings(_dylib);


int sum(int a, int b) => _bindings.sum(a, b);

Future<String> readFile(String path) async {
    final String internalPath;
    if (Platform.isAndroid || Platform.isIOS) {
      // 앱의 문서 디렉토리에 파일 복사
      final directory = await getApplicationDocumentsDirectory();
      internalPath = '${directory.path}/test.txt';
      
      // assets에서 파일 복사
      final byteData = await rootBundle.load(path);
      final file = File(internalPath);
      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    } else {
      // 데스크톱의 경우 assets 경로 직접 사용 (개발 용도)
      internalPath = 'assets/test.txt';
    }

    final pathPointer = internalPath.toNativeUtf8();

    try {
      // Pointer<Utf8>를 Pointer<ffi.Char>로 캐스팅
      final charPointer = pathPointer.cast<Char>();

      // Go 함수 호출
      final resultPointer = _bindings.readFileContent(charPointer);
      
      // 결과를 Dart 문자열로 변환
      final result = resultPointer.cast<Utf8>().toDartString();
      
      // 메모리 해제 (Go 측에서 할당한 메모리)
      calloc.free(resultPointer);
      
      return result;
    } finally {
      // 입력 문자열 메모리 해제
      calloc.free(pathPointer);
    }
  }