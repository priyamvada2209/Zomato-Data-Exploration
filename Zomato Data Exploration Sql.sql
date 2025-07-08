create database project;
use project;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'2017-09-22'),
(3,'2017-04-21');

drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-12-20',2),
(1,'2016-11-09',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-03-15',2),
(1,'2016-04-11',1),
(3,'2016-11-10',1),
(3,'2017-12-07',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);


drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

# 1. total amount spent  -->
select s.userid , sum(p.price) as Total_Spent from sales s join product p on s.product_id=p.product_id group by s.userid;

# 2. Dates visited by Customers -->
select userid , count(distinct created_date) as distinct_date from sales group by userid;

#3 what was the first product purchased by each customer -->
with no as(select * , rank() over(partition by userid order by created_date) as rk from sales)
select * from no where rk=1;

#4 most purchased item of menu and how many times everyone purchased -->
select userid , count(product_id) as cnt from sales where product_id=(select product_id from sales group by product_id order by count(product_id) desc limit 1) group by userid;

#5 which item was most popular for each customer --> 
select userid , product_id , countt from(
select product_id,userid  , count(product_id) as countt , rank() over(partition by userid order by count(product_id) desc) as rnk from sales group by product_id , userid)
as subq where rnk=1;

#6 which item was purchased first by customers after they became a member -->
select product_id,userid from (
select s.userid , s.created_date, s.product_id ,g.gold_signup_date,rank() over(partition by s.userid order by created_date) as rnk from sales s join goldusers_signup g on s.userid=g.userid and created_date>=gold_signup_date)as subq 
where rnk=1;

#7 which item was purchased by customers just before they became a member -->
select userid , product_id from(
select s.userid ,s.created_date ,g.gold_signup_date ,s.product_id ,rank() over(partition by userid order by created_date desc)as rnk from sales s join goldusers_signup g on s.userid=g.userid and created_date<gold_signup_date)as subq 
where rnk=1;

#8 what is total amount spent before they became gold members -->
select userid , count(created_date),sum(price) from (
select subq.* , p.price from (
select s.userid ,s.created_date ,g.gold_signup_date ,s.product_id from sales s join goldusers_signup g on s.userid=g.userid and created_date<gold_signup_date)subq join product p on subq.product_id=p.product_id)der 
group by userid;

#10 in the first year after a customer join gold program irrespecitve of what the customer has purchased they earn 5 zomato points for every 10 rs. , which custo,er earned more and what are their earnings in 1st year?
select sub.* , p.price from(
select s.userid ,s.created_date ,s.product_id ,g.gold_signup_date from sales s join goldusers_signup g on s.userid=g.userid and created_date>=gold_signup_date and created_date<=DATE_ADD(gold_signup_date,interval 1 YEAR))sub
join product p on sub.product_id=p.product_id;

#11 rank all the transictions of the customers -->
select *, rank() over(partition by userid order by created_date desc)as rnk from sales ;

#12 rank all the transictions for each member whenever they're zomato gold and for every non-gold member mark as na -->
select e.* , case when rnk=0 then 'na' else  rnk end as enkk from(
select c.*, case when gold_signup_date is null then 0 else rank() over(partition by userid order by created_date desc)end as rnk from(
select s.userid , s.created_date , s.product_id , g.gold_signup_date from sales s left join goldusers_signup g on s.userid=g.userid and created_date>=gold_signup_date)as c)as e;
