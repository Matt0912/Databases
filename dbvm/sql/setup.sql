use mysql;

-- remove default permissions
delete from user where not (user='root' and host='%');
drop database test;
delete from db;

-- new ones
-- update user set password='*33E418E4DE237129F3055BABD2C3ABF429085E6B';
create user 'student'@'%';
create database elections14;
create database elections15;
create database census;
create database bb;
create database data;
create database hovsoc;
create database uni;
grant select on elections14.* to 'student'@'%';
grant select on elections15.* to 'student'@'%';
grant select on census.* to 'student'@'%';
grant all on bb.* to 'student'@'%';
grant all on data.* to 'student'@'%';
grant all on hovsoc.* to 'student'@'%';
grant all on uni.* to 'student'@'%';

grant shutdown on *.* to 'student'@'%';

flush privileges;
