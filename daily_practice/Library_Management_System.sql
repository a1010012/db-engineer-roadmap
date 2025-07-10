create database practice;
use practice;
create table book(
isbn char(13) primary key,
title varchar(100) not null);
create table reader(
id int auto_increment primary key); 
create table loan(
loan_id int auto_increment primary key,
borrow_date date not null,
isbn char(13),
reader_id int,
foreign key(isbn) references book(isbn),
foreign key(reader_id) references reader(id)
);
alter table book add stock int;
delimiter $$
create procedure borrowbook(
in p_isbn char(13),
in p_reader_id int
)
begin
start transaction;
insert into loan(isbn,reader_id,borrow_date)
values(p_isbn,p_reader_id,curdate());
update book set stock=stock-1 where isbn=p_isbn;
commit;
end$$
delimiter ;


