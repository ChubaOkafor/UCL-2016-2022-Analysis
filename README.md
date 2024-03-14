# ⚽ UCL-2016-2022-Analysis

## Table of Contents
- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools Used](#Tools-Used)
- [Data Loading and Inspection](#Data-Loading-and-Inspection)
- [Exploratory Data Analysis](#Exploratory-Data-Analysis)
- [Data Visualization](#Data-Visualization)
- [Insights](#Insights)

## Project Overview
This project is an analysis of data for the annual football club competition, the UEFA Champions League (UCL) for the years 2016 to 2022. This analysis is gearded towards getting specific information regarding players, managers, clubs, stadiums and goals from the competition.

## Data Sources
UEFA Champions League 2016-2022 Data:  The primary data for this analysis is the "UEFA Champions League 2016-2022 Data.xlsx" file. This file is made up of a number of sheets with data on teams, players, managers, stadiums, goals and matches for the period under consideration

## Tools Used
1. Microsoft Excel - Data Loading and Inspection
2. Microsoft SQL Server Management Studios (SSMS) - Exploratory Data Analysis
3. Microsoft Power BI Desktop - Data Visualization

## Data Loading and Inspection
This was done using Microsoft Excel and involved loading the dataset and checking for duplicates using the excel duplicate finding feature

## Exploratory Data Analysis
This was done using SSMS to manipulate the data to get further insights. A variety of SQL functions such as select, case statements, order by, group by, subqueries, temporary tables, where clauses etc. were utilized to get answers a number of questions based on the given data. Some of the questions that this analysis set out to answer are as follows;
- Who were the top goal scorers within the given period?
- Who were the top assisters within the given period?
- What was the Win/Loss record for the top teams?
- What were the stadiums with the highest capacity and average attendance?
- What is the current age range distribution for players?
- What is the current age range distrbution for managers?
- What is the goal distribution per half of football?

## Data Visualization
This aspect of the project was done using Microsoft Power BI. The visualization was done based on the insights gotten from the SQL Queries written to answer the above questions. A number of charts and graphs such as pie chart, column chart, bar chart etc. were used to visualize the insights gotten from the UEFA Champions League 2016-2022 Data.

## Insights
- Real Madrid played the most number of games over the period under consideration with 67
- Bayern Munchen won 44 games and lost only 9 games during the period making them the team with the most number of wins and the least number of losses
- Spotify Camp Nou has the highest capacity with 99,354 and Wembley Stadium has the highest average attendance with 69,767
- The 2017/2018 had the highest total number of goals with 401 being scored during that season, however, the 2019/2020 season had the highest average goal per game rate with 3.24 goals per game. This can also be attributed to the 2019/2020 season having less games due to the outbreak of the corona virus.
- Majority of the goals scored during games occured in the second half of normal time and the least number of goals scored occured during the second half of extra time.
- Most managers are within the age range of 46-56 years
- Most players fall within the age range of 26-34 years
- France, Spain and Brazil are the countries with the most number of players that played in the competition with France having the most number of players with 180.
- Neymar had the most number of assists for the period under consideration with 24 assits.
- Robert Lewandowski was the top goal scorer for the period under consideration with 54 goals.
- Paris Saint-Germain were the highest scoring team acorss all the games for the period under consideration with 142 goals.
