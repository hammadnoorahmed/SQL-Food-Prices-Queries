
#Task: Run the following queries on the food prices and commodities

set sql_safe_updates = 0;
update wfp_food_prices_pakistan set `date` = str_to_date(`date`, '%m/%d/%y');
alter table wfp_food_prices_pakistan modify `date` date;


#Select dates and commodities for cities Quetta, Karachi, and
#Peshawar where price was less than or equal 50 PKR

select * from wfp_food_prices_pakistan;


select date, cmname, mktname, price 
from wfp_food_prices_Pakistan 
where mktname IN ('Quetta', 'Karachi', 'Peshawar') AND price <=50;

# Query to check number of observations against each market/city in PK

Select mktname, count(*) from wfp_food_prices_Pakistan 
group by mktname;


# Show number of distinct cities
 Select count(distinct(mktname)) 
 from wfp_food_prices_Pakistan;

#showing distinct markets or cities as well 
Select distinct(mktname) 
 from wfp_food_prices_Pakistan;
 
#List down/show the names of cities in the table
Select distinct(mktname) 
 from wfp_food_prices_Pakistan;
 
 
# List down/show the names of commodities in the table
Select distinct(cmname) 
 from wfp_food_prices_Pakistan;
 
  Select count(distinct(cmname)) 
 from wfp_food_prices_Pakistan;

 #List Average Prices for Wheat flour - Retail in EACH city separately over the entire period.
 Select mktname, cmname, round(avg(price),2) as average_price
 from wfp_food_prices_Pakistan
 where cmname = 'Wheat flour - Retail'
 Group by mktname;

#Calculate summary stats (avg price, max price) for each city
#separately for all cities except Karachi and sort alphabetically the
#city names, commodity names where commodity is Wheat (does not
#matter which one) with separate rows for each commodity

select * from wfp_food_prices_pakistan;

Select mktname, cmname, round(avg(price),2) as average_price, max(price) as maximum_price
from wfp_food_prices_pakistan
where mktname not in ('Karachi') And cmname like '%Wheat%'
group by mktname, cmname
Order by mktname ASC;

#Calculate Avg_prices for each city for Wheat Retail and show only
#those avg_prices which are less than 30

Select mktname, cmname, round(avg(price),2) as average_price
from wfp_food_prices_pakistan
group by mktname, cmname
having avg(price) < 30 and cmname = 'Wheat - Retail'; 


#Prepare a table where you categorize prices based on a logic (price
# &lt; 30 is LOW, price &gt; 250 is HIGH, in between are FAIR)

Select date, cmname, price, case
when price < 30 then 'low'
when price > 250 then 'high'
else 'fair'
end as price_value
from  wfp_food_prices_pakistan;


# Create a query showing date, cmname, category, city, price,
#city_category where Logic for city category is: Karachi and Lahore
#are &#39;Big City&#39;, Multan and Peshawar are &#39;Medium-sized city&#39;, Quetta
#is &#39;Small City&#39;

Select date, cmname, category, price, mktname,
Case when mktname in ('Karachi','Lahore') then 'Big City'
when mktname in ('Multan','Peshawar') then 'Medium-sized city'
else 'Small City'
end as city_category
from wfp_food_prices_pakistan;


 #Create a query to show date, cmname, city, price. Create new column
#price_fairness through CASE showing price is fair if less than 100,
#unfair if more than or equal to 100, if &gt; 300 then &#39;Speculative&#39;


Select date, cmname, mktname, price, case 
when price < 100 then 'fair'
when price >= 100 then 'unfair'
else 'speculative'
end as price_fairness
from wfp_food_prices_pakistan;

Select * from wfp_food_prices_pakistan;
Select * from commodity;

#Join the food prices and commodities table with a left join.
# can use a * in case whole table we have just drafted this query to check 

Select a.cmname, a.category, a.price, b.category
from wfp_food_prices_pakistan a left join commodity b
on a.cmname = b.cmname;


#Join the food prices and commodities table with an inner join
# can use a * in case whole table we have just drafted this query to check 

Select  a.cmname, a.category, a.price, b.category
from wfp_food_prices_pakistan a inner join commodity b
on a.cmname = b.cmname;


 