package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
)

func main() {
	response, err := http.Get("https://raw.githubusercontent.com/kamaal111/PersistanceManager/master/LICENSE")
	if err != nil {
		log.Fatalln(err)
	}
	defer response.Body.Close()
	responseBody, err := io.ReadAll(response.Body)
	if err != nil {
		log.Fatalln(err)
	}
	bodyString := string(responseBody)
	fmt.Println(bodyString)
}
