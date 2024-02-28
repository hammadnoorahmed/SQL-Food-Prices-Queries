**Summary Stats**

Calculate summary stats (avg price, max price) for each city separately for all cities except Karachi and sort alphabetically the
city names, commodity names where commodity is Wheat (does not matter which one) with separate rows for each commodity


```Sql
Select mktname, cmname, round(avg(price),2) as average_price, max(price) as maximum_price
from wfp_food_prices_pakistan
where mktname not in ('Karachi') And cmname like '%Wheat%'
group by mktname, cmname
Order by mktname ASC;

```


**Output**
| Market Name | Commodity            | Average Price | Maximum Price |
|-------------|----------------------|---------------|---------------|
| Lahore      | Wheat - Retail       | 27.75         | 41.266        |
| Lahore      | Wheat flour - Retail | 28.55         | 41.6          |
| Multan      | Wheat - Retail       | 26.44         | 40            |
| Multan      | Wheat flour - Retail | 27.97         | 43            |
| Peshawar    | Wheat - Retail       | 29.06         | 42            |
| Peshawar    | Wheat flour - Retail | 29.49         | 45.72         |
| Quetta      | Wheat - Retail       | 36.18         | 44            |
| Quetta      | Wheat flour - Retail | 30.34         | 47.5          |


**Average Price of each City For Basic Retail Price**


Calculate Avg_prices for each city for Wheat Retail and show only those avg_prices which are less than 30


```sql
Select mktname, cmname, round(avg(price),2) as average_price
from wfp_food_prices_pakistan
group by mktname, cmname
having avg(price) < 30 and cmname = 'Wheat - Retail';
```


**Output**
| Market Name | Commodity       | Average Price |
|-------------|-----------------|---------------|
| Peshawar    | Wheat - Retail  | 29.06         |
| Lahore      | Wheat - Retail  | 27.75         |
| Multan      | Wheat - Retail  | 26.44         |
| Karachi     | Wheat - Retail  | 29.45         |




**Categorization of Price using CASE Statement**

Prepare a table where you categorize prices based on a logic (price; 30 is LOW, price &gt; 250 is HIGH, in between are FAIR)


```sql
Select date, cmname, price, case
when price < 30 then 'low'
when price > 250 then 'high'
else 'fair'
end as price_value
from  wfp_food_prices_pakistan;
```


**Output**
| Date       | Commodity            | Price | Price Value |
|------------|----------------------|-------|-------------|
| 2004-01-15 | Wheat flour - Retail | 13    | low         |
| 2004-02-15 | Wheat flour - Retail | 13    | low         |
| 2004-03-15 | Wheat flour - Retail | 14.25 | low         |
| 2004-04-15 | Wheat flour - Retail | 12.5  | low         |
| 2004-05-15 | Wheat flour - Retail | 13.25 | low         |


Note that this output is not complete due to space issues.


**IN Operator for extracting information**

 
 Create a query showing date, cmname, category, city, price, city_category where Logic for city category is: Karachi and Lahore are Big City, Multan 
 and Peshawar are Medium-sized city, Quetta is Small City


```sql
Select date, cmname, category, price, mktname,
Case when mktname in ('Karachi','Lahore') then 'Big City'
when mktname in ('Multan','Peshawar') then 'Medium-sized city'
else 'Small City'
end as city_category
from wfp_food_prices_pakistan;
```


**Output**
| Date       | Commodity            | Category             | Price  | Market Name | City Category |
|------------|----------------------|----------------------|--------|-------------|---------------|
| 2004-01-15 | Wheat flour - Retail | cereals and tubers   | 13     | Quetta      | Small City    |
| 2004-02-15 | Wheat flour - Retail | cereals and tubers   | 13     | Quetta      | Small City    |
| 2004-03-15 | Wheat flour - Retail | cereals and tubers   | 14.25  | Quetta      | Small City    |
| 2004-04-15 | Wheat flour - Retail | cereals and tubers   | 12.5   | Quetta      | Small City    |
| 2004-05-15 | Wheat flour - Retail | cereals and tubers   | 13.25  | Quetta      | Small City    |
| 2004-06-15 | Wheat flour - Retail | cereals and tubers   | 13.405 | Quetta      | Small City    |


Note that this output is not full because of space issues.


**Price Fairness Check**


Create a query to show date, cmname, city, price. Create new column price_fairness through CASE showing price is fair if less than 100,
unfair if more than or equal to 100, if other then Speculative;


```sql
Select date, cmname, mktname, price, case 
when price < 100 then 'fair'
when price >= 100 then 'unfair'
else 'speculative'
end as price_fairness
from wfp_food_prices_pakistan;
```

**Output**
| Date       | Commodity            | Market Name | Price  | Price Fairness |
|------------|----------------------|-------------|--------|----------------|
| 2004-01-15 | Wheat flour - Retail | Quetta      | 13     | fair           |
| 2004-02-15 | Wheat flour - Retail | Quetta      | 13     | fair           |
| 2004-03-15 | Wheat flour - Retail | Quetta      | 14.25  | fair           |
| 2004-04-15 | Wheat flour - Retail | Quetta      | 12.5   | fair           |
| 2004-05-15 | Wheat flour - Retail | Quetta      | 13.25  | fair           |
| 2004-06-15 | Wheat flour - Retail | Quetta      | 13.405 | fair           |


Note that this output is not full because of space issues.


**Left Join**

Join the food prices and commodities table with a left join.


```sql
Select a.cmname, a.category, a.price, b.category
from wfp_food_prices_pakistan a left join commodity b
on a.cmname = b.cmname;
```

**Output**

Left join returns all the rows from left table which is food prices table along with the matching rows from right table which is commodity here.


| Commodity            | Category           | Price  | category |
|----------------------|--------------------|--------|----------|
| Wheat flour - Retail | cereals and tubers | 13     | food     |
| Wheat flour - Retail | cereals and tubers | 13     | food     |
| Wheat flour - Retail | cereals and tubers | 14.25  | food     |
| Wheat flour - Retail | cereals and tubers | 12.5   | food     |
| Wheat flour - Retail | cereals and tubers | 13.25  | food     |
| Wheat flour - Retail | cereals and tubers | 13.405 | food     |


Note that this output is not full because of space issues.


**Inner Join**


Join the food prices and commodities table with an inner join


```sql
Select  a.cmname, a.category, a.price, b.category as category2
from wfp_food_prices_pakistan a inner join commodity b
on a.cmname = b.cmname;
```


**Output**
Inner join returns the matching rows from both tables whenever cmname which is present in both table matches with each other. 


| Commodity            | Category           | Price  | Category2 |
|----------------------|--------------------|--------|-----------|
| Wheat flour - Retail | cereals and tubers | 13     | food      |
| Wheat flour - Retail | cereals and tubers | 13     | food      |
| Wheat flour - Retail | cereals and tubers | 14.25  | food      |
| Wheat flour - Retail | cereals and tubers | 12.5   | food      |
| Wheat flour - Retail | cereals and tubers | 13.25  | food      |


Note that this output is not full because of space issues.
