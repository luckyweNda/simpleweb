CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, email, password_hash) 
VALUES ('example_user', 'user@example.com', 'hashed_password');

ALTER TABLE users
ADD CONSTRAINT unique_email UNIQUE (email);