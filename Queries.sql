Select * from CovidDeaths 
order by 3,4

Select * from CovidTests

-- Select data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population  from CovidDeaths order by 1,2

--Total cases vs Total deaths

Select location, date, total_cases, total_deaths, (CAST(total_deaths AS float) / NULLIF(CAST(total_cases AS float), 0)) * 100 AS DeathPercentage
from CovidDeaths 
Where location like '%tuni%' 
and continent is not null
order by 1,2


-- Looking at the total cases vs the population
-- Show what percentage of population got covid
Select location, date, total_cases, population, (CAST(total_cases AS float) / NULLIF(CAST(population AS float), 0)) * 100 AS PercentOfPopulation
from CovidDeaths 
Where location like '%tuni%'
order by 1,2


-- Looking at countries with highest infection rate compared to population

Select location, population, MAX(CAST(total_cases AS float)) as HighestInfectionCount, MAX(CAST(total_cases AS float) / NULLIF(CAST(population AS float), 0)) * 100 AS PercentOfPopulation
from CovidDeaths 
--Where location like '%tuni%'
Group By location, population
order by PercentOfPopulation DESC

--Showing the countries with highest death count per population
Select location, MAX(CAST(CAST(total_deaths AS float) AS int)) as TotalDeathCount
from CovidDeaths 
Where location <> 'World'
Group By location
order by TotalDeathCount DESC

--Showing the continents with the highest death count

Select * from CovidDeaths 
order by 3,4

Select continent, SUM(CAST(total_deaths AS float)) as TotalDeathCount
from CovidDeaths 
Where continent <> ''
Group By continent
order by TotalDeathCount DESC

--Global numbers

Select  date, SUM(CAST(new_cases as float)) as TotalCases, SUM(CAST(new_deaths as float)) as TotalDeaths,  (SUM(CAST(new_deaths as float)) / SUM(NULLIF(CAST(new_cases as float), 0))) * 100 as DeathPercentage
from CovidDeaths 
Where continent <> ''
Group by date
order by 1,2

Select  SUM(CAST(new_cases as float)) as TotalCases, SUM(CAST(new_deaths as float)) as TotalDeaths,  (SUM(CAST(new_deaths as float)) / SUM(NULLIF(CAST(new_cases as float), 0))) * 100 as DeathPercentage
from CovidDeaths 
Where continent <> ''
--Group by date
order by 1,2

-- Looking at total population vs tests

-- USE CTE

with PopulaTests (continent, location, date, population,new_tests, RollingPeopleTests)
as (
Select det.continent, det.location, det.date, det.population, test.new_tests
, SUM(CONVERT(float, test.new_tests)) OVER (Partition by det.location order by det.location, det.date) as RollingPeopleTests
from CovidDeaths det
join CovidTests test
	ON det.location = test.location
	and det.date = test.date
where det.continent <> ''
--order by 2,3
)
select *, (RollingPeopleTests/population) * 100 as percentage from PopulaTests


--with Temp table
DROP TABLE if exists #PercentagePopulationTests
Create Table #PercentagePopulationTests
(
Continent nvarchar(255), 
Location nvarchar(255),
Date datetime,
Population numeric,
New_Tests numeric,
RollingPeopleTests numeric
)

Insert into #PercentagePopulationTests
Select det.continent, det.location, det.date, CONVERT(float, det.population), CONVERT(float, test.new_tests)
, SUM(CONVERT(float, test.new_tests)) OVER (Partition by det.location order by det.location, det.date) as RollingPeopleTests
from CovidDeaths det
join CovidTests test
	ON det.location = test.location
	and det.date = test.date
where det.continent <> ''
--order by 2,3

select *, (RollingPeopleTests/population) * 100 as percentage from #PercentagePopulationTests

-- creating new view to store data for later visualisation

Create View PercentPopulationTestsView as 
Select det.continent, det.location, det.date, CONVERT(float, det.population) as population, CONVERT(float, test.new_tests) as new_tests
, SUM(CONVERT(float, test.new_tests)) OVER (Partition by det.location order by det.location, det.date) as RollingPeopleTests
from CovidDeaths det
join CovidTests test
	ON det.location = test.location
	and det.date = test.date
where det.continent <> '' 
--order by 2,3


select * from PercentPopulationTestsView