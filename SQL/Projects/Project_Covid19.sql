select * from CovidDeaths$

select * from CovidVaccinations$

select location,date,total_cases,new_cases,total_deaths from CovidDeaths$
order by 1,2


--Looking at Total Cases Vs  Total deaths

-- Q1 DeathPercentage in india
---show likelihood of dying if you contract covid inyour country

select location,date,total_cases,total_deaths,(total_deaths/total_cases) as DeathPercentage
from CovidDeaths$
where location like '%India%'
order by 1,2

--Looking at Total Cases Vs  Population

--Q2 Shows what percentage of population got Covid

select location,date,total_cases,population,(total_cases/population) as AffectedPercentage
from CovidDeaths$
where location like '%India%'
order by 1,2


-- Q3 Looking at countries with Highest Infection Rate comapred to Population

select location,Max(total_cases) as HighestInfectionCount,population,Max((total_cases/population))*100  as PercentPopulationInfected
from CovidDeaths$
--where location like '%India%'
group by location,   
    population
order by PercentPopulationInfected DESC


-- Q4 Showing Countries with Highest Death Count Per Population

--select location,max(total_deaths) as TotalDeathCount
--from CovidDeaths$
--group by total_deaths,location
--order by TotalDeathCount DESC

SELECT 
    location,
    MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM 
    CovidDeaths$
WHERE 
    continent IS NOT NULL
GROUP BY 
    location,continent
ORDER BY 
    TotalDeathCount DESC;

---lets break things Down by Continent 
SELECT 
    continent,
    MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM 
    CovidDeaths$
WHERE 
    continent IS NOT NULL
GROUP BY 
    continent
ORDER BY 
    TotalDeathCount DESC;




--- Q5 Showing contintents with the highest death count per population

SELECT 
    continent,
    MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM 
    CovidDeaths$
WHERE 
    continent IS NOT NULL
GROUP BY 
    continent
ORDER BY 
    TotalDeathCount DESC;

