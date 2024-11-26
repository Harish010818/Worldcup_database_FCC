#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

if [[ $YEAR != "year" ]]
   then
   #inserting winner
   WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    if [[ -z $WINNER_ID ]]
    then
      echo $($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
   fi 

   #inserting opponent
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    if [[ -z $OPPONENT_ID ]]
    then
     echo $($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
   fi

   WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
   OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

  #inserting game info
  echo $($PSQL "INSERT INTO games(round, year, winner_goals, opponent_goals, winner_id, opponent_id) VALUES('$ROUND', $YEAR, $WINNER_GOALS, $OPPONENT_GOALS, $WINNER_ID, $OPPONENT_ID)")
  
fi 
done
