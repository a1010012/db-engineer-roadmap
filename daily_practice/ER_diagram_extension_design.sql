use practice;
show create table loan;
alter table loan drop foreign key `loan_ibfk_2`;
drop table reader;
create table reader(
reader_id int primary key auto_increment,
name varchar(50) not null,
level enum('normal','vip') default'normal'
);
create table fine_rule(
level enum('normal','vip')primary key,
max_borrow_days int not null,
daily_fine decimal(5,2) not null
);
alter table loan add column return_date date;
delimiter $$
create procedure ReturnBook(in p_loan_id int)
begin
declare v_borrow_days int;
declare v_fine_rate decimal(5,2);
declare v_fine decimal(8,2);
  -- 获取借阅天数和罚款规则
select datediff(now(),borrow_date),r.daily_fine*if(r.level='vip',0.5,1)
into v_borrow_days,v_fine_rate 
from loan l
join reader rd on l.reader_id=rd.reader_id 
join fine_rule r on rd.level=r.level
where loan_id=p_loan_id;
-- 计算罚款,超出的天数
SET v_fine = GREATEST(0, (v_borrow_days - v_max_days) * v_fine_rate);
  -- 更新还书日期和罚款
update loan set return_date=now(),fine=v_fine where loan_id=p_loan_id;
end$$
delimiter ;
SHOW PROCEDURE STATUS WHERE Name = 'ReturnBook';