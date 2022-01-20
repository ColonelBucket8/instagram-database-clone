-- 1. Finding 5 oldest users

SELECT username, created_at FROM users ORDER BY created_at LIMIT 5;

-- 2. Most Popular Registration Date

SELECT DAYNAME(created_at) AS day, 
    COUNT(DAYNAME(created_at)) AS total FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 1;

-- 3. Identify Inactive Users (users with no photos)

SELECT username FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL