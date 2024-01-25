package handler

type RegisterRequest struct {
	Username string `json:"username"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

type LoginResponse struct {
	OK       bool   `json:"ok"`
	Token    string `json:"token"`
	Username string `json:"username"`
	Email    string `json:"email"`
}
