# World Wide Energy Consumption Analysis Using SQL

## Overview

The World Wide Energy Consumption project is a structured SQL-based analytical database designed to study global energy trends across countries and years. The system integrates energy production, energy consumption, carbon emissions, GDP, and population datasets to support comparative analysis and decision-making.

This project demonstrates how relational databases can be used to organize large-scale energy datasets and generate meaningful insights through SQL queries.

---

# Project Objectives

The project focuses on the following objectives:

* Design a relational database to manage worldwide energy-related data
* Analyze production, consumption, emissions, GDP, and population relationships
* Compare energy performance across countries and years
* Measure per-capita and ratio-based indicators
* Identify global energy trends and environmental impact
* Build an analytical SQL project suitable for academic and portfolio purposes

---

# Technologies Used

* SQL / MySQL
* Relational Database Design
* Entity Relationship Modeling
* Data Analysis using SQL Queries
* Foreign Key Relationships

---

# Database Information

**Database Name:** `ENERGYDB2`

The database contains multiple interconnected tables designed to support global energy analytics.

---

# Database Schema

## 1. Country Table

Stores the master list of countries used throughout the database.

| Column  | Description       |
| ------- | ----------------- |
| CID     | Unique Country ID |
| Country | Country Name      |

---

## 2. Emission Table (`emission_3`)

Contains country-wise emissions categorized by energy type and year.

| Column              | Description          |
| ------------------- | -------------------- |
| country             | Country Name         |
| energy_type         | Energy Category      |
| year                | Reporting Year       |
| emission            | Total Emission Value |
| per_capita_emission | Emission per Person  |

---

## 3. Population Table (`population`)

Stores yearly population records.

| Column    | Description    |
| --------- | -------------- |
| countries | Country Name   |
| year      | Reporting Year |
| value     | Population     |

---

## 4. Production Table (`production`)

Tracks country-wise energy production.

| Column     | Description     |
| ---------- | --------------- |
| country    | Country Name    |
| energy     | Energy Type     |
| year       | Reporting Year  |
| production | Produced Energy |

---

## 5. GDP Table (`gdp_3`)

Stores economic performance data for each country.

| Column  | Description    |
| ------- | -------------- |
| country | Country Name   |
| year    | Reporting Year |
| value   | GDP Value      |

---

## 6. Consumption Table (`consumption`)

Contains energy consumption details by country and year.

| Column      | Description     |
| ----------- | --------------- |
| country     | Country Name    |
| energy      | Energy Category |
| year        | Reporting Year  |
| consumption | Energy Consumed |

---

# Key Features

* Global energy production and consumption analysis
* Emission tracking and environmental analysis
* GDP and population comparison
* Per-capita performance indicators
* Ratio-based analytics
* Trend analysis across years
* Country-level comparison and ranking

---

# Analytical Modules

## General Analysis

* Total emissions by country
* Top GDP-performing countries
* Production vs consumption comparison
* Highest contributing energy sources to emissions

## Trend Analysis

* Global emission trends over time
* GDP changes across years
* Population vs emission relationships
* Energy consumption trends

## Ratio and Per-Capita Analysis

* Emission-to-GDP ratio
* Consumption per capita
* Production per capita
* Consumption relative to GDP

## Global Comparative Analysis

* Top population countries
* Emission comparison among large populations
* Emission reduction patterns
* Global yearly averages

---

# Database Relationships

The project follows a relational database structure.

### Primary Relationships

* Country → Emission
* Country → Population
* Country → Production
* Country → GDP
* Country → Consumption

Country and year fields act as linking attributes across multiple tables.

Foreign key constraints ensure consistency and integrity throughout the database.

---

# Project Workflow

1. Create database and tables
2. Define foreign key relationships
3. Import datasets
4. Execute SQL analytical queries
5. Generate comparative insights
6. Interpret global energy patterns

---

# Key Insights Generated

The project helps identify:

* Countries with the highest emissions
* Nations with strong GDP but high energy dependency
* Energy production versus consumption balance
* Population influence on energy demand
* Global trends in energy usage and emissions
* Country-wise environmental performance

---

# Project Benefits

* Demonstrates SQL and database design skills
* Supports analytical problem-solving
* Provides real-world data analysis experience
* Useful for portfolio, academic submission, and GitHub showcase

---

# Future Scope

Future enhancements may include:

* Dashboard integration using Power BI or Tableau
* Renewable energy analysis
* Data visualization reports
* Predictive trend modeling
* Automated reporting system

---

# Conclusion

The World Wide Energy Consumption project presents a structured approach to analyzing worldwide energy and economic data through SQL. By combining emissions, production, consumption, GDP, and population datasets, the system provides meaningful insights into global energy behavior.

The project highlights database design principles, relational modeling, query optimization, and analytical reporting.

---

# Author

Developed as a SQL Database Analytics Project for educational, analytical, and portfolio purposes.
