CREATE TABLE Player (
    id serial PRIMARY KEY NOT NULL,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT,
    joined timestamp NOT NULL DEFAULT(now()),
    emailVerified boolean NOT NULL DEFAULT(false)
);