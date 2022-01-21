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

-- 5. Calculate avg number of photos per user
-- total number of photos / total number of users
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;

-- 6. Most popular hastags

SELECT tags.tag_name, COUNT(photo_tags.tag_id) AS total FROM photo_tags
INNER JOIN tags
    ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;

-- 7. Finding Bots - users who have liked every single photo

SELECT username, COUNT(likes.user_id) AS total_likes FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING total_likes = (SELECT COUNT(*) FROM photos);