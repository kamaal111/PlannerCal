package main

import (
	"errors"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"time"
)

func main() {
	startTimer := time.Now()

	spmPath := getSPMPath()

	// outputPath := initializelag("Output path", "", "output", "o")

	spmDirectoryContent, err := ioutil.ReadDir(spmPath)
	checkError(err)

	var licenses []License

	for _, spmPackage := range spmDirectoryContent {
		if spmPackage.IsDir() {
			packagePath := spmPath + "/" + spmPackage.Name()
			packageDirectoryContent, err := ioutil.ReadDir(packagePath)
			checkError(err)

			license := License{
				PackageName: spmPackage.Name(),
			}

			for _, packageFile := range packageDirectoryContent {
				if packageFile.Name() == "LICENSE" {
					licenseData, err := ioutil.ReadFile(packagePath + "/" + packageFile.Name())
					checkError(err)

					license.Content = string(licenseData)
				}
			}

			licenses = append(licenses, license)

		}
	}

	fmt.Println(licenses)

	timeElapsed := time.Since(startTimer)
	fmt.Printf("Took %s ✨\n", timeElapsed)
}

// License - structure of the license object
type License struct {
	Content     string `json:"content"`
	PackageName string `json:"package_name"`
	Version     string `json:"version"`
	URL         string `json:"url"`
}

func checkError(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func getSPMPath() string {
	spmPath := os.Getenv("BUILD_DIR")
	if len(spmPath) > 0 {
		return spmPath + "/../../SourcePackages/checkouts"
	}
	spmPathFlag := initializelag("SPM path", "", "spm", "s")
	if len(spmPathFlag) < 1 {
		log.Fatalln(errors.New("please provide the SPM path with -s or -spm"))
	}
	return spmPathFlag

}

func initializelag(usage string, flagDefault string, longVariable string, shortVariable string) string {
	var value string
	flag.StringVar(&value, longVariable, flagDefault, usage)
	flag.StringVar(&value, shortVariable, flagDefault, usage)
	flag.Parse()
	return value
}
