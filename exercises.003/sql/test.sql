use affe1;

select 
	dept_id, 
	emp_id, 
	emp_no, 
	name, 
	job, 
	salary 
from
	employee;

select
	dept_id, 
	min(salary),
	max(salary),
	sum(salary),
	avg(salary)
from
	employee
group by
	dept_id;

select
	salary, 
	group_concat(distinct dept_id) as dept, count(*)
from
	employee
group by
	salary
having
	count(*) >= all(select count(*) from employee group by salary);

select 
	d.dept_id, 
	d.name,
	sum(e.salary) /(select sum(salary) from employee) *100 as percentage
from 
	department d
left join
	employee e 
on 
	d.dept_id = e.dept_id
group by
	d.dept_id, d.name;

select 
	e.dept_id,
	e.name,
	e.hired_date
from
	employee e
order by e.hired_date;

select 
	e.dept_id, 
	e.name, 
	e.hired_date, 
	max(d.hired_date) as last_hired_date
from 
	employee e
left join
	employee d 
on 
	d.hired_date < e.hired_date
group by 
	e.dept_id, e.name, e.hired_date
order by
	e.hired_date;

select x.name from (select e.name from employee e) x;

select 
	ceil(x.rank /5) as grp, 
	x.name,
	x.emp_no
from(
	select 
		e.name, 
		e.emp_no, 
		(
			select 
				count(*) 
			from 
				employee d
			where 
				d.emp_no < e.emp_no
		) +1 as rank
	from 
		employee e
)x
order by
	grp, emp_no

