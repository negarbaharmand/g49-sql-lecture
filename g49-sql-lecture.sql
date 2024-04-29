CREATE DATABASE lecture_db;

create table address(
id int primary key not null auto_increment,
city varchar(255),
zip_code varchar(6) not null
);

use lecture_db;
drop table address;

-- CRUD operations

-- 1. Retreive data from address table = Read
select * from address;

-- 2. Store a record into the address table = Create
insert into address(city, zip_code) values('Växjo','23345');
insert into address(city, zip_code) values('Växjo','23332');
insert into address(city, zip_code) values('Jönköping','5846');
insert into address(city, zip_code) values('Stockholm','67458');

select id, zip_code from address;
select id as address_id, zip_code as zp from address;

-- 3. Modify table content = Update
update address set zip_code = '11111' where id = 3;

-- Modify table field
alter table address modify city varchar(40);
-- Add a new column to the table
alter table address add street varchar(255) not null default '-';

alter table address drop street;

create table person(
id int not null primary key auto_increment,
first_name varchar(255) not null,
last_name varchar(255) not null,
email varchar(255) not null,
birth_date date,
create_date datetime default now(),
_active tinyint default false,
address_id int not null unique,
foreign key(address_id) references address(id)
);

drop table person;
select * from person;

insert into person(first_name, last_name, email, address_id) values('Negar', 'Baharmand','negar@gmail.com',1);
alter table person modify email varchar(255) unique;
insert into person(first_name, last_name, email, address_id) values('Test', 'Testsson','test@gmail.com',2);

create table task(
id int not null primary key auto_increment,
title varchar(255) not null,
_description varchar(500), 
person_id int,
foreign key(person_id) references person(id)
);

select * from task;

select * from task where id = 1;
select * from task where id in(1,2,3);

select * from task where title like '%ask%';

select person_id, count(*) as number_of_tasks from task group by person_id;

select * from task where person_id = 2;
select * from task t join person p on t.person_id = p.id where t.person_id=2;

-- Right join
select t.id as task_id, t.title, p.first_name, p.last_name 
from task t
right join person p 
on p.id = t.person_id;

-- Left join
 select p.id as person_id, p.first_name, t.title
 from person p
 left join task t on p.id = t.person_id;



select t.id, t.title, p.first_name, p.last_name 
from task t 
join person p 
where person_id = 2;

create table _group(
id int not null primary key auto_increment,
group_name varchar(100) not null
);

select * from _group;

create table persons_groups(
id int not null primary key auto_increment,
person_id int not null,
group_id int not null,
foreign key(person_id) references person(id),
foreign key(group_id) references _group(id)
);

select * from task order by person_id desc;
 select count(*) as number_of_tasks from task;
-- avg() sum()

-- remove duplicate data
select distinct _description from task;

