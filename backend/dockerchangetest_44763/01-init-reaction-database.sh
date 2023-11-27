#!/bin/bash
set -e
export PGPASSWORD=$POSTGRES_PASSWORD_RE;
psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
		CREATE GROUP cdbadmin;
		CREATE GROUP cdbview;
		CREATE GROUP cdbentry;

		CREATE USER jonc101 PASSWORD '$POSTGRES_PASSWORD_RE';
		CREATE USER cdbweb PASSWORD '$POSTGRES_PASSWORD_RE';
		CREATE ROLE root PASSWORD '$POSTGRES_PASSWORD_RE' superuser;
		ALTER ROLE root WITH LOGIN;

		ALTER GROUP cdbadmin ADD USER jonc101;
		ALTER GROUP cdbview ADD USER cdbweb;

		CREATE DATABASE rex_update WITH OWNER jonc101;

EOSQL

export SQLHOME="/docker-entrypoint-initdb.d"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/DB/data/devTracking.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/DB/data/chemdbCore.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/DB/data/reactions.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/DB/data/tutorialRecords.sql


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reactant.dump.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reagent.dump.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reaction_profile.dump.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reagent_reaction_profile.dump.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reaction_category.dump.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reaction_category_reagent.dump.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reaction_category_reactant.dump.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reaction_synthesis.dump.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reaction_step.dump.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reaction_step_reaction_profile.dump.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/reagent_inheritance.dump.sql

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/user_class.dump.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/user_class_reaction_category.dump.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/assignment_period.dump.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER_RE" --dbname "$POSTGRES_DB_RE" -f $SQLHOME/CombiCDB/data/assignment_problem.dump.sql