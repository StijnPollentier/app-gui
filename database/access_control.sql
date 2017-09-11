/****************************************************

		ACCESS CONTROL STATEMENTS

*****************************************************/

-- For each service, create a user (i.e. a role that can log in).
CREATE USER dashboard INHERIT;
CREATE USER daltix INHERIT;

-- A dalton role
CREATE ROLE dalton;
CREATE ROLE service;

-- Add daltons to dalton group
GRANT dalton TO daltix;

-- Add services to role service
GRANT service TO dashboard;

-- Admins can create databases, create roles
CREATE ROLE admin CREATEDB CREATEROLE; -- This is a group (no login)

-- Set correct database permissions --
GRANT CONNECT ON DATABASE hive_db TO service;
GRANT ALL PRIVILEGES ON DATABASE hive_db TO dalton WITH GRANT OPTION;
ALTER DATABASE hive_db OWNER TO dalton;
