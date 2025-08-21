CREATE DATABASE COVID_19;
USE COVID_19;

##create a table with appropriate data types
CREATE TABLE covid_data (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    total_cases INT,
    new_cases INT,
    total_deaths INT,
    new_deaths INT,
    reproduction_rate DECIMAL(5,2),
    icu_patients INT,
    hosp_patients INT,
    total_tests INT,
    new_tests INT,
    positive_rate DECIMAL(5,2),
    total_vaccinations DECIMAL(20,2),
    people_vaccinated BIGINT,
    people_fully_vaccinated BIGINT,
    total_boosters BIGINT,
    new_vaccinations BIGINT,
    gdp_per_capita INT,
    population BIGINT
);

SET GLOBAL local_infile = on;

ALTER TABLE covid_data MODIFY COLUMN total_vaccinations BIGINT UNSIGNED;
ALTER TABLE covid_data MODIFY COLUMN people_vaccinated BIGINT UNSIGNED;
ALTER TABLE covid_data MODIFY COLUMN people_fully_vaccinated BIGINT UNSIGNED;
ALTER TABLE covid_data MODIFY COLUMN total_boosters BIGINT UNSIGNED;
ALTER TABLE covid_data MODIFY COLUMN new_vaccinations BIGINT UNSIGNED;
ALTER TABLE covid_data MODIFY COLUMN total_tests BIGINT UNSIGNED;
ALTER TABLE covid_data MODIFY COLUMN new_tests BIGINT UNSIGNED;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Covid-19.csv'
INTO TABLE covid_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SHOW VARIABLES LIKE 'secure_file_priv';

SELECT * FROM covid_19.covid_data;

## Total COVID Cases Per Country
	SELECT 
    location,
    CASE
        WHEN SUM(total_cases) >= 1000000000 THEN CONCAT(ROUND(SUM(total_cases) / 1000000000, 2), 'B')
        WHEN SUM(total_cases) >= 1000000 THEN CONCAT(ROUND(SUM(total_cases) / 1000000, 2), 'M')
        ELSE CAST(SUM(total_cases) AS CHAR)
    END AS total_cases
	FROM covid_data
	GROUP BY location
	ORDER BY SUM(total_cases) DESC;
    
    SELECT 
    location,
    CASE
        WHEN SUM(total_cases) >= 1000000000 THEN CONCAT(ROUND(SUM(total_cases) / 1000000000, 2), 'B')
        WHEN SUM(total_cases) >= 1000000 THEN CONCAT(ROUND(SUM(total_cases) / 1000000, 2), 'M')
        ELSE CAST(SUM(total_cases) AS CHAR)
    END AS total_cases
	FROM covid_data
	WHERE location NOT IN (
		'World',
		'High-income countries',
		'Upper-middle-income countries',
		'European Union (27)',
		'North America',
		'Lower-middle-income countries',
		'South America',
		'Africa',
        'Asia',
        'Europe',
		'Oceania',
		'Low-income countries'
		-- Add more aggregate/region names here as needed
	)
	GROUP BY location
	ORDER BY SUM(total_cases) DESC;

## Total Cases and Deaths Globally
	
    SELECT 
    CASE 
        WHEN SUM(total_cases) >= 1000000000 
            THEN CONCAT(ROUND(SUM(total_cases) / 1000000000, 2), ' B')
        ELSE 
            CONCAT(ROUND(SUM(total_cases) / 1000000, 2), ' M')
    END AS total_cases_worldwide,
    
    CASE 
        WHEN SUM(total_deaths) >= 1000000000 
            THEN CONCAT(ROUND(SUM(total_deaths) / 1000000000, 2), ' B')
        ELSE 
            CONCAT(ROUND(SUM(total_deaths) / 1000000, 2), ' M')
    END AS total_deaths_worldwide,
    
    ROUND(SUM(total_deaths) / SUM(total_cases) * 100, 2) AS global_cfr_percent
	FROM covid_data
	WHERE continent IS NOT NULL;
    
## Top 10 Countries by Total Cases
	
    SELECT 
    location,
    MAX(total_cases) AS total_cases
	FROM covid_data
	WHERE location NOT IN (
		'World',
		'High-income countries',
		'Upper-middle-income countries',
		'European Union (27)',
		'North America',
		'Lower-middle-income countries',
		'South America',
		'Africa',
        'Asia',
        'Europe',
		'Oceania',
		'Low-income countries'
		-- Add more aggregate/region names here as needed
	)
	GROUP BY location
	ORDER BY sum(total_cases) DESC
	LIMIT 10;
    
## Countries with the Highest Death Rate
	SELECT 
    location,
    MAX(total_deaths) AS highest_deaths,
    (MAX(total_deaths) / MAX(total_cases)) * 100 AS death_rate_percentage
	FROM covid_data
	WHERE location NOT IN (
		'World',
		'High-income countries',
		'Upper-middle-income countries',
		'European Union (27)',
		'North America',
		'Lower-middle-income countries',
		'South America',
		'Africa',
        'Asia',
        'Europe',
		'Oceania',
		'Low-income countries'
		-- Add more aggregate/region names here as needed
	)
	GROUP BY location
	ORDER BY death_rate_percentage DESC
	LIMIT 10;

## Daily New Cases for a Specific Country

	SELECT 
    'India' AS location,
    SUM(new_cases) AS total_cases
	FROM 
		covid_data
	WHERE 
		location = 'India';
        
-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

    Select location, date, population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
	From covid_data
	Where location like '%states%'
	order by 1,2;
    
-- Countries with Highest Infection Rate compared to Population

	Select location, population, MAX(total_cases) as HighestInfectionCount,  round(Max((total_cases/population))*100,1) as PercentPopulationInfected
	From covid_data
	WHERE location NOT IN (
		'World',
		'High-income countries',
		'Upper-middle-income countries',
		'European Union (27)',
		'North America',
		'Lower-middle-income countries',
		'South America',
		'Africa',
        'Asia',
        'Europe',
		'Oceania',
		'Low-income countries'
	)
	Group by location, population
	order by PercentPopulationInfected desc;
    
-- Countries with Highest Death Count per Population

	Select Location, MAX(total_deaths) as TotalDeathCount
	From covid_data
	WHERE location NOT IN (
		'World',
		'High-income countries',
		'Upper-middle-income countries',
		'European Union (27)',
		'North America',
		'Lower-middle-income countries',
		'South America',
		'Africa',
        'Asia',
        'Europe',
		'Oceania',
		'Low-income countries'
	)
	Group by Location
	order by TotalDeathCount desc;
    
-- Showing contintents with the highest death count per population

	Select continent, MAX(total_deaths) as TotalDeathCount
	From covid_data
	Where continent not in('World','Global')
	Group by continent
	order by TotalDeathCount desc;

-- GLOBAL NUMBERS
	SELECT 
    continent,
    location,
    date,
    SUM(IFNULL(new_cases, 0)) AS total_cases,
    SUM(IFNULL(new_deaths, 0)) AS total_deaths,
    round(
    IFNULL(
        (SUM(IFNULL(new_deaths, 0)) / NULLIF(SUM(IFNULL(new_cases, 0)), 0)) * 100,
        0),2
    ) AS DeathPercentage
	FROM 
		covid_data
	WHERE 
		continent not in('World','Global')
		AND location NOT IN (
			'World',
			'High-income countries',
			'Upper-middle-income countries',
			'European Union (27)',
			'North America',
			'Lower-middle-income countries',
			'South America',
			'Africa',
			'Asia',
			'Europe',
			'Oceania',
			'Low-income countries'
		)
	GROUP BY 
		continent, location, date
	ORDER BY 
		continent, location, date;


-- Total Population vs Vaccinations
	SELECT 
		location,
		population,
		SUM(IFNULL(new_vaccinations, 0)) AS total_vaccinations
	FROM 
		covid_data
	WHERE 
		location NOT IN (
			'World',
			'High-income countries',
			'Upper-middle-income countries',
			'European Union (27)',
			'North America',
			'Lower-middle-income countries',
			'South America',
			'Africa',
			'Asia',
			'Europe',
			'Oceania',
			'Low-income countries'
		)
		AND continent NOT IN ('World', 'Global')
	GROUP BY 
		location, population
	ORDER BY 
		total_vaccinations DESC;

