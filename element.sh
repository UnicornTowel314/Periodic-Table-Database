#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $# -eq 0 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
    if [[ -z $ATOMIC_NUM ]]
    then
      echo -e "I could not find that element in the database."
    else
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
      TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number = $1")
      MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")
      echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
    if [[ -z $SYMBOL ]]
    then
      echo -e "I could not find that element in the database."
    else
      ATOMIC_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
      NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
      TYPE=$($PSQL "SELECT type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1'")
      MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol = '$1'")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol = '$1'")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol = '$1'")
      echo -e "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  elif [[ $1 =~ ^[A-Z] ]]
  then
    NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
    if [[ -z $NAME ]]
    then
      echo -e "I could not find that element in the database."
    else
      ATOMIC_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
      TYPE=$($PSQL "SELECT type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1'")
      MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE name = '$1'")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE name = '$1'")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE name = '$1'")
      echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  else
    echo "I could not find that element in the database."
  fi
fi