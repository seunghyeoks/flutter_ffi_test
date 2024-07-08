// go_interface.go file
package main

import (
	"C"
	"go_code/samplefunc"
)

//export sum
func sum(a C.int, b C.int) C.int {
	return C.int(samplefunc.Sum(int(a), int(b)))
}

//export readFileContent
func readFileContent(filePath *C.char) *C.char {
	goFilePath := C.GoString(filePath)
	content := samplefunc.ReadFileContent(goFilePath)
	return C.CString(content)
}

//export enforce_binding
func enforce_binding() {}

func main() {}
