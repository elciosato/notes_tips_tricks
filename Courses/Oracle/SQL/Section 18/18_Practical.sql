-- 198. User Accounts
-- Problem 1
-- Connect XEPDB1 (service name)
create user course2 identified by course2 password expire;

create user c##course2 identified by course2 account lock;

select * from dba_users order by username;

select * from v$database;

grant create session to course2;

-- 200. User Privileges
-- Problem 1
-- Connect to sys
grant create table to course2;
alter user course2 quota unlimited on users;

-- Connect to course2
-- 1.1.  
create table priv_test (col1 date);

-- 1.2.
insert into priv_test values (sysdate);
commit;

grant delete on priv_test to course;
grant insert on priv_test to course;

-- 1.3.
-- Connect course
delete from course2.priv_test;
commit;

-- 1.4.
-- Connect course
insert into course2.priv_test values (sysdate);
commit;

-- 1.5.
-- Connect course2
revoke delete on priv_test from course;
revoke insert on priv_test from course;

-- 203. User Roles
-- Problem 1
-- 1.1.
-- Connect sys
create role rh_aux;

-- 1.2.
-- Connect sys
grant select on course.employees to rh_aux;
grant select on course.departments to rh_aux;

-- 1.3.
-- Connect sys
create role it_aux identified by itauxpwd;

-- 1.4.
-- Connect sys
grant select on course.systems to it_aux;
grant select on course.applications to it_aux;

-- 1.5.
-- Connect sys
grant select on course.jobs to course2;
grant rh_aux to course2;
grant it_aux to course2;

-- 1.6.
-- Connect course2
set role all;
set role rh_aux, it_aux identified by itauxpwd;

select * from course.employees;
select * from course.departments;
select * from course.jobs;
select * from course.systems;
select * from course.applications;

select * from user_role_privs;

select * from dict;

-- 206. Synonyms
-- Problem 1.
-- 1.1.
-- Connect sys
create user course3 identified by course3;
grant create session to course3;

-- 1.2.
-- Connect sys
grant rh_aux to course3 with admin option;

-- 1.3.
-- Connect sys
grant create public synonym to course3;
grant drop public synonym to course3;

-- Connect course3
create public synonym depts for course.departments;

-- 1.4.
-- Connect course2 and course3
select * from depts;

-- 1.5.
-- Connect course3
drop public synonym depts;