--Select *
--From SuicideProject..suicide


-- LOOKING AT DATA FOR THE ENTIRE WORLD
-- With This dataset I want to focus on the years between 2000-2010

-- Looking at the number of suicides across all countries between 2000-2010 by sex
Select Sex, Year, SUM(suicides_num) as Num_Suicides
From SuicideProject..suicide
Where Year >= 2000 and Year <= 2010
Group by Sex, Year
Order by Year


-- Looking at the country with the highest amount of suicides in the year 2010
Select Country, Year, SUM(suicides_num) as Num_Suicides, SUM(population) as Population, SUM(suicides_num)/SUM(Population)*100000 as suicides_per_100k
From SuicideProject..suicide
Where Year = 2010
Group by Country, Year
Order by suicides_per_100k desc


-- Checking which generation has the highest suidcide rate throughout the whole world in the year 2010
--Select Year, Generation, SUM(suicides_num) as Num_Suicides, SUM(population) as Population, SUM(suicides_num)/SUM(Population)*100000 as suicides_per_100k
--From SuicideProject..suicide
--Where Year = 2010
--Group by Year, Generation
--Order by suicides_per_100k desc


-- Looking to find what age group has the highest amount of suicides between the years 2000-2010
Select Age, Generation, SUM(suicides_num) as Num_Suicides
From SuicideProject..suicide
Where Year >= 2000 and Year <= 2010
Group by Age, Generation
Order by Age


-- Looking to find a coorelation between suicide rates and gdp of the given country in the year 2010
Select Country, [gdp_per_capita ($)] as gdp_per_capita, SUM(suicides_num)/SUM(population) as suicides_per_100k
From SuicideProject..suicide
Where Year = 2010 and Country like 'lux%'
Group by Country, [gdp_per_capita ($)]
Order by gdp_per_capita, suicides_per_100k desc


-- Between the years of 2000-2010 what age group had the highest amount of suicides between both sexes
--Select Sex, MAX(suicides_num) as Num_Suicides
--From SuicideProject..suicide
--Where Year >= 2000 and Year <= 2010
--Group by Sex
--Order by Num_Suicides desc
Select Sex, Age, Year, SUM(Suicides_Num) as Num_Suicides
From SuicideProject..suicide
Where Year >= 2000 and Year <= 2010
Group by Sex, Age, Year
Order by Num_Suicides desc