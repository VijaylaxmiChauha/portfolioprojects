SELECT *
FROM portfolioproject .. CovidDeaths
WHERE continent IS NOT null
ORDER BY 3,4

--SELECT *
--FROM portfolioproject .. Covidvaccinations
--ORDER BY 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM portfolioproject .. CovidDeaths
ORDER BY 1,2

              Total Cases Vs Total Deaths 
              
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 Deaths_Percentage
FROM portfolioproject .. CovidDeaths
WHERE location LIKE 'india' 
AND continent is not null
ORDER BY 1,2

             Total Cases Vs Population
             
SELECT location, date, population, total_cases, population, (total_cases/population)*100 Percentpopulationinfected
FROM portfolioproject .. CovidDeaths
WHERE location LIKE '%states%' 
ORDER BY 1,2       

             Countries with Highest Infection Rate Compared to Population
             
SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX((total_cases/population))*100 AS Percent_population_infected
FROM portfolioproject .. CovidDeaths
WHERE continent IS NOT null
GROUP BY  location, population
ORDER BY Percent_population_infected DESC, location               

           Countries with highest death count per population 
   
SELECT location, MAX(CAST(total_deaths AS int )) AS total_deaths_count
FROM portfolioproject .. CovidDeaths
WHERE continent IS NOT null
GROUP BY  location
ORDER BY total_deaths_count DESC           

              Continents with highest death count per population
   
SELECT continent, MAX(CAST(total_deaths AS int )) AS total_deaths_count
FROM portfolioproject .. CovidDeaths
WHERE continent IS not null
GROUP BY  continent
ORDER BY total_deaths_count DESC   

              Global nunbers  

SELECT date, SUM(new_cases) AS total_cases, SUM(CAST(new_deaths as int)) AS total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 Deaths_Percentage
FROM portfolioproject .. CovidDeaths 
WHERE continent is not null
GROUP BY date
ORDER BY 1,2   
 
                  Total population Vs vaccinations                 
 
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
  SUM(CONVERT(INT,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS rolling_people_vaccinated
FROM portfolioproject .. CovidDeaths cd
JOIN portfolioproject .. CovidVaccinations cv
     ON cd.location = cv.location 
     AND cd.date = cv.date
     WHERE cd.continent is not null
     ORDER BY 2,3                         
     
                   With CTE
     
WITH popvsvac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated )     
AS 
(
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
  SUM(CONVERT(INT,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS rolling_people_vaccinated
FROM portfolioproject .. CovidDeaths cd
JOIN portfolioproject .. CovidVaccinations cv
     ON cd.location = cv.location 
     AND cd.date = cv.date
WHERE cd.continent is not null
--ORDER BY 2,3 
)
SELECT *, (rolling_people_vaccinated/population)*100
FROM popvsvac    
  
          --  Temp table
          
Create Table  #percentpopulationvaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccination numeric,
rolling_people_vaccinated numeric
) 
        
INSERT INTO #percentpopulationvaccinated              
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
  SUM(CONVERT(INT,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS rolling_people_vaccinated
FROM portfolioproject .. CovidDeaths cd
JOIN portfolioproject .. CovidVaccinations cv
     ON cd.location = cv.location 
     AND cd.date = cv.date
WHERE cd.continent is not null
--ORDER BY 2,3                
               
SELECT *, (rolling_people_vaccinated/population)*100
FROM #percentpopulationvaccinated                

       -- Creat view 
       
Create View percentpopulationvaccinated AS       
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
  SUM(CONVERT(INT,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS rolling_people_vaccinated
FROM portfolioproject .. CovidDeaths cd
JOIN portfolioproject .. CovidVaccinations cv
     ON cd.location = cv.location 
     AND cd.date = cv.date
WHERE cd.continent is not null
--ORDER BY 2,3        

SELECT *
FROM percentpopulationvaccinated