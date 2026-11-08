/*
=============================================================
Check Database and Create Schemas
=============================================================
Script Purpose:
    The original SQL Server script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated.
    Postgres does not allow IF outside a function, and does not allow DROP DATABASE from inside a function.
    USE does not exist and you need to create a new connection to use a database.
    This procedure checks if the database exists, and if it is the current connection,
    creates the schemas bronze, silver, and gold.
*/

CREATE OR REPLACE PROCEDURE create_schemas()
LANGUAGE plpgsql
AS $$
BEGIN
   IF EXISTS (SELECT 1 FROM pg_database WHERE datname = 'datawarehouse') THEN
      RAISE NOTICE 'Database already exists';
   END IF;
   IF current_database() = 'datawarehouse' THEN
   	RAISE NOTICE 'Using datawarehouse';
   	CREATE SCHEMA IF NOT EXISTS bronze;
      CREATE SCHEMA IF NOT EXISTS silver;
      CREATE SCHEMA IF NOT EXISTS gold;
   END IF;
END;
$$;
