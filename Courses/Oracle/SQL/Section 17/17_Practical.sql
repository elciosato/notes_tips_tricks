-- 180. Creating, and Dropping Tables
-- Problem 1
create table persons (
  id number(5)
, name varchar2(50) not null
, birth_date date
, constraint pk_persons primary key (id)
);

create table car_brands (
  id number(5)
, name varchar2(50) not null
, constraint pk_car_brands primary key (id)
);

create table colors (
  id number(5)
, name varchar2(50) not null
, constraint pk_colors primary key (id)
);

-- Problem 2
create table person_cars (
  id number(5)
, person_id number(5) not null
, car_brand_id number(5) not null
, color_id number(5) not null
, purchase_date date not null
, constraint pk_person_cars primary key (id)
, constraint fk_person_car_person foreign key (person_id) references persons
, constraint fk_person_car_brand foreign key (car_brand_id) references car_brands
, constraint fk_person_car_color foreign key (color_id) references colors
);

-- Problem 3
-- 3 person
insert into persons(id, name, birth_date) values (1, 'Bob', sysdate - 365*20);
insert into persons(id, name, birth_date) values (2, 'Maria', sysdate - 365*30);
insert into persons(id, name, birth_date) values (3, 'John', sysdate - 365*40);
commit;
-- 5 colors
insert into colors(id, name) values (1, 'Black');
insert into colors(id, name) values (2, 'White');
insert into colors(id, name) values (3, 'Silver');
insert into colors(id, name) values (4, 'Red');
insert into colors(id, name) values (5, 'Blue');
commit;

-- 5 car brands
insert into car_brands (id, name) values (1, 'Mazda');
insert into car_brands (id, name) values (2, 'Mitsubishi');
insert into car_brands (id, name) values (3, 'Toyota');
insert into car_brands (id, name) values (4, 'Renault');
insert into car_brands (id, name) values (5, 'Ford');
commit;
-- 2 cars for each person
insert into person_cars (id, person_id, car_brand_id, color_id, purchase_date)
values (1, 1, 1, 1, sysdate - 30*10);
insert into person_cars (id, person_id, car_brand_id, color_id, purchase_date)
values (2, 1, 2, 2, sysdate - 120*10);

insert into person_cars (id, person_id, car_brand_id, color_id, purchase_date)
values (3, 2, 3, 3, sysdate - 30*20);
insert into person_cars (id, person_id, car_brand_id, color_id, purchase_date)
values (4, 2, 4, 4, sysdate - 120*20);

insert into person_cars (id, person_id, car_brand_id, color_id, purchase_date)
values (5, 3, 5, 5, sysdate - 30*30);
insert into person_cars (id, person_id, car_brand_id, color_id, purchase_date)
values (6, 3, 1, 2, sysdate - 120*30);

commit;

select * from person_cars;

-- Problem 4
select p.name as person_name
, cb.name as brand_name
, c.name as color_name
, pc.purchase_date
from person_cars pc
join persons p on (pc.person_id = p.id)
join car_brands cb on (pc.car_brand_id = cb.id)
join colors c on (pc.color_id = c.id)
order by person_name;

-- Problem 5
create table cars_report as
select p.name as person_name
, cb.name as brand_name
, c.name as color_name
, pc.purchase_date
from person_cars pc
join persons p on (pc.person_id = p.id)
join car_brands cb on (pc.car_brand_id = cb.id)
join colors c on (pc.color_id = c.id);

-- 182. Changing the Definition of Tables
-- Problem 1
alter table persons add (
  preferred_color number(5) 
, personal_budget number(6,2) default 0 not null
, constraint fk_persons_color foreign key(preferred_color) references colors
);

-- Problem 2
alter table car_brands modify name varchar2(500);

-- Problem 3
alter table person_cars rename column purchase_date to purchased;

-- 184. Constraints
-- Problem 1
alter table person_cars drop constraint fk_person_car_color;
alter table persons drop constraint fk_persons_color;

drop table colors;

select * from user_constraints
where (r_owner,r_constraint_name) in
(select owner,constraint_name 
from user_constraints 
where table_name = 'COLORS'
and constraint_type = 'P');

-- Problem 2
create table colors (
  id number(5)
, name varchar2(50)
);

insert into colors(id, name) values (1, 'Black');
insert into colors(id, name) values (2, 'White');
insert into colors(id, name) values (3, 'Silver');
insert into colors(id, name) values (4, 'Red');
insert into colors(id, name) values (5, 'Blue');
commit;

-- Problem 3
alter table colors add constraint pk_colors primary key (id);

alter table colors modify name varchar2(50) not null;

-- Problem 4
alter table person_cars add constraint fk_person_car_color foreign key (color_id) references colors;
alter table persons add constraint fk_persons_color foreign key (preferred_color) references colors;

-- 186. Sequences
-- Problem 1
select 'alter table '||table_name||' disable constraint '||constraint_name||';' from user_constraints
where (r_owner,r_constraint_name) in
(select owner,constraint_name 
from user_constraints 
where table_name in ( 'COLORS', 'PERSONS', 'CAR_BRANDS')
and constraint_type = 'P');

delete from persons;
delete from colors;
delete from car_brands;

-- Problem 2
create sequence sq_colors;
create sequence sq_persons;
create sequence sq_car_brands;

insert into persons(id, name, birth_date) values (sq_persons.nextval, 'Bob', sysdate - 365*20);
insert into persons(id, name, birth_date) values (sq_persons.nextval, 'Maria', sysdate - 365*30);
insert into persons(id, name, birth_date) values (sq_persons.nextval, 'John', sysdate - 365*40);
commit;
-- 5 colors
insert into colors(id, name) values (sq_colors.nextval, 'Black');
insert into colors(id, name) values (sq_colors.nextval, 'White');
insert into colors(id, name) values (sq_colors.nextval, 'Silver');
insert into colors(id, name) values (sq_colors.nextval, 'Red');
insert into colors(id, name) values (sq_colors.nextval, 'Blue');
commit;

-- 5 car brands
insert into car_brands (id, name) values (sq_car_brands.nextval, 'Mazda');
insert into car_brands (id, name) values (sq_car_brands.nextval, 'Mitsubishi');
insert into car_brands (id, name) values (sq_car_brands.nextval, 'Toyota');
insert into car_brands (id, name) values (sq_car_brands.nextval, 'Renault');
insert into car_brands (id, name) values (sq_car_brands.nextval, 'Ford');
commit;

-- Problem 3
drop table person_cars;
drop table persons;
drop table colors;
drop table car_brands;

create table persons (
  id number(5) default sq_persons.nextval
, name varchar2(50) not null
, birth_date date
, constraint pk_persons primary key (id)
);

create table car_brands (
  id number(5) default sq_car_brands.nextval
, name varchar2(50) not null
, constraint pk_car_brands primary key (id)
);

create table colors (
  id number(5) default sq_colors.nextval
, name varchar2(50) not null
, constraint pk_colors primary key (id)
);

-- Problem 4
insert into persons(id, name, birth_date) values (default, 'Bob', sysdate - 365*20);
insert into persons(id, name, birth_date) values (default, 'Maria', sysdate - 365*30);
insert into persons(id, name, birth_date) values (default, 'John', sysdate - 365*40);
commit;
-- 5 colors
insert into colors(id, name) values (default, 'Black');
insert into colors(id, name) values (default, 'White');
insert into colors(id, name) values (default, 'Silver');
insert into colors(id, name) values (default, 'Red');
insert into colors(id, name) values (default, 'Blue');
commit;

-- 5 car brands
insert into car_brands (id, name) values (default, 'Mazda');
insert into car_brands (id, name) values (default, 'Mitsubishi');
insert into car_brands (id, name) values (default, 'Toyota');
insert into car_brands (id, name) values (default, 'Renault');
insert into car_brands (id, name) values (default, 'Ford');
commit;

-- 189. Indexes
-- Problem 1
alter table employees drop constraint emp_email_uk;

select 'drop index '|| index_name || ';' from user_indexes where table_name = 'EMPLOYEES';

drop index EMP_DEPARTMENT_IX;
drop index EMP_JOB_IX;
drop index EMP_MANAGER_IX;
drop index EMP_NAME_IX;
drop index EMP_EMAIL_UK;

-- Problem 2
select * from jobs;

select * from employees where job_id = 'PU_CLERK';

create index emp_job_id_ix on employees (job_id);

-- Problem 3
select * from employees where extract(day from hire_date) = 21;

create index emp_hire_date_func_ix on employees(extract(day from hire_date));

-- Problem 4
create index emp_first_last_name_ix on employees (first_name, last_name);

select * from employees where first_name= 'Steven' and last_name= 'King';

-- Problem 5
select 'drop index '|| index_name || ';' from user_indexes where table_name = 'EMPLOYEES';

drop index EMP_JOB_ID_IX;
drop index EMP_HIRE_DATE_FUNC_IX;
drop index EMP_FIRST_LAST_NAME_IX;

-- 191. Views 1
-- Problem 1
