package handler

import (
	"encoding/json"
	"net/http"

	"github.com/luckyweNda/simpleweb/db"
)

func LoginHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodGet {
		LoginGetHandler(w, r)
	} else if r.Method == http.MethodPost {
		LoginPostHandler(w, r)
	} else {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func LoginGetHandler(w http.ResponseWriter, r *http.Request) {

}

func LoginPostHandler(w http.ResponseWriter, r *http.Request) {
	decoder := json.NewDecoder(r.Body)
	var loginUser LoginRequest
	err := decoder.Decode(&loginUser)
	if err != nil {
		http.Error(w, "Invalid JSON format", http.StatusBadRequest)
		return
	}

	if ok, username := db.CheckLoginUser(loginUser.Email, loginUser.Password); ok {
		TokenResponse(w, r, username, loginUser.Email)
	} else {
		http.Error(w, "Bad request", http.StatusBadRequest)
	}
}
