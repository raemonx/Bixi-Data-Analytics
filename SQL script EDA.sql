
-- summary statistics for numerical columns in the latest data.
WITH LatestData AS (
    SELECT *
    FROM bixi_station_data
    WHERE last_updated = (SELECT MAX(last_updated) FROM bixi_station_data)
)
SELECT
    MIN(num_bikes_available) AS Min_Bikes_Available,
    MAX(num_bikes_available) AS Max_Bikes_Available,
    AVG(num_bikes_available) AS Avg_Bikes_Available,
    MIN(num_ebikes_available) AS Min_Ebikes_Available,
    MAX(num_ebikes_available) AS Max_Ebikes_Available,
    AVG(num_ebikes_available) AS Avg_Ebikes_Available,
    MIN(num_docks_available) AS Min_Docks_Available,
    MAX(num_docks_available) AS Max_Docks_Available,
    AVG(num_docks_available) AS Avg_Docks_Available
FROM LatestData;

-- Analyzing the distribution of available bikes and docks
WITH LatestData AS (
    SELECT *
    FROM bixi_station_data
    WHERE last_updated = (SELECT MAX(last_updated) FROM bixi_station_data)
)
SELECT
    station_id,
    name,
    num_bikes_available,
    COUNT(*) AS Frequency
FROM LatestData
GROUP BY num_bikes_available,station_id,name
ORDER BY num_bikes_available DESC;

WITH LatestData AS (
    SELECT *
    FROM bixi_station_data
    WHERE last_updated = (SELECT MAX(last_updated) FROM bixi_station_data)
)
SELECT
    station_id,
    name,
    num_docks_available
FROM LatestData
GROUP BY num_docks_available,station_id,name
ORDER BY num_docks_available DESC;

-- Stations with highest and lowest bike availability in the latest update
WITH LatestData AS (
    SELECT TOP 10 WITH TIES
        station_id,
        name,
        num_bikes_available
    FROM bixi_station_data
    WHERE last_updated = (SELECT MAX(last_updated) FROM bixi_station_data)
    ORDER BY num_bikes_available DESC
)
SELECT
    station_id,
    name,
    num_bikes_available
FROM LatestData;

-- Stations with highest and lowest dock availability in the latest update
WITH LatestData AS (
    SELECT TOP 10 WITH TIES
        station_id,
        name,
        num_docks_available
    FROM bixi_station_data
    WHERE last_updated = (SELECT MAX(last_updated) FROM bixi_station_data)
    ORDER BY num_docks_available DESC
)
SELECT
    station_id,
    name,
    num_docks_available
FROM LatestData;

-- Ratio of bikes to docks in the latest update
WITH LatestData AS (
    SELECT *
    FROM bixi_station_data
    WHERE last_updated = (SELECT MAX(last_updated) FROM bixi_station_data)
)
SELECT
    station_id,
    name,
    num_bikes_available,
    num_docks_available,
    CASE
        WHEN num_docks_available > 0 THEN CAST(num_bikes_available AS FLOAT) / (num_docks_available + num_bikes_available)
        ELSE 0
    END AS Bike_Dock_Ratio
FROM LatestData
ORDER BY Bike_Dock_Ratio DESC;

-- Stations with no docks available in the latest update
SELECT
    station_id,
    name,
    num_docks_available
FROM bixi_station_data
WHERE last_updated = (SELECT MAX(last_updated) FROM bixi_station_data)
    AND num_docks_available = 0;