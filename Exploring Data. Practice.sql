-- Explorary Data Analysis

select *
from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;


select min(`date`), max(`date`)
from layoffs_staging2;

select *
from layoffs_staging2;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select `date`, sum(total_laid_off)
from layoffs_staging2
where country = 'United States' and `date` is not null
group by `date`
order by 1 asc;

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;


with cte_roll_total as (
	select substr(`date`, 1, 7) as `month`,
    substr(`date`, 1, 4) as `year`,
    sum(total_laid_off) as sum_laid_off
	from layoffs_staging2
	group by `year`, `month`
	order by 1 asc
)
select `month`, sum_laid_off, sum(sum_laid_off) over(partition by `year` order by `month`) as rolling_total
from cte_roll_total
where `month` is not null;


select company, year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc, 2 desc
;


with company_year (company, years, total_laid_off) as(
	select company, year(`date`),sum(total_laid_off)
	from layoffs_staging2
	group by company, year(`date`)
), company_year_rank as
(
	select *,
	dense_rank() over(partition by years order by total_laid_off desc) as ranking
	from company_year
	where years is not null
)
select *
from company_year_rank
where ranking <= 5
order by years
;




