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
	if len(outputPath) > 0 {
		fmt.Println(outputPath)
	}

	spmDirectoryContent, err := ioutil.ReadDir(spmPath)
	checkError(err)

	for _, packages := range spmDirectoryContent {
		if packages.Name() != ".DS_Store" {
			packagePath := spmPath + "/" + packages.Name()
			packageDirectoryContent, err := ioutil.ReadDir(packagePath)
			checkError(err)
			for _, packageFile := range packageDirectoryContent {
				if packageFile.Name() == "LICENSE" {
					licenseData, err := ioutil.ReadFile(packagePath + "/" + packageFile.Name())
					checkError(err)
					fmt.Println(string(licenseData))
				}
			}

		}
	}
}

func checkError(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

// InitializingFlag - Initializes flag
func InitializingFlag(usage string, flagDefault string, longVariable string, shortVariable string) string {
	var value string
	flag.StringVar(&value, longVariable, flagDefault, usage)
	flag.StringVar(&value, shortVariable, flagDefault, usage)
	flag.Parse()
	return value
}
