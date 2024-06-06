Bài 1: Xác định dạng của tam giác qua số đo các cạnh:
/% Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:
Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle 
https://www.hackerrank.com/challenges/what-type-of-triangle/problem?isFullScreen=true  %/
select
case when A + B <= C or A+C <= B or C + B <= A then 'Not A Triangle'
        when A=B and B=C then 'Equilateral'
        when (A=B and B != C) or (A=C and A != B) or (B=C and B != A) then 'Isosceles'
        else 'Scalene'
        end category
from Triangles;

Bài 2: Liệt kê danh sách người và vị trí làm việc, tổng hợp số lượng người mỗi ngành nghề theo format có sẵn
https://www.hackerrank.com/challenges/the-pads/problem
Select * from 
(
select concat (name, '(', left(occupation, 1), ')') as people from occupations
order by name asc) as a
union 
select * from
(
select concat ('There are a total of ', count(occupation), ' ', lower(occupation), 's.') from occupations
group by occupation
order by count(occupation), occupation) as b


Bài 3: Sắp xếp tên vào các cột là nghề nghiệp tương ứng
https://www.hackerrank.com/challenges/occupations/problem        
with cte as
(
select name, occupation,
rank() over(partition by occupation order by name) as ratingrank from occupations
order by ratingrank)

select 
max(case when occupation = 'Doctor' then name else null end) as Doctor,
max(case when occupation = 'Professor' then name else null end) as Professor,
max(case when occupation = 'Singer' then name else null end) as Singer,
max(case when occupation = 'Actor' then name else null end) as Actor
from cte
group by ratingrank


Bài 4: Xác định project và sắp xếp theo số ngày hoàn thành 1 projects
https://www.hackerrank.com/challenges/sql-projects/problem 
with cte1 as
(Select Start_Date, End_Date, 
End_date - Dense_Rank() Over (Order By End_Date)  AS Part From Projects),
cte2 as
(select part,
min(Start_date) as start_project_date, max(End_date) as end_project_date from cte1
group by part)
select start_project_date, end_project_date from cte2
order by end_project_date - start_project_date

Bài 5: Xác định xem ai có bạn được offer mức lương cao hơn
https://www.hackerrank.com/challenges/placements/problem?isFullScreen=true
with cte as
(
Select a.id, a.name, b.salary, c.friend_id
from students as a
join packages as b
on a.id=b.id
join friends as c
on a.id=c.id),

cte2 as (
select cte.*, d.salary as friend_salary
from cte as cte
join packages as d
on cte.friend_id = d.id)

select name from cte2
where friend_salary > salary
order by friend_salary
