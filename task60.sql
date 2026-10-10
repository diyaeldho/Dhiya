create database clg_management;
use clg_management;
create table students(std_id int primary key auto_increment, std_name varchar(50), dept varchar(50), age int);
insert into students(std_name,dept,age) values("Dhiya","Commerce",24),("Rithu","Science",23),("Keerthy","IT",25);
select * from students;
create table departments(dept_id int primary key, dept_name varchar(50));
insert into departments(dept_id,dept_name) values(1,"management"),(2,"science"),(3,"IT");
select * from departments;
create table entrollments(ent_id int primary key auto_increment, std_id int, course varchar(50), fees decimal(10,2), foreign key(std_id) references students(std_id));
insert into entrollments(std_id,course,fees)values(1,"data analytics",25000),(2,"java",35000),(3,"python",26000);
select * from entrollments;

delimiter //
create procedure add_std(in p_name varchar(50),p_dept varchar(50),p_age int)
begin
insert into student(std_name,dept,age) values(p_name,p_deot,p_age);
end //
delimiter ;
start transaction;
call add_std("Akshay","Commerce",25);
call add_std("gokul","management",26);
delete from students where std_id in(5,6);
drop procedure if exists add_std;

savepoint student_savepoint;
rollback;
rollback to savepoint student_savepoint;
commit;

select d.dept_name as departments, count(distinct s.std_id) as students_count, sum(e.fees) as total_revenue from departments d join students s on d.dept_name=s.dept left join entrollments e on s.std_id=e.std_id group by d.dpet_id, d.dept_name having count(distinct s.std_id)>1;
select s.std_name as name,s.dept as departments,count(e.ent_id) as total_courses_enrolled, sum(e.fees) as total_fees_paid from students s join entrollment e on std_id=e.std_id group by s.std_id,s.std_name,s.dept having count(e.ent_id)>1;

create view std_reprt as select s.std_name as student_name,s.dept as department_name, e.course, e.fees as fee from studnets s join entrollemts e on s.std_id=e.std_id;

select student_name, department_name, sum(fee) as total_fee from std_report group by student_name,department_name having sum(fee)>50000;
insert into students(std_name,dept,age) values("Sooraj","IT",25);
delete from students where std_name in ("Akshay");