package handler

type User struct {
	Username string `json:"username"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

type TokenResponse struct {
	OK       bool   `json:"ok"`
	Token    string `json:"token"`
	Username string `json:"username"`
	Email    string `json:"email"`
}
