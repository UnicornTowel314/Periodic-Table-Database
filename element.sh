#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

if [[ $# -eq 0 ]]
then
  echo "Please provide an element as an argument."
else
  # is argument an atomic number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUM_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number = $1")
    echo $ATOMIC_NUM_RESULT
    # get info from atomic number (name, symbol, type, atomic mass, melting point, boiling point)
  elif [[ $1 =~ ^[A-Z][a-z]$ ]]
  then
    SYMBOL_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE symbol = '$1")
    echo $SYMBOL_RESULT
  elif [[ $1 =~ ^[A-Z] ]]
  then
    NAME_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE name = '$1")
    echo $NAME_RESULT
  fi
fi

# The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
# elements table has atomic_number, symbol, and name
# properties table has atomic_number, type, atomic_mass, melting_point_celcius, boiling_point_celcius