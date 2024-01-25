package handler

import (
	"encoding/json"
	"net/http"

	"github.com/luckyweNda/simpleweb/db"
	"github.com/luckyweNda/simpleweb/misc"
)

func RegisterHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	decoder := json.NewDecoder(r.Body)
	var newUser RegisterRequest
	err := decoder.Decode(&newUser)
	if err != nil {
		http.Error(w, "Invalid JSON format", http.StatusBadRequest)
		return
	}

	newUser.Password = misc.MD5Encode(newUser.Password)

	err = db.RegisterUser(newUser.Username, newUser.Email, newUser.Password)
	if err != nil {
		http.Error(w, "Internal server error", http.StatusInternalServerError)
		return
	}

	token, err := misc.CreateJWT(newUser.Username, newUser.Email)
	if err != nil {
		http.Error(w, "Internal server error", http.StatusInternalServerError)
		return
	}

	response := LoginResponse{OK: true, Token: token, Username: newUser.Username, Email: newUser.Email}
	jsonResponse, err := json.Marshal(response)
	if err != nil {
		http.Error(w, "Internal server error", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(jsonResponse)
}
