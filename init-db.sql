CREATE EXTENSION IF NOT EXISTS pgcrypto;  -- install for bcrypt

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(60) NOT NULL UNIQUE,
    password VARCHAR(80) NOT NULL,
    email TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    body TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS comments (
    id SERIAL PRIMARY KEY,
    body TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (post_id) REFERENCES posts (id)
);

CREATE FUNCTION create_user(
    username VARCHAR(60),
    password VARCHAR(80),
    email TEXT
) RETURNS users AS $$ 
    INSERT INTO users (username, password, email) VALUES ($1, crypt($2, gen_salt('bf')), $3) RETURNING *;
$$ LANGUAGE SQL VOLATILE;

CREATE FUNCTION create_user_with_first_post(
    username VARCHAR(60),
    password VARCHAR(80),
    email TEXT,
    post_title VARCHAR(100),
    post_body TEXT
) RETURNS users AS $$

DECLARE
    new_user users;
    
BEGIN
    new_user := create_user(username, password, email);
    INSERT INTO posts (title, body, user_id) VALUES (post_title, post_body, new_user.id);
    RETURN new_user;

END;
$$ LANGUAGE plpgsql VOLATILE;
