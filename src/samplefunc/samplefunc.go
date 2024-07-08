// samplefunc/samplefunc.go file
package samplefunc

import (
	"log"
	"os"
)

func Sum(a, b int) int {
	return a + b
}

func ReadFileContent(filePath string) string {
	content, err := os.ReadFile(filePath)
	if err != nil {
		log.Println("Error reading file:", err)
		return ""
	}
	return string(content)
}
