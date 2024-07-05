import 'package:flutter/material.dart';
import 'package:fa_golang/fa_golang.dart' as fa_golang;  // fa_golang.dart 임포트

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _fileContent = 'File content will be shown here';

  @override
  void initState() {
    super.initState();
    _loadFileContent();
  }

  Future<void> _loadFileContent() async {
    // fa_golang.readFile 함수 호출
    fa_golang.readFile('./pems/test.txt').then((String result) {
      setState(() {
        _fileContent = result;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Read File Content')),
      body: Center(child: Text(_fileContent)),
    );
  }
}