package main

import (
	"errors"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
)

func main() {
	spmPath := os.Getenv("BUILD_DIR")
	if len(spmPath) > 0 {
		spmPath = spmPath + "/../../SourcePackages/checkouts"
	} else {
		spmPathFlag := InitializingFlag("SPM path", "", "spm", "s")
		if len(spmPathFlag) < 1 {
			log.Fatalln(errors.New("please provide the SPM path with -s or -spm"))
		}
		spmPath = spmPathFlag
	}

	outputPath := InitializingFlag("Output path", "", "output", "o")
	fmt.Println(outputPath)

	spmDirectoryContent, err := ioutil.ReadDir(spmPath)
	if err != nil {
		log.Fatal(err)
	}

	for _, packages := range spmDirectoryContent {
		if packages.Name() != ".DS_STORE" {
			fmt.Println(packages.Name())
		}
	}

	// response, err := http.Get("https://raw.githubusercontent.com/kamaal111/PersistanceManager/master/LICENSE")
	// if err != nil {
	// 	log.Fatalln(err)
	// }
	// defer response.Body.Close()
	// responseBody, err := io.ReadAll(response.Body)
	// if err != nil {
	// 	log.Fatalln(err)
	// }
	// bodyString := string(responseBody)
	// fmt.Println(bodyString)
}

// InitializingFlag - Initializes flag
func InitializingFlag(usage string, flagDefault string, longVariable string, shortVariable string) string {
	var value string
	flag.StringVar(&value, longVariable, flagDefault, usage)
	flag.StringVar(&value, shortVariable, flagDefault, usage)
	flag.Parse()
	return value
}
