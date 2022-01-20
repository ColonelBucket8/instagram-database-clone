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

-- 4. Identify most popular photo (and user who created it)

SELECT username, photos.id, image_url, COUNT(likes.photo_id) AS likes FROM users
INNER JOIN photos
    ON users.id = photos.user_id
INNER JOIN likes
    ON photos.id = likes.photo_id
GROUP BY photos.id
ORDER BY likes DESC
LIMIT 1;
