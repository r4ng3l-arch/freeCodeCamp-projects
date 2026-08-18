#! /bin/bash
# Program to get periodic table elements information
# Author: r4ng3l

# Connect to the periodic_table database
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Check if an argument was provided
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# Get the element information
ELEMENT_INFO=$($PSQL "
  SELECT
    e.atomic_number,
    e.name,
    e.symbol,
    t.type,
    p.atomic_mass,
    p.melting_point_celsius,
    p.boiling_point_celsius
  FROM elements e
  JOIN properties p
    ON e.atomic_number = p.atomic_number
  JOIN types t
    ON p.type_id = t.type_id
  WHERE
    e.atomic_number::TEXT = '$1'
    OR e.symbol = '$1'
    OR e.name = '$1'
")

# Check if the element was found
if [[ -z $ELEMENT_INFO ]]
then
  echo "I could not find that element in the database."
  exit
fi

# Split the result into variables
IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING <<< "$ELEMENT_INFO"

# Display the result
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."