#!/bin/bash

# Connect to postgres and setup database
psql --username=freecodecamp --dbname=postgres << 'EOF'
DROP DATABASE IF EXISTS worldcup;
CREATE DATABASE worldcup;
EOF

# Build tables, constraints, and relational structure in worldcup database
psql --username=freecodecamp --dbname=worldcup << 'EOF'

-- 1. Create teams table
CREATE TABLE teams (
  team_id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL
);

-- 2. Create games table
CREATE TABLE games (
  game_id SERIAL PRIMARY KEY,
  year INT NOT NULL,
  round VARCHAR(50) NOT NULL,
  winner_id INT REFERENCES teams(team_id) NOT NULL,
  opponent_id INT REFERENCES teams(team_id) NOT NULL,
  winner_goals INT NOT NULL,
  opponent_goals INT NOT NULL
);

EOF

# Dump the database schema and data into worldcup.sql as required by freeCodeCamp
pg_dump -U freecodecamp -d worldcup -F p -f world_cup.sql

echo "Done tol! World Cup database created at na-generate na ang world_cup.sql."
echo "Puwede mo na simulan i-populate data mo gamit ang bash script o python insertion script mo base sa games.csv!"