## SQL Queries for Aggregate Function and Operators

 **Changing the date column to date format**
 
```sql
set sql_safe_updates = 0;
update wfp_food_prices_pakistan set `date` = str_to_date(`date`, '%m/%d/%y');
alter table wfp_food_prices_pakistan modify `date` date;
```
** Output **
The date format has been applied and it is changed.


Select dates and commodities for cities Quetta, Karachi, and
Peshawar where price was less than or equal 50 PKR


**Output**
|date       | cmname                          | mktname  |  price|
|-----------|---------------------------------|----------|-------|
|2004-01-15 | Wheat flour - Retail            | Quetta   | 13    |
|2004-01-15 | Rice (basmati, broken) - Retail | Quetta   | 20    |
|2004-01-15 | Wheat flour - Retail            | Peshawar | 12    |
|2004-01-15 | Rice (basmati, broken) - Retail | Peshawar | 17.585|
|2004-01-15 | Wheat flour - Retail            | Karachi  |14.005 |

Note: This is not all input, the table is reduce to depict only few values for spacing issues.

 
**Observations against each market/city in PK**

```sql
Select mktname, count(*) as total_obs from wfp_food_prices_Pakistan 
group by mktname;
```

**Output**
| mktname  | total_obs |
|----------|-----------|
| Quetta   | 1453      |
| Peshawar | 1555      |
| Lahore   | 1550      |
| Multan   | 1550      |
| Karachi  | 1554      |


**Number of Distinct Cities**
```sql
Select count(distinct(mktname)) as totalmarkets
 from wfp_food_prices_Pakistan;
```
**Output**
| Total Markets |
|---------------|
| 5             |


**Names of Markets/cities in data**
```sql
Select distinct(mktname) as MarketNames
 from wfp_food_prices_Pakistan;
```

**Output**

| Market Names |
|--------------|
| Quetta       |
| Peshawar     |
| Lahore       |
| Multan       |
| Karachi      |


**Names of Commodities in data**

```sql
Select distinct(cmname) as commodities
 from wfp_food_prices_Pakistan;
```


**Output**


| Commodities               |
|---------------------------|
| Wheat flour - Retail      |
| Rice (coarse) - Retail    |
| Lentils (masur) - Retail  |
| Milk - Retail             |
| Oil (cooking) - Retail    |

Note: This is not all input, the table is reduce to depict only few values for spacing issues.

**Average Prices for Wheat flour - Retail in EACH city separately over the entire period**

```SQL
 Select mktname, cmname, round(avg(price),2) as average_price
 from wfp_food_prices_Pakistan
 where cmname = 'Wheat flour - Retail'
 Group by mktname;
```

**Output**

| Market Name | Commodity            | Average Price |
|-------------|----------------------|---------------|
| Quetta      | Wheat flour - Retail | 30.34         |
| Peshawar    | Wheat flour - Retail | 29.49         |
| Lahore      | Wheat flour - Retail | 28.55         |
| Multan      | Wheat flour - Retail | 27.97         |
| Karachi     | Wheat flour - Retail | 32.45         |





