Select *
from [PortfolioProject ]..CovidDeaths$
order by 3, 4

--select *
--from [PortfolioProject ]..CovidVaccination$
--order by 3, 4

--Select the data we are going to be using 

Select location, date, total_cases, new_cases, total_deaths, population
from [PortfolioProject ]..CovidDeaths$
order by 1, 2

--looking at Total Cases vs Total Deaths 
--shows the likelihood of dying if you get covid in the United states
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercantage
from [PortfolioProject ]..CovidDeaths$
where location like '%states%'
order by 1, 2

--Looking at Total cases vs Population 
--shows what percentae has got covid 
Select location, date, total_cases, population, (total_cases/population)*100 as percentpopulationinfected
from [PortfolioProject ]..CovidDeaths$
where location like '%states%'
order by 1, 2

--Looking at countries with the highest infection rate
Select location, population, max(total_cases) as highestinfectioncount, MAX((total_cases/population))*100 as percentpopulationinfected
from [PortfolioProject ]..CovidDeaths$
--where location like '%states%'
group by location, population
order by percentpopulationinfected desc

--showing the countries with the highest death count per population 
Select location, max(cast(total_deaths as int)) as totaldeathcount
from [PortfolioProject ]..CovidDeaths$
--where location like '%states%'
where continent is not null
group by location
order by totaldeathcount desc

--LETS BREAK THINGS DOWN BY CONTINENT 


--showing the continent with the highest death count per population

Select continent, max(cast(total_deaths as int)) as totaldeathcount
from [PortfolioProject ]..CovidDeaths$
--where location like '%states%'
where continent is not null
group by continent
order by totaldeathcount desc

--GLOBAL NUMBERS
Select date, sum(new_cases), sum(cast(new_deaths as int )),sum(cast(new_deaths as int ))/ sum(new_cases) *100 as DeathPercentage
from [PortfolioProject ]..CovidDeaths$
--where location like '%states%'
where continent is not null
group by date
order by 1, 2

Select sum(new_cases), sum(cast(new_deaths as int )),sum(cast(new_deaths as int ))/ sum(new_cases) *100 as DeathPercentage
from [PortfolioProject ]..CovidDeaths$
--where location like '%states%'
where continent is not null
--group by date
order by 1, 2

--looking at Total Population vs Vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(convert (int, vac.new_vaccinations)) Over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [PortfolioProject ]..CovidDeaths$ dea
Join [PortfolioProject ]..CovidVaccination$ vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2, 3

--USE CTE

with PopvsVac (Continent, location, Date, Population,new_vaccinations, RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, Sum(convert (int, vac.new_vaccinations)) Over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [PortfolioProject ]..CovidDeaths$ dea
Join [PortfolioProject ]..CovidVaccination$ vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2, 3
)
select *, (RollingPeopleVaccinated/ Population)*100
from PopvsVac

--Temp Table 
Drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
location  nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, Sum(convert (int, vac.new_vaccinations)) Over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [PortfolioProject ]..CovidDeaths$ dea
Join [PortfolioProject ]..CovidVaccination$ vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2, 3

select *, (RollingPeopleVaccinated/ Population)*100
from #PercentPopulationVaccinated

--Creating view to store data for later visualization 

Create View PercentPopulationVaccinate as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, Sum(convert (int, vac.new_vaccinations)) Over (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from [PortfolioProject ]..CovidDeaths$ dea
Join [PortfolioProject ]..CovidVaccination$ vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2, 3

Select *
From PercentPopulationVaccinated




CREATE VIEW GlobalNumbers AS
SELECT 
    date,
    SUM(new_cases) AS TotalNewCases,
    SUM(CAST(new_deaths AS INT)) AS TotalNewDeaths,
    (SUM(CAST(new_deaths AS INT)) * 100.0 / NULLIF(SUM(new_cases), 0)) AS DeathPercentage
FROM [PortfolioProject]..CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY date;
-- ORDER BY date;
