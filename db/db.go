package db

import (
	"database/sql"
	"flag"
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

var (
	dbHost     string
	dbPort     int
	dbUsername string
	dbPassword string
	dbName     string
)

var dbConnection *sql.DB = nil

func RegisterUser(username string, email string, password string) error {
	insertQuery := "INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)"
	_, err := dbConnection.Exec(insertQuery, username, email, password)
	if err != nil {
		log.Println(err)
		return err
	}

	fmt.Println("Data inserted successfully.")
	return nil
}

func parseDatabaseFlag() {
	flag.StringVar(&dbHost, "dbhost", "localhost", "Database host")
	flag.IntVar(&dbPort, "dbport", 3306, "Database port")
	flag.StringVar(&dbUsername, "dbuser", "root", "Database username")
	flag.StringVar(&dbPassword, "dbpass", "", "Database password")
	flag.StringVar(&dbName, "dbname", "dbname", "Database name")
	flag.Parse()
}

func initDatabaseConnection() {
	dbUrl := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s", dbUsername, dbPassword, dbHost, dbPort, dbName)
	db, err := sql.Open("mysql", dbUrl)
	if err != nil {
		log.Fatal(err)
	}

	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}

	dbConnection = db
	print("Database connection established.\n")
}

func init() {
	parseDatabaseFlag()
	initDatabaseConnection()
}
