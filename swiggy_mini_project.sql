use online_food;
show tables;
select * from swiggy;
/*Count total rows in a table*/
select count(ID) from swiggy;

describe swiggy;           #8680            #7865

/*Add primary key*/
alter table swiggy add primary key(ID);

/*Total no of restaurants*/
select count(distinct(restaurant)) from swiggy;

/* Find restaurants which appeared more than once */
select count(restaurant) - count(distinct(restaurant)) as repeated_resto
from swiggy;

#OR - Using Group by
select restaurant, count(restaurant)
from swiggy
group by restaurant
having count(restaurant) > 1;

/* Find total city in the data */
select count(distinct(city)) from swiggy;

/* Sort number of restaurants coming from each city in descending order*/
select city, count(distinct(restaurant)) as total_resto
from swiggy
group by city
order by total_resto desc;

/*Find total orders made from each restaurant from bangalore*/
select restaurant, count(ID) as orders
from swiggy
where city = 'Bangalore'
group by restaurant
order by count(id) desc;

/*Find the restaurant name with maximum orders*/
select restaurant,city, count(ID)
from swiggy
group by restaurant, city
order by count(ID) desc
limit 5;

select restaurant, city, total_orders
from(select restaurant, city, count(ID) as total_orders,
     dense_rank() over(order by count(ID) desc) as rankk
     from swiggy
     group by restaurant, city) as rankings
where rankk = 1;

# less useful way

select restaurant, city, count(ID) as totalordrrtds
from swiggy
group by restaurant, city
order by count(ID) desc
limit 1;

/* Find top three restaurant names with maximum orders */
select Restaurant, City, total_orders, ranking
from (select Restaurant, City, count(ID) as total_orders,
dense_rank() over (order by count(ID) desc) as ranking
from swiggy
group by Restaurant, city) as table_ranked
where ranking between 1 and 3;

/*Find restaurants from Kormangala area of Bangalore who serve chinese food */
select Restaurant
from swiggy
where city = 'Bangalore' and Area = 'Koramangala' and
Food_type like 'Chinese'

/*Find average delivery time taken by swiggy */
select avg(Delivery_time) from swiggy;

/*Find average delivery time taken by swiggy in each city */
select city, avg(Delivery_time) from swiggy
group by city;

/*Find all restaurants from Mumbai, Delhi and Kolkata who serve
North Indian and South Indian dishes */
select * from swiggy
where city in ('Mumbai','Delhi','Kolkata') and
food_type like '%North Indian%' and food_type like '%South Indian%';

