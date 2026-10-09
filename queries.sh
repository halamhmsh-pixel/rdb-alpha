#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games;")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games;")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games;")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games;")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games;")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games;")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2;")"

echo -e "\nWinner of the 2018 tournament round name:"
echo "$($PSQL "SELECT name FROM games JOIN teams ON games.winner_id = teams.team_id WHERE year = 2018 AND round = 'Final';")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT name FROM teams WHERE team_id IN (SELECT winner_id FROM games WHERE year = 2014 AND round = 'Eighth-Final' UNION SELECT opponent_id FROM games WHERE year = 2014 AND round = 'Eighth-Final') ORDER BY name;")"

echo -e "\nList of unique game years in the database:"
echo "$($PSQL "SELECT DISTINCT(year) FROM games ORDER BY year;")"

echo -e "\nList of all teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%';")"

echo -e "\nList of teams and their total goals scored in all games:"
echo "$($PSQL "SELECT t.name, SUM(g.goals) FROM (SELECT winner_id AS team_id, winner_goals AS goals FROM games UNION ALL SELECT opponent_id AS team_id, opponent_goals AS goals FROM games) AS g JOIN teams AS t ON g.team_id = t.team_id GROUP BY t.name ORDER BY t.name;")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name FROM games JOIN teams ON games.winner_id = teams.team_id WHERE round = 'Final' ORDER BY year;")"

echo -e "\nList of teams that start with 'The':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'The%';")"