DROP DATABASE doe_universal;
DROP USER doe_universal;
CREATE DATABASE doe_universal;
CREATE ROLE doe_universal WITH ENCRYPTED PASSWORD 'dawn';
\c doe_universal
GRANT ALL PRIVILEGES ON DATABASE doe_universal TO doe_universal;
CREATE EXTENSION hstore;