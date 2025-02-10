## COVID Deaths Project ##
This project provides a comprehensive analysis of global COVID-19 data, focusing on key metrics like total cases, deaths, vaccination rates, and infection rates across different countries. The goal is to use data-driven insights to better understand the pandemic's impact on public health and compare various regions based on COVID-19 statistics.

Features
Total Cases vs Total Deaths: Analyze the relationship between the total number of COVID-19 cases and the number of deaths globally and per country.
Countries with Highest Infection Rate vs Population: Compare infection rates (cases per 100,000 people) across countries and relate it to the population size.
Countries with Highest Death Count per Population: Identify countries with the highest death rates per capita due to COVID-19.
Total Population vs Vaccinations: Compare total population size against the number of people vaccinated to analyze vaccination coverage and its effect.

Data Sources
This project uses publicly available COVID-19 data, which includes:

1. Confirmed Cases: Total number of reported COVID-19 cases per country.
2. Deaths: Total number of deaths attributed to COVID-19 in each country.
3. Vaccination Data: Number of people vaccinated in each country.
4. Population Data: The population size of each country.

Database Structure
1. Countries: Contains information about each country.
   Columns: country_id, country_name, population, etc.
2. COVID_Statistics: Records of COVID-19 statistics by country.
   Columns: country_id, total_cases, total_deaths, total_vaccinated, date_reported, etc.   
