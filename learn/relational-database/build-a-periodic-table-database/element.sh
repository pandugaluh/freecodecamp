#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
  then
    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
      ELEMENT_NAME_BY_SYMBOL=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements join properties using(atomic_number) join types using(type_id) WHERE symbol = '$1'")
      if [[ -z $ELEMENT_NAME_BY_SYMBOL ]]
      then
        ELEMENT_NAME_BY_NAME=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements join properties using(atomic_number) join types using(type_id) WHERE name = '$1'")
        if [[ -z $ELEMENT_NAME_BY_NAME ]]
        then
          echo -e "I could not find that element in the database."
        else
          echo "$ELEMENT_NAME_BY_NAME" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
          do
            echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
          done
        fi
      else
        echo "$ELEMENT_NAME_BY_SYMBOL" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
        do
          echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    else
      ELEMENT_NAME_BY_NUMBER=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements join properties using(atomic_number) join types using(type_id) WHERE atomic_number = $1")
      if [[ -z $ELEMENT_NAME_BY_NUMBER ]]
      then
        echo -e "I could not find that element in the database."
      else
        echo "$ELEMENT_NAME_BY_NUMBER" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
        do
          echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    fi
  else
    echo -e "Please provide an element as an argument."
  fi
