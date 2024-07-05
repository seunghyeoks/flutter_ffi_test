// func.go file
package main

import (
	"C"
	"log"
	"os"
)

//export sum
func sum(a C.int, b C.int) C.int {
	return a + b
}

//export readFileContent
func readFileContent(filePath *C.char) *C.char {
	// Convert C string to Go string
	goFilePath := C.GoString(filePath)

	// Read the file content
	content, err := os.ReadFile(goFilePath)
	if err != nil {
		log.Println("Error reading file:", err)
		return C.CString("")
	}

	// Convert Go string to C string
	return C.CString(string(content))
}

//export enforce_binding
func enforce_binding() {}

func main() {}
