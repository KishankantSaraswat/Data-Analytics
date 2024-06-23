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

---Global Number

select sum(new_cases) as totalCases,sum(cast(new_deaths as int)) as totalDeaths,  sum(cast(new_deaths as int))/sum(New_cases)*100 as DeathPercentage--total_cases,total_deaths,(total_deaths/total_cases) as DeathPercentage
from CovidDeaths$
--where location like '%India%'
where continent is not null
--group by date
order by 1,2


----------------------------------------------------------------------------------------------------------------------------------------

select * from CovidVaccinations$

select * from CovidDeaths$
Join CovidVaccinations$
On CovidDeaths$.location=CovidVaccinations$.location
and CovidDeaths$.date=CovidVaccinations$.date


--Looking at Total Population vs Vaccinations

SELECT 
    cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations,
    SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS RollingPeopleVaccinated,
    (SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) / cd.population) * 100 AS VaccinationPercentage
FROM 
    CovidDeaths$ AS cd
JOIN 
    CovidVaccinations$ AS cv
ON 
    cd.location = cv.location
AND 
    cd.date = cv.date
WHERE 
    cd.continent IS NOT NULL
ORDER BY 
    cd.location, cd.date;



---Using CTE

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) AS
(
    SELECT 
        cd.continent,
        cd.location,
        cd.date,
        cd.population,
        cv.new_vaccinations,
        SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.date) AS RollingPeopleVaccinated
    FROM
        CovidDeaths$ AS cd
    JOIN 
        CovidVaccinations$ AS cv
    ON 
        cd.location = cv.location
        AND cd.date = cv.date
    WHERE 
        cd.continent IS NOT NULL
)
SELECT *,(RollingPeopleVaccinated/Population)*100
FROM PopvsVac;



---Temp Table
drop table if exists #PercentPopulationVaccinated
create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT 
        cd.continent,
        cd.location,
        cd.date,
        cd.population,
        cv.new_vaccinations,
        SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.date) AS RollingPeopleVaccinated
    FROM
        CovidDeaths$ AS cd
    JOIN 
        CovidVaccinations$ AS cv
    ON 
        cd.location = cv.location
        AND cd.date = cv.date
    WHERE 
        cd.continent IS NOT NULL


SELECT *,(RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated;


--creating view to store data for later visualizations

create view PercentPopulationVaccinated as
SELECT 
        cd.continent,
        cd.location,
        cd.date,
        cd.population,
        cv.new_vaccinations,
        SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.date) AS RollingPeopleVaccinated
    FROM
        CovidDeaths$ AS cd
    JOIN 
        CovidVaccinations$ AS cv
    ON 
        cd.location = cv.location
        AND cd.date = cv.date
    WHERE 
        cd.continent IS NOT NULL

select * from PercentPopulationVaccinated


