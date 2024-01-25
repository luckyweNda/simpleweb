package misc

import (
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
