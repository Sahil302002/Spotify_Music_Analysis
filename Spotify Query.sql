SELECT TOP (1000) [Artist]
      ,[Track]
      ,[Album]
      ,[Album_type]
      ,[Danceability]
      ,[Energy]
      ,[Loudness]
      ,[Speechiness]
      ,[Acousticness]
      ,[Instrumentalness]
      ,[Liveness]
      ,[Valence]
      ,[Tempo]
      ,[Duration_min]
      ,[Title]
      ,[Channel]
      ,[Views]
      ,[Likes]
      ,[Comments]
      ,[Licensed]
      ,[official_video]
      ,[Stream]
      ,[EnergyLiveness]
      ,[most_playedon]
  FROM [Spotify_DB].[dbo].[Spotify_Data]

-- EXPLORATORY DATA ANALYSIS
-- How many records are there?
SELECT COUNT(*) Total_Records FROM Spotify_Data

-- What is the Total Number of Unique Artist we have?
SELECT COUNT(DISTINCT Artist) Total_Numb_of_Artist FROM Spotify_Data

-- What is the Total Number of Albums?
SELECT COUNT(DISTINCT Album) Total_Numb_of_Album FROM Spotify_Data

-- What are the Album type available?
SELECT DISTINCT Album_type FROM Spotify_Data

-- What is the Maximum and Minimum Duration of a Song?
SELECT 
	MAX(Duration_min) Max_Duration,
	MIN(Duration_min) Min_Duration
FROM Spotify_Data

-- Some songs are having 0 duration that cannot be possible so we need to get rid of those errors
SELECT * FROM Spotify_Data
WHERE Duration_min = 0

-- So we will Delete these two records
DELETE FROM Spotify_Data
WHERE Duration_min = 0

--  Now How many records are there?
SELECT COUNT(*) Total_Records FROM Spotify_Data

-- How many channel we have?
SELECT COUNT(DISTINCT Channel) Number_of_Channels FROM Spotify_Data

-- What are the Platform in which we segment most popular
SELECT DISTINCT most_playedon FROM Spotify_Data

/*
===================================================
             Data Analysis Basic level
===================================================
*/

-- (Q1) Retrieve the names of all tracks that have more than 1 billion stream
SELECT Track, Stream FROM Spotify_Data
WHERE Stream > 1000000000

-- (Q2) List all the albums with their respective artists

SELECT 
	COUNT(DISTINCT Album) Total_Albums
FROM Spotify_Data
-- Here one thing to Conlude that More than One Artist made the Album

SELECT 
	DISTINCT Album,
	Artist 
FROM Spotify_Data
ORDER BY Album

-- (Q3) Get the total number of comments for tracks where licensed = True
SELECT 
	FORMAT((SUM(Comments)) ,'N0', 'en-US') Total_Comments
FROM Spotify_Data
	WHERE Licensed = 'TRUE'

-- (Q4) Find all the Track that belong to album type single.
SELECT * FROM Spotify_Data
WHERE Album_type = 'Single'

-- (Q5) Count the Total Number of tracks by each artist
SELECT 
	Artist, 
	COUNT(Track) Total_Nr_Track
FROM Spotify_Data
	GROUP BY Artist
ORDER BY
	COUNT(Track) DESC
/*
===================================================
             Data Analysis Intermediate Level
===================================================
*/

--(Q6) Calculate the Average Danceability of tracks in each album
SELECT 
    Album, 
    AVG(Danceability) Avg_Danceability
FROM Spotify_Data
GROUP BY Album
ORDER BY 
    AVG(Danceability) DESC

-- Extra thing I noted here that There are album which have more than one track
SELECT 
	Album, 
	COUNT(TRACK) Number_of_Tracks
FROM Spotify_Data
GROUP BY Album 
ORDER BY 
	COUNT(TRACK) DESC

-- (Q7) Find the Top 5 Tracks with highest energy values
SELECT TOP 5
	 Track,
	MAX(Energy) Max_Energy
FROM Spotify_Data
GROUP BY Track
ORDER BY 
	MAX(Energy) DESC

-- (Q8) List all tracks along with views and likes where official_video = True

SELECT Track, 
	SUM(Views) Total_Views, 
	SUM(Likes) Total_Likes 
FROM Spotify_Data
	WHERE official_video = 'TRUE'
GROUP BY Track
ORDER BY
	SUM(Views) DESC

-- (Q9) For each album, Calculate the total views of all tracks
SELECT
	ALBUM,
	Track, 
	SUM(Views) Total_Views 
FROM Spotify_Data
GROUP BY Track,Album
ORDER BY 
	SUM(Views) DESC

--(Q10) Retrieve the Track names that have been streamed on Spotify more than Youtube
SELECT 
Track, 
SUM(CASE WHEN most_playedon = 'Youtube' THEN Stream END) Stream_on_youtube,
SUM(CASE WHEN most_playedon = 'Spotify' THEN Stream END) Stream_on_Spotify
FROM Spotify_Data
GROUP BY Track

-- We can Notice that Most of the songs are not streamed on both the platform

SELECT * FROM 
	(SELECT 
		Track, 
		COALESCE(SUM(CASE WHEN most_playedon = 'Youtube' THEN Stream END),0) Stream_on_youtube,
		COALESCE(SUM(CASE WHEN most_playedon = 'Spotify' THEN Stream END),0) Stream_on_Spotify
	FROM Spotify_Data
	GROUP BY Track) 
AS T1
WHERE
	Stream_on_Spotify > Stream_on_youtube
	AND
	Stream_on_youtube <> 0
ORDER BY Stream_on_Spotify DESC
/*
===================================================
             Data Analysis Advance Level
===================================================
*/

--(Q11) Find Top 3 most viewed tracks for each artist using window functions
-- First we will find Each Artist and Total view for each Track
-- Second Track with Highest View for each Artist( We need Top3)
-- Third use Dense Rank function and CTE 

WITH Ranking_Artist
AS(
SELECT 
	Artist, 
	Track,
	SUM(Views) Total_Views,
	DENSE_RANK() OVER(PARTITION BY Artist ORDER BY SUM(Views) DESC) Rank
FROM Spotify_Data
GROUP BY Artist,Track
)
SELECT * FROM Ranking_Artist
WHERE Rank<=3

--(Q12) Write a Query to find Tracks where the liveness is above Average
SELECT 
	Track,
	Artist, 
	Liveness 
FROM Spotify_Data
WHERE Liveness> (SELECT AVG(Liveness) FROM Spotify_Data)
ORDER BY Liveness DESC

--(Q13) Use a with Clause to calculate the difference between the Highest and lowest energy values for 
-- tracks in each album
WITH Energy_of_Album AS
(
SELECT
	Album,
	MAX(Energy) Highest_Energy,
	MIN(Energy) Lowest_Energy
	FROM Spotify_Data
GROUP BY Album
)
SELECT Album, Highest_Energy - Lowest_Energy as Energy_difference
FROM Energy_of_Album
ORDER BY 2 DESC

SELECT Top 1000 * FROM Spotify_Data

-- (Q14) Find tracks where the energy-to-liveness ratio is greater than 1.2.
SELECT Track, EnergyLiveness FROM Spotify_Data
WHERE EnergyLiveness> 1.2
ORDER BY EnergyLiveness DESC


-- (Q15) Calculate the cumulative sum of likes for tracks ordered by the number of views, using window
-- functions.
SELECT 
    Track, 
    SUM(TotalLikes) OVER (ORDER BY TotalViews DESC) AS CumulativeLikes
FROM (
    SELECT 
        Track, 
        SUM(Views) AS TotalViews, 
        SUM(likes) AS TotalLikes
    FROM Spotify_Data
    GROUP BY Track
) t3
ORDER BY TotalViews DESC;

-- Query Optimizations
-- Query
SELECT
	TOP 25 
	Artist,
	Track, 
	Views
FROM Spotify_Data
WHERE
	Artist ='Gorillaz'
	AND
	Most_playedon = 'Spotify'
ORDER BY 
	stream DESC

CREATE  INDEX Artist_Index ON Spotify_Data (Artist)
-- Ran query after creating Index
SELECT
	TOP 25 
	Artist,
	Track, 
	Views
FROM Spotify_Data
WHERE
	Artist ='Gorillaz'
	AND
	Most_playedon = 'Spotify'
ORDER BY 
	stream DESC

-- By this way we can optimize performance of Queries
