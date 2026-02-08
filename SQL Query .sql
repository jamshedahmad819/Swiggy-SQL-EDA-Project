-- Number of Restaurants in Each City

Select city, Count(*) as restaurant_count
from swiggy_restaurants
group by city
order by restaurant_count desc;

-- Most Popular Cuisines

SELECT cuisine,count(*) AS total_restaurants
from swiggy_restaurants
group by cuisine
order by total_restaurants desc
LIMIT 10;

-- Best Rated Cities

SELECT city, round(avg(rating), 2) as avg_city_rating
from swiggy_restaurants
GROUP BY city
ORDER BY avg_city_rating desc
limit 10;

-- High-Quality & Affordable Restaurants by City

SELECT city, count(*) AS value_restaurants
from swiggy_restaurants
where rating >= 4.0
and cost < 300
group by city
order by value_restaurants desc;

-- Restaurants with Strongest Customer Engagement

SELECT name, city, rating, rating_count
from swiggy_restaurants
order by rating_count desc
limit 10;

-- Which cuisines consistently receive high ratings?

SELECT cuisine, round(avg(rating),2) as high_ratings
from swiggy_restaurants
group by cuisine
order by high_ratings desc
limit 10;

-- Restaurant Market Segmentation by Price

SELECT case
when cost < 200 then 'Budget'
when cost between 200 and 500 then 'Mid-range'
else'Premium'
end as  price_segment,
count(*) AS total_restaurants
from swiggy_restaurants
group by price_segment
order by total_restaurants DESC;

-- Best Restaurant In Every City
WITH CityRankings AS (
select city, name, rating, rating_count,
dense_rank() over(partition by city order by rating desc, rating_count desc) as rank_num
from swiggy_restaurants
)
SELECT city, name, rating, rating_count
from CityRankings
where rank_num = 1;

-- Overall Pricing Distribution

SELECT 
min(cost) AS lowest_price,
max(cost) AS highest_price,
ROUND(avg(cost), 2) AS average_price
from swiggy_restaurants;





