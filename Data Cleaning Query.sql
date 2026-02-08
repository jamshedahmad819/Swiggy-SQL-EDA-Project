-- 1. Standardizing Strings
UPDATE swiggy_restaurants
SET name = TRIM(name),
    city = TRIM(city),
    cuisine = TRIM(cuisine);

-- 2. Handling Missing Values (Data Imputation)
SELECT COUNT(*) FROM swiggy_restaurants WHERE cuisine IS NULL;

-- 3. If cuisine is missing, we label it as 'Unknown' so it doesn't break our GROUP BY queries
UPDATE swiggy_restaurants
SET cuisine = 'Unknown' 
WHERE cuisine IS NULL OR cuisine = '';

-- 4. Some restaurants might have a rating of 0 which usually means 'No reviews yet'
-- We keep them, but we should know how many there are.
SELECT COUNT(*) FROM swiggy_restaurants WHERE rating = 0;


-- 4. Even though 'id' is a Primary Key, sometimes the same restaurant 
-- appears with a different ID. Let's check for duplicate names in the same city.
SELECT name, city, cuisine, COUNT(*)
FROM swiggy_restaurants
GROUP BY name, city, cuisine
HAVING COUNT(*) > 1;

-- 5. Drop unncessesary columns, we dont need column
-- 'Link' 
Alter Table swiggy_restaurants
Drop column link ;

-- 5. Final Verification
SELECT * FROM swiggy_restaurants LIMIT 10;