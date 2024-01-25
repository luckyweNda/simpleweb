package main

import (
	"fmt"
	"net/http"

	"github.com/luckyweNda/simpleweb/handler"
)

func main() {
	http.Handle("/", http.FileServer(http.Dir("./ui/build/web")))
	http.HandleFunc("/register", handler.RegisterHandler)
	http.HandleFunc("/login", handler.LoginHandler)
	fmt.Println("Server is listening on :8080...")
	http.ListenAndServe(":8080", nil)
}
