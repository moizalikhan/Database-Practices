*/ Practice 1 */
create database compilance_users
use compilance_users
Go


create table tbluser
(
id int not null primary key,
Name nvarchar(50) not null,
Email nvarchar(50) not null,
GenderID int null
)

create table tblGender
(
Id int not null primary key,
Gender nvarchar not null
)

Alter table tbluser add constraint tbluser_GenderID_FK
Foreign Key (GenderId) references tblGender(ID)

*/ Practice 2 */
insert into tbluser (id,Name, Email, GenderId) values(1, 'jack','j@r.com', 1)
insert into tbluser (id,Name, Email, GenderID) values(2, 'sara','s@r.com',2)
insert into tbluser (id,Name, Email, GenderId) values(3, 'leo','l@r.com', 1)
insert into tbluser (id,Name, Email, GenderId) values(4, 'kristry','k@r.com', 2)
insert into tbluser (id,Name, Email, GenderId) values(5, 'weeknd','w@r.com', null)
insert into tbluser (id,Name, Email, GenderId) values(6, 'eddie','E@r.com', 1)
insert into tbluser (id,Name, Email, GenderId) values(7, 'Bella','b@r.com', 2)
insert into tbluser (id,Name, Email, GenderId) values(8, 'jeo','j@r.com', 1)

Alter table tbluser
add constraint df_tbluser_GenderID
default 3 for Genderid

insert into tbluser(id,Name,Email) values(9, 'joe', 'j@r.com')

Alter table tbluser
add HouseNo nvarchar(50) null
constraint DF_tbluser_HouseNo default null

Alter table tbluser
drop constraint DF_tbluser_HouseNo

*/ Practice 3 */
Select * from tbluser
Select * from tblGender

delete from tblGender where id = 2
delete from tblGender where id = 1
delete from tblGender where id = 3

*/ Practice 4 */
Select * from tbluser
Select * from tblGender
alter table tbluser
add Age_again int
insert into tblGender( id , Gender) values(1, 'M')
insert into tbluser(id, Name, Email, GenderID, HouseNo, age) values (8, 'sara', 's@r.com', 1, null, 230)
alter table tbluser
add constraint Ck_tbluser_Age check(age_again> 0 and age_again<150)
insert into tbluser(id, Name, Email, GenderID, HouseNo, age, age_again) values (10, 'sara', 's@r.com', 1, null,null,110)

*/ Practice 5 */
Select * from tbluser
Select * from tblGender
select * from tblperson
insert into tblperson values('moiz')
insert into tblperson values('john')
insert into tblperson values('jack')
insert into tblperson values('sara')
delete from tblperson where personid = 1
insert into tblperson values('judy')
set identity_insert tblperson on
insert into tblperson (personid, name) values (1,'martin')
delete from tblperson
set identity_insert tblperson off
insert into tblperson values('kamran')
dbcc checkident(tblperson, reseed, 0)
insert into tblperson values('lauren')

*/ Practice 5 */
create table test1
(
	id int identity(1,1),
	value nvarchar(50)
)
create table test2
(
	id int identity(1,1),
	value nvarchar(50)
)
insert into test1 values('efg')
select * from test1
select * from test2
select SCOPE_IDENTITY()
select @@IDENTITY
select ident_current('test2')
Create Trigger trforinsert on test1	for insert
as
begin
	insert into test2 values('qqq')
end
insert into test1 values('ghi')
insert into test1 values('ijk')

*/ Practice 6 */
select * from tbluser
delete from tbluser
alter table tbluser
drop column age;
select * from tbluser
alter table tbluser
add constraint UK_tbluser_email unique(email)
insert into tbluser values(2,'moiz','s@m.com',1,23,45)
insert into tbluser values(3,'kzz','a@m.com',1,23,45)
insert into tbluser values(4,'rzz','d@m.com',1,23,45)
insert into tbluser values(5,'szz','f@m.com',1,23,45)
--insert into tbluser values(6,'moiz','m@m.com',1,23,45)
alter table tbluser
drop constraint UK_tbluser_email
insert into tbluser values(6,'moiz','m@m.com',1,23,45)


*/ Practice 7 */
select * from tbluser
select [name] from tbluser
select distinct Email from tbluser 
select distinct name from tbluser
select distinct name, email from tbluser
