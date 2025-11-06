# COVID-19 Data Exploration Using SQL

This project focuses on exploring global COVID-19 data through SQL-based data analysis.
Using data from the CovidDeaths and CovidVaccination tables, I analyzed infection rates, death ratios, and vaccination progress across countries and continents. The goal was to uncover meaningful insights from large datasets using advanced SQL techniques.

# Project Overview

The analysis demonstrates the use of Structured Query Language (SQL) to clean, explore, and model real-world data.
It showcases how SQL can be used to identify key patterns and relationships in pandemic data, such as:

Death rates relative to confirmed cases

Infection rates relative to population size

Regional comparisons of COVID-19 spread and impact

Vaccination progress and its effect over time

# Objectives

Explore COVID-19 case, death, and vaccination data across global regions.

Measure and compare infection and death percentages.

Identify countries and continents with the highest reported impact.

Analyze global and regional vaccination progress.

Create reusable data views to support future visualization or reporting.

# Process Summary

Data Cleaning & Preparation
Ensured numeric consistency, handled null values, and standardized fields for accurate aggregation.

Data Exploration
Investigated case and death statistics to reveal infection and fatality rates across different countries and continents.

Aggregation & Grouping
Summarized data to calculate global totals, death ratios, and rolling vaccination figures over time.

Joins & Relationships
Connected case data with vaccination data using location and date to create a complete analytical view.

Advanced SQL Techniques
Utilized Common Table Expressions (CTEs), temporary tables, and window functions to calculate cumulative vaccination metrics and derive population-level insights.

View Creation
Developed views to streamline reporting and visualization in external tools such as Power BI or Tableau.

# Key Insights

Countries with larger populations didn’t always have the highest infection percentages.

Some continents showed significantly higher death rates, emphasizing healthcare disparities.

Global vaccination efforts increased steadily, with noticeable variations in rollout speed across regions.

The use of rolling calculations helped visualize real-time vaccination progress as a share of each country’s population.

# Tools & Skills Used

SQL Server (T-SQL)

Data Cleaning and Transformation

Aggregations & Analytical Functions

CTEs, Temporary Tables, and Views

Data Modeling for Visualization
