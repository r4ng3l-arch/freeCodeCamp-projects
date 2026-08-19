#!/bin/bash

# Connect to the number_guess database
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Prompt for username
echo "Enter your username:"
read username

# Fetch user data if exists
user_info=$($PSQL "SELECT user_id, games_played, best_game FROM users WHERE username='$username'")

if [[ -z $user_info ]]; then
  # New user
  echo "Welcome, $username! It looks like this is your first time here."
  # Insert the new user
  $PSQL "INSERT INTO users(username) VALUES('$username')" > /dev/null
  # Retrieve the new user's ID
  user_id=$($PSQL "SELECT user_id FROM users WHERE username='$username'")
  games_played=0
  best_game=""
else
  # Existing user
  IFS='|' read user_id games_played best_game <<< "$user_info"
  echo "Welcome back, $username! You have played $games_played games, and your best game took $best_game guesses."
fi

# Generate the secret number (1–1000)
secret=$(( RANDOM % 1000 + 1 ))
guess_count=0

# Start the guessing loop
echo "Guess the secret number between 1 and 1000:"
while true; do
  read guess

  # Validate integer input
  if ! [[ $guess =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
    continue
  fi

  ((guess_count++))

  if [[ $guess -eq $secret ]]; then
    echo "You guessed it in $guess_count tries. The secret number was $secret. Nice job!"

    # Update user stats
    new_games_played=$((games_played + 1))
    # Determine best game (if no previous best, or current is lower)
    if [[ -z $best_game || $best_game -eq 0 ]]; then
      new_best_game=$guess_count
    elif [[ $guess_count -lt $best_game ]]; then
      new_best_game=$guess_count
    else
      new_best_game=$best_game
    fi

    $PSQL "UPDATE users SET games_played = $new_games_played, best_game = $new_best_game WHERE user_id = $user_id" > /dev/null
    break

  elif [[ $guess -gt $secret ]]; then
    echo "It's lower than that, guess again:"
  else
    echo "It's higher than that, guess again:"
  fi
done