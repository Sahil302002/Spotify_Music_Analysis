# **Project Overview**

**T**he Spotify SQL Analysis project involved analyzing a comprehensive dataset containing music metadata, audio features, and streaming information to derive meaningful insights about tracks and their performance on various platforms. By leveraging SQL, this project focused on uncovering patterns in musical characteristics, artist popularity, and audience engagement.

![SPOTIFY ](https://github.com/user-attachments/assets/a7ca2562-0de8-4552-9a0c-47637ec0ff60)


### Comprehensive Spotify Music Dataset: Metadata, Audio Features, and Streaming Insights

This Spotify dataset is a comprehensive collection of music-related data containing **20,595 rows** and **24 columns**. It provides the following key information:

1. **Metadata**:
    - Details like **Artist**, **Track Title**, **Album**, and **Album Type**, which help in identifying and categorizing tracks.
2. **Audio Features**:
    - Quantitative metrics such as **Danceability**, **Energy**, **Valence**, and **Tempo**, offering insights into the musical and acoustic characteristics of each track.
3. **Video and Streaming Information**:
    - Data on **YouTube views, likes, comments**, licensing status, and **streaming counts**, useful for evaluating the popularity and engagement of tracks across platforms

Dataset Link

---

## **Objective**

The primary objective of this project was to:

1. Analyze the dataset to identify trends in music preferences and streaming behaviors.
2. Provide actionable insights into track performance, artist impact, and platform engagement.
3. Demonstrate SQL proficiency by querying and manipulating data efficiently for analysis.

---

## Tasks to Solve

### **BASIC LEVEL**

- Retrieve the names of all tracks that have more than 1 billion streams.
- List all albums along with their respective artists.
- Get the total number of comments for tracks where `licensed = TRUE`.
- Find all tracks that belong to the album type `single`.
- Count the total number of tracks by each artist.

### **INTERMEDIATE LEVEL**

- Calculate the average danceability of tracks in each album.
- Find the top 5 tracks with the highest energy values.
- List all tracks along with their views and likes where `official_video = TRUE`.
- For each album, calculate the total views of all associated tracks.
- Retrieve the track names that have been streamed on Spotify more than YouTube.

### **ADVANCE LEVEL**

- Find the top 3 most-viewed tracks for each artist using window functions.
- Write a query to find tracks where the liveness score is above the average.
- **Use a `WITH` clause to calculate the difference between the highest and lowest energy values for tracks in each album.**
- Find tracks where the energy-to-liveness ratio is greater than 1.2.
- Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

Spotify Music’s SQL Analysis PDF Link

Spotify Music’s SQL Analysis Script Link

## **Tasks Performed**

1. **Data Cleaning and Preparation:**
    - Identified and handled null values, duplicates, and inconsistent data.
    - Ensured proper categorization of tracks based on album types and licensing status.
2. **Descriptive Analysis:**
    - Analyzed key attributes like **Danceability**, **Energy**, and **Tempo** to understand audio trends.
    - Explored artist popularity based on the number of tracks and streaming counts.
3. **Performance Metrics Analysis:**
    - Examined correlations between features like **Loudness**, **Valence**, and **Streams** to assess audience preferences.
    - Analyzed YouTube metrics (**Views**, **Likes**, **Comments**) to determine engagement levels.
4. **Trend Identification:**
    - Identified the top-performing artists, albums, and tracks based on streaming and video performance.
    - Investigated patterns in audio features influencing track success.

---

## **SQL Skills Demonstrated**

1. **Data Manipulation**:
    - Used **SELECT**, **WHERE**, and **JOIN** clauses to extract relevant insights from the dataset.
2. **Aggregations and Grouping**:
    - Applied **GROUP BY**, **HAVING**, and **ORDER BY** to summarize data and identify trends effectively.
3. **Complex Queries**:
    - Implemented nested queries, **CASE** statements, and conditional aggregations for deeper analysis.
4. **Window Functions**:
    - Utilized window functions like **RANK()**, **DENSE_RANK()**, and **PARTITION BY** for ranking and segmentation.
5. **Data Cleaning**:
    - Applied **COALESCE**, **DISTINCT**, and **UPDATE** operations to clean and standardize the data.
6. **Performance Optimization**:
    - Used indexing strategies and optimized query logic to ensure efficient data retrieval.
