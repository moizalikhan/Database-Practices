/*
lecture 11:
group by: use in one or more many agg functions
aggregate functions: sum, avg, count, min, max
you cannot group by with other attributes.
and include attribues in make group by.
can use multiple users.
for filtering group by use where by clause. and can be use in insert and other statements and no aggregate func
we use where just after from
and having after the group by. and use in select only and can use aggre*/

/*Practice 11*/
create table tbluser
(
id int not null primary key,
Name nvarchar(50) not null,
Gender nvarchar(50) not null,
city nvarchar(50) not null,
salary int not null
)

select * from tbluser
insert into tbluser(id,name,gender,city,salary) values (1,'sara','female','berlin',3000);
insert into tbluser(id,name,gender,city,salary) values (2,'sezz','Male','newyork',4000);
insert into tbluser(id,name,gender,city,salary) values (3,'leez','Male','frankfort',5000);
insert into tbluser(id,name,gender,city,salary) values (4,'lana','female','newjersy',6000);
insert into tbluser(id,name,gender,city,salary) values (5,'beinsh','female','hunululu',7000);
insert into tbluser(id,name,gender,city,salary) values (6,'bashing','Male','hawai',8000);
insert into tbluser(id,name,gender,city,salary) values (7,'yums','Male','berlin',9000);

select sum(salary) from tbluser
select min(salary) from tbluser
select max(salary) from tbluser
select city, sum(salary) from tbluser group by city

select city,gender,sum(salary) from tbluser
group by city,gender
order by gender

select count(id) from tbluser

select city,gender,sum(salary) as totalsalary,
count(id) as totalemployees from tbluser
where gender ='Male'
group by city, gender
order by city

select city,gender,sum(salary) as totalsalary,
count(id) as totalemployees from tbluser
group by city, gender
having gender ='female'
order by city