#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNERGOALS OPPONENTGOALS
do
  if [[ $YEAR != "year" ]]
  then 
  INSERT_WINNERS=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER') ON CONFLICT DO NOTHING;");
  INSERT_OPPONENTS=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT') ON CONFLICT DO NOTHING;");

  fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNERGOALS OPPONENTGOALS
do
  if [[ $YEAR != "year" ]]
  then 
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';");
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';");

  INSERT_GAMES=$($PSQL "INSERT INTO games(round, year, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$ROUND','$YEAR',$WINNER_ID,$OPPONENT_ID,'$WINNERGOALS','$OPPONENTGOALS') ON CONFLICT DO NOTHING;");
  fi
done
