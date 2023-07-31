-- Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null
order by 1, 2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where Location like '%states%'
and continent is not null
order by 1, 2


-- Looking at Total Cases vs Population
-- Shows wha percent of population has contracted Covid

Select Location, date, total_cases, population, (total_cases/population)*100 as PopulationPercent
From PortfolioProject..CovidDeaths
Where Location like '%states%'
and continent is not null
order by 1, 2


-- Looking at Countries with Highest Infection Rate compared to Population
Select Location, population, Max(total_cases) as HighestCases, Max((total_cases/population))*100 as PopulationPercent
From PortfolioProject..CovidDeaths
Where continent is not null
Group by Location, population
order by PopulationPercent desc

-- Showing Countries with the Highest Death Count per Population
Select Location, Population, Max(cast(total_deaths as int)) as TotalDeathCount, Max((cast(total_deaths as int)/population))*100 as PopulationDeathPercent
From PortfolioProject..CovidDeaths
Where continent is not null
Group by Location, population
order by PopulationDeathPercent desc


-- Showing continents with the highest death count
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
order by TotalDeathCount desc

-- Showing Continents with the Highest Death Count per Population
Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount, Population, Max((cast(total_deaths as int)/population))*100 as PopulationDeathPercent
From PortfolioProject..CovidDeaths
Where continent is null and Location <> 'World' and Population is not null
Group by Location, Population
order by PopulationDeathPercent desc



-- GLOBAL NUMBERS

Select SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
Where continent is not null
--Group By date
order by 1, 2


-- Looking at Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) 
	OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidVaccinations vac
Join PortfolioProject..CovidDeaths dea
	On dea.location = vac.location 
	and dea.date = vac.date
Where dea.continent is not null
order by 2, 3;


-- USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as int)) 
	OVER (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidVaccinations vac
Join PortfolioProject..CovidDeaths dea
	On dea.location = vac.location 
	and dea.date = vac.date
Where dea.continent is not null
)
Select *, (RollingVaccinated/Population) * 100
From PopvsVac


