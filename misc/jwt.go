package misc

import (
	"net/http"
	"strings"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

func CreateJWT(name string, email string) (string, error) {
	secretKey := []byte("your-secret-key")

	claims := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"username": name,
		"email":    email,
		"exp":      time.Now().Add(time.Hour * 24).Unix(),
	})

	tokenString, err := claims.SignedString(secretKey)
	if err != nil {
		return "", err
	}

	return tokenString, nil
}

func ExtractTokenFromHeader(r *http.Request) (bool, string, string) {
	authHeader := r.Header.Get("Authorization")
	if authHeader == "" {
		return false, "", ""
	}

	// Check if the header has the correct format "Bearer <token>"
	parts := strings.SplitN(authHeader, " ", 2)
	if len(parts) != 2 || parts[0] != "Bearer" {
		return false, "", ""
	}

	tokenString := parts[1]

	if tokenString == "" {
		return false, "", ""
	}

	// Parse and validate the JWT token
	token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
		// You should replace "your-secret-key" with the actual secret key used to sign the JWT
		return []byte("your-secret-key"), nil
	})

	if err != nil || !token.Valid {
		return false, "", ""
	}

	// Extract claims from the token
	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return false, "", ""
	}

	// Extract username and email from claims
	username, ok := claims["username"].(string)
	if !ok {
		return false, "", ""
	}

	email, ok := claims["email"].(string)
	if !ok {
		return false, "", ""
	}

	return true, username, email
}
