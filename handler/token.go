package handler

import (
	"encoding/json"
	"net/http"

	"github.com/luckyweNda/simpleweb/misc"
)

func TokenResponse(w http.ResponseWriter, r *http.Request, username string, email string) {
	token, err := misc.CreateJWT(username, email)
	if err != nil {
		http.Error(w, "Internal server error", http.StatusInternalServerError)
		return
	}

	response := LoginResponse{OK: true, Token: token, Username: username, Email: email}
	jsonResponse, err := json.Marshal(response)
	if err != nil {
		http.Error(w, "Internal server error", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(jsonResponse)
}
