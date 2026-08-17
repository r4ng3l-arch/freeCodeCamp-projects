#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Insert teams
$PSQL "INSERT INTO teams(name) VALUES
('Brazil'),
('Germany'),
('Argentina'),
('France'),
('Spain'),
('England'),
('Netherlands'),
('Uruguay'),
('Portugal'),
('Belgium'),
('Croatia'),
('Colombia'),
('Chile'),
('Mexico'),
('Costa Rica'),
('Switzerland'),
('United States'),
('Japan'),
('Russia'),
('Denmark'),
('Sweden'),
('Nigeria'),
('Algeria'),
('Greece');"

# Insert games
cat games.csv | sed 1d | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

  $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
  VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)"
done
