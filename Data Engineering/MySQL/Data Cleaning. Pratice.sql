-- Data Cleaning

select *
from layoffs;


-- 1 Remove Duplicates
-- 2 Standardize the Data
-- 3 Null Values or blank values
-- 4 Remove any columns


create table layoffs_staging
like layoffs;

insert layoffs_staging
select *
from layoffs;

with cte_duplicated as (
	select *,
	row_number()
    over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
    as row_num
	from layoffs_staging
)
select *
from cte_duplicated
where row_num > 1;

select *
from layoffs_staging
where company = 'Casper';

with cte_duplicated as (
	select *,
	row_number()
    over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
    as row_num
	from layoffs_staging
)
delete
from cte_duplicated
where row_num > 1; -- doesn't work with CTEs

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_staging2
select *,
	row_number()
    over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
    as row_num
	from layoffs_staging;
    
    
delete
from layoffs_staging2 
where row_num > 1;
-- Deleted duplicates

-- Standardizing data

select distinct company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);
    
select distinct industry
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct location
from layoffs_staging2
order by 1; -- looks normal


select distinct country
from layoffs_staging2
where country like 'United States%'
order by 1;

select distinct country, trim(trailing '.' from country) -- (leading), (both)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;


select *
from layoffs_staging2;

-- nulls and blanks

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select distinct industry
from layoffs_staging2;

select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2
where company like 'Bally%';


select st1.industry, st2.industry
from layoffs_staging2 st1
inner join layoffs_staging2 st2
	on st1.company = st2.company
    and st1.location = st2.location
where (st1.industry is null or st1.industry = '')
and st2.industry is not null;

update layoffs_staging2
set industry = null
where industry = '';

update layoffs_staging2 st1
inner join layoffs_staging2 st2
	on st1.company = st2.company
    and st1.location = st2.location
set st1.industry = st2.industry
where st1.industry is null
and st2.industry is not null; 
-- all possible nulls has been deleted

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num























