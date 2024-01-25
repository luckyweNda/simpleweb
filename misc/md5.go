package misc

import (
	"crypto/md5"
	"encoding/hex"
)

func MD5Encode(input string) string {
	hasher := md5.New()
	hasher.Write([]byte(input))
	hashBytes := hasher.Sum(nil)
	hashString := hex.EncodeToString(hashBytes)

	return hashString
}
