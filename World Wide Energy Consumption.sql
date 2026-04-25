CREATE DATABASE ENERGYDB2;
USE ENERGYDB2;

-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10) PRIMARY KEY,
    Country VARCHAR(100) UNIQUE
);



-- 2. emission_3 table
CREATE TABLE emission_3 (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);


-- 3. population table
CREATE TABLE population (
    countries VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);




-- 5. gdp_3 table
CREATE TABLE gdp_3 (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);



-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM CONSUMPTION;



-- =======================================================================
-- GENERAL & COMPARATIVE ANALYSIS
-- ========================================================================


-- Q1. Total emission per country (latest year)

SELECT COUNTRY, SUM(EMISSION) AS TOTAL_EMISSION
FROM EMISSION_3
WHERE YEAR = (SELECT MAX(YEAR) FROM EMISSION_3)
GROUP BY COUNTRY
ORDER BY TOTAL_EMISSION DESC;


-- Q2. Top 5 countries by GDP (latest year)

SELECT COUNTRY, VALUE AS GDP
FROM GDP_3
WHERE YEAR = (SELECT MAX(YEAR) FROM GDP_3)
ORDER BY GDP DESC
LIMIT 5;


-- Q3. Production vs Consumption

SELECT P.COUNTRY, P.YEAR,
SUM(P.PRODUCTION) AS TOTAL_PRODUCTION,
SUM(C.CONSUMPTION) AS TOTAL_CONSUMPTION
FROM PRODUCTION P
JOIN CONSUMPTION C 
ON P.COUNTRY = C.COUNTRY AND P.YEAR = C.YEAR
GROUP BY P.COUNTRY, P.YEAR;


-- Q4. Energy types contributing most emissions

SELECT ENERGY_TYPE, SUM(EMISSION) AS TOTAL_EMISSION
FROM EMISSION_3
GROUP BY ENERGY_TYPE
ORDER BY TOTAL_EMISSION DESC;

-- ===================================================================
-- TREND ANALYSIS
-- ===================================================================


-- Q5. Global emissions year-wise

SELECT YEAR, SUM(EMISSION) AS GLOBAL_EMISSION
FROM EMISSION_3
GROUP BY YEAR
ORDER BY YEAR;


-- Q6. GDP trend per country

SELECT COUNTRY, YEAR, VALUE AS GDP
FROM GDP_3
ORDER BY COUNTRY, YEAR;


-- Q7. Population vs emissions
SELECT P.COUNTRIES, 
       P.YEAR, 
       P.VALUE AS POPULATION, 
       SUM(E.EMISSION) AS TOTAL_EMISSION
FROM POPULATION P
JOIN EMISSION_3 E
ON P.COUNTRIES = E.COUNTRY 
AND P.YEAR = E.YEAR
GROUP BY P.COUNTRIES, P.YEAR, P.VALUE;


-- Q8. Energy consumption trend

SELECT COUNTRY, YEAR, SUM(CONSUMPTION) AS TOTAL_CONSUMPTION
FROM CONSUMPTION
GROUP BY COUNTRY, YEAR
ORDER BY COUNTRY, YEAR;


-- Q9. Avg yearly change in per capita emissions

SELECT COUNTRY, AVG(PER_CAPITA_EMISSION) AS AVG_PER_CAPITA
FROM EMISSION_3
GROUP BY COUNTRY;


-- =======================================================================
-- RATIO & PER CAPITA ANALYSIS
-- =======================================================================


-- Q10. Emission to GDP ratio

SELECT E.COUNTRY, 
       E.YEAR, 
       SUM(E.EMISSION) / G.VALUE AS EMISSION_GDP_RATIO
FROM EMISSION_3 E
JOIN GDP_3 G
ON E.COUNTRY = G.COUNTRY 
AND E.YEAR = G.YEAR
GROUP BY E.COUNTRY, E.YEAR, G.VALUE;

-- Q11. Consumption per capita

SELECT C.COUNTRY, 
       C.YEAR, 
       SUM(C.CONSUMPTION) / MAX(P.VALUE) AS CONSUMPTION_PER_CAPITA
FROM CONSUMPTION C
JOIN POPULATION P
ON C.COUNTRY = P.COUNTRIES 
AND C.YEAR = P.YEAR
GROUP BY C.COUNTRY, C.YEAR;


-- Q12. Production per capita

SELECT PR.COUNTRY, 
       PR.YEAR, 
       SUM(PR.PRODUCTION) / MAX(P.VALUE) AS PRODUCTION_PER_CAPITA 
FROM PRODUCTION PR
JOIN POPULATION P
ON PR.COUNTRY = P.COUNTRIES 
AND PR.YEAR = P.YEAR
GROUP BY PR.COUNTRY, PR.YEAR;

-- Q13. Consumption relative to GDP
SELECT C.COUNTRY, 
       C.YEAR, 
       SUM(C.CONSUMPTION) / MAX(G.VALUE) AS CONSUMPTION_GDP_RATIO
FROM CONSUMPTION C
JOIN GDP_3 G
ON C.COUNTRY = G.COUNTRY 
AND C.YEAR = G.YEAR
GROUP BY C.COUNTRY, C.YEAR
ORDER BY CONSUMPTION_GDP_RATIO DESC;


-- Q14. GDP vs production growth

SELECT G.COUNTRY, 
       G.YEAR, 
       MAX(G.VALUE) AS GDP, 
       SUM(P.PRODUCTION) AS TOTAL_PRODUCTION
FROM GDP_3 G
JOIN PRODUCTION P
ON G.COUNTRY = P.COUNTRY 
AND G.YEAR = P.YEAR
GROUP BY G.COUNTRY, G.YEAR;

-- ====================================================================
-- GLOBAL COMPARISON
-- ====================================================================


-- Q15. Top 10 population countries

SELECT COUNTRIES, VALUE AS POPULATION
FROM POPULATION
WHERE YEAR = (SELECT MAX(YEAR) FROM POPULATION)
ORDER BY POPULATION DESC
LIMIT 10;


-- Q16. Emission comparison for top population countries

SELECT E.COUNTRY,
       SUM(E.EMISSION) AS TOTAL_EMISSION
FROM EMISSION_3 E
JOIN (
    SELECT COUNTRIES
    FROM POPULATION
    WHERE YEAR = (SELECT MAX(YEAR) FROM POPULATION)
    ORDER BY VALUE DESC
    LIMIT 10
) AS P
ON E.COUNTRY = P.COUNTRIES
GROUP BY E.COUNTRY;

-- Q17. Countries reducing emissions (last decade)

SELECT COUNTRY,
MAX(PER_CAPITA_EMISSION) - MIN(PER_CAPITA_EMISSION) AS REDUCTION
FROM EMISSION_3
GROUP BY COUNTRY
ORDER BY REDUCTION DESC;


-- Q18. Global emission share %

SELECT COUNTRY,
SUM(EMISSION) * 100 / (SELECT SUM(EMISSION) FROM EMISSION_3) AS SHARE_PERCENT
FROM EMISSION_3
GROUP BY COUNTRY;


-- Q19. Global averages by year
SELECT G.YEAR,
       AVG(G.VALUE) AS AVG_GDP,
       AVG(E.EMISSION) AS AVG_EMISSION,
       AVG(P.VALUE) AS AVG_POPULATION
FROM GDP_3 G
JOIN EMISSION_3 E
ON G.COUNTRY = E.COUNTRY 
AND G.YEAR = E.YEAR
JOIN POPULATION P
ON G.COUNTRY = P.COUNTRIES 
AND G.YEAR = P.YEAR
GROUP BY G.YEAR;




-- ===================================================================
-- Energy Balance Analysis
-- ===================================================================

-- Q. Show whether a country produces more energy than it consumes.
SELECT P.COUNTRY,
       P.YEAR,
       SUM(P.PRODUCTION) AS TOTAL_PRODUCTION,
       SUM(C.CONSUMPTION) AS TOTAL_CONSUMPTION,
       SUM(P.PRODUCTION) - SUM(C.CONSUMPTION) AS ENERGY_BALANCE
FROM PRODUCTION P
JOIN CONSUMPTION C
ON P.COUNTRY = C.COUNTRY
AND P.YEAR = C.YEAR
GROUP BY P.COUNTRY, P.YEAR;


-- =====================================================
-- Highest Growth in Energy Consumption
-- =====================================================

-- Q.Find countries with rapidly increasing demand.

SELECT COUNTRY,
       MAX(CONSUMPTION) - MIN(CONSUMPTION) AS CONSUMPTION_GROWTH
FROM CONSUMPTION
GROUP BY COUNTRY
ORDER BY CONSUMPTION_GROWTH DESC
LIMIT 10;


-- ==========================================================
-- Emission Growth Over Time
-- ==========================================================

-- Track pollution increase.

SELECT COUNTRY,
       MAX(EMISSION) - MIN(EMISSION) AS EMISSION_CHANGE
FROM EMISSION_3
GROUP BY COUNTRY
ORDER BY EMISSION_CHANGE DESC
LIMIT 10;

-- ================================================================
-- GDP Efficiency
-- ====================================================================

-- Check which countries generate GDP with lower emissions.

SELECT G.COUNTRY,
       AVG(G.VALUE / E.EMISSION) AS GDP_EFFICIENCY
FROM GDP_3 G
JOIN EMISSION_3 E
ON G.COUNTRY = E.COUNTRY
AND G.YEAR = E.YEAR
GROUP BY G.COUNTRY
ORDER BY GDP_EFFICIENCY DESC
limit 10;





-- =======================================================
-- Production vs Emission Efficiency
-- =========================================================
SELECT P.COUNTRY,
       SUM(P.PRODUCTION)/SUM(E.EMISSION) AS CLEAN_PRODUCTION_SCORE
FROM PRODUCTION P
JOIN EMISSION_3 E
ON P.COUNTRY = E.COUNTRY
AND P.YEAR = E.YEAR
GROUP BY P.COUNTRY
ORDER BY CLEAN_PRODUCTION_SCORE DESC
limit 10;


-- ==================================================================
-- Production vs Emission Efficiency
-- ==================================================================

-- Q. Which countries produce energy with fewer emissions.

SELECT P.COUNTRY,
       SUM(P.PRODUCTION)/SUM(E.EMISSION) AS CLEAN_PRODUCTION_SCORE
FROM PRODUCTION P
JOIN EMISSION_3 E
ON P.COUNTRY = E.COUNTRY
AND P.YEAR = E.YEAR
GROUP BY P.COUNTRY
ORDER BY CLEAN_PRODUCTION_SCORE DESC;


-- ===================================================================
--  Population Impact on Consumption
-- ====================================================================

-- Q. Shows whether larger population increases energy use.

SELECT P.COUNTRIES,
       AVG(P.VALUE) AS AVG_POPULATION,
       AVG(C.CONSUMPTION) AS AVG_CONSUMPTION
FROM POPULATION P
JOIN CONSUMPTION C
ON P.COUNTRIES = C.COUNTRY
AND P.YEAR = C.YEAR
GROUP BY P.COUNTRIES


-- ===============================================================
-- Country Ranking System
-- ================================================================

-- Q,.Create a ranking based on emissions.

SELECT COUNTRY,
       SUM(EMISSION) AS TOTAL_EMISSION,
       RANK() OVER (ORDER BY SUM(EMISSION) DESC) AS EMISSION_RANK
FROM EMISSION_3
GROUP BY COUNTRY;

-- ==================================================================
-- Yearly Global Energy Demand
-- ==================================================================

-- Global yearly consumption.

SELECT YEAR,
       SUM(CONSUMPTION) AS GLOBAL_CONSUMPTION
FROM CONSUMPTION
GROUP BY YEAR
ORDER BY YEAR;


-- =================================================================
-- Country Dependency Ratio
-- =================================================================

-- Q.Shows whether country depends more on production or imports.

SELECT P.COUNTRY,
       SUM(C.CONSUMPTION)/SUM(P.PRODUCTION) AS DEPENDENCY_RATIO
FROM PRODUCTION P
JOIN CONSUMPTION C
ON P.COUNTRY = C.COUNTRY
AND P.YEAR = C.YEAR
GROUP BY P.COUNTRY;
