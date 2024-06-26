-- bai tap 1: query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer
select b.continent, floor(avg(a.population))
from city as a
JOIN country as b
on a.countrycode = b.code
group by b.continent
-- bai tap 2: Write a query to find the activation rate. Round the percentage to 2 decimal places.
SELECT 
  ROUND(cast(sum(case when a.signup_action='Confirmed' then 1 else 0 end) AS DECIMAL)/
cast(count(DISTINCT(b.email_id)) as decimal),2)
from texts as a
RIGHT JOIN emails as b 
ON a.email_id=b.email_id
-- bai tap 3: 
SELECT a.age_bucket,
ROUND(SUM(case when b.activity_type ='send' then b.time_spent else 0 end)/
SUM(time_spent)*100,2) as send_percentage,
100- ROUND(SUM(case when b.activity_type ='send' then b.time_spent else 0 end)/
SUM(time_spent)*100,2) as open_percentage
FROM age_breakdown as a
JOIN activities as b 
ON (a.user_id=b.user_id
and not activity_type='chat')
group by a.age_bucket
-- bai tap 4
SELECT a.customer_id
FROM customer_contracts as a
FULL JOIN products as b 
on a.product_id=b.product_id
GROUP BY a.customer_id
HAVING COUNT(distinct(b.product_category))=3
--bai tap 5
select a.reports_to as employee_id, b.name as name, count(a.name) as reports_count, round(avg(a.age)) as average_age
from employees as a
join
employees as b
on a.reports_to=b.employee_id
group by name
-- bai tap 6
select a.product_name, sum(b.unit) as unit
from products as a
RIGHT JOIN orders as b
on a.product_id = b.product_id
where (b.order_date between '2020-02-01' and '2020-02-28')
group by a.product_name
having sum(b.unit) >= 100
-- bai tap 7
SELECT a.page_id
FROM pages as a  
FULL JOIN page_likes as b  
ON a.page_id = b.page_id
where b.page_id is NULL
order by a.page_id
--mid-course test
-- cau hoi 1
select min(distinct(replacement_cost)) from film
-- cau hoi 2
Select sum(case when replacement_cost between 9.99 and 19.99 then 1 else 0 end) as low,
sum(case when replacement_cost between 20.00 and 24.99 then 1 else 0 end) as medium,
sum(case when replacement_cost between 25.00 and 29.99 then 1 else 0 end) as high
from film
-- cau hoi 3
select title, length,c.name
from film as a
JOIN
film_category as b
on a.film_id=b.film_id
JOIN category as c
on b.category_id = c. category_id
where c.name in ('Drama','Sports')
order by length desc --- sports, 184
-- cau hoi 4
select  c.name,count(title) as so_luong
from film as a
JOIN
film_category as b
on a.film_id=b.film_id
JOIN category as c
on b.category_id = c. category_id
group by c.name
order by so_luong desc
-- cai hoi 5
select a.actor_id, a.first_name, a.last_name, count(film_id) as so_luong_film
from actor as a
JOIN film_actor as b
on a.actor_id=b.actor_id
group by a.actor_id
order by so_luong_film desc
-- cau hoi 6
select count(a.address_id)
from address as a 
LEFT JOIN
customer as b
on a.address_id = b.address_id
where customer_id is null
-- cau 7
select a.city, sum(d.amount) as doanh_thu
from city as a
JOIN address as b
on a.city_id=b.city_id
JOIN customer as c
on b.address_id=c.address_id
JOIN payment as d
on c.customer_id=d.customer_id
group by a.city
order by doanh_thu desc
-- cau hoi 8
select CONCAT(a.city,', ', e.country) as city_and_country, 
sum(d.amount) as doanh_thu
from city as a
JOIN address as b
on a.city_id=b.city_id
JOIN customer as c
on b.address_id=c.address_id
JOIN payment as d
on c.customer_id=d.customer_id
JOIN country as e
on a.country_id=e.country_id
group by city_and_country
order by doanh_thu desc
