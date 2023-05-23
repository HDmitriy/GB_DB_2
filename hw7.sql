-- №1

SELECT 
	users.id,
	friendship.requested_by_user_id,
	friendship.requested_to_user_id,
FROM users
	LEFT JOIN friendship
		ON users.id = friendship.requested_by_user_id,
			OR users.id = friendship.requested_to_user_id;

SELECT
	users.id,
	friendship.requested_by_user_id,
	friendship.requested_to_user_id
FROM users
	LEFT JOIN friendship
		ON users.id = friendship.requested_by_user_id,
			OR users.id = friendship.requested_to_user_id
WHERE friendship.requested_by_user_id IS NULL
	AND friendship.requested_to_user_id IS NULL;

SELECT 
	users.id,
	friendship.requested_by_user_id,
	friendship.requested_to_user_id,
	friendship_statuses.id,
	friendship_statuses.name
FROM users
	LEFT JOIN friendship
		ON users.id = friendship.requested_by_user_id,
			OR users.id = friendship.requested_to_user_id
	LEFT JOIN friendship_statuses
		ON friendship.status_id = friendship_statuses.id 
WHERE friendship_statuses.name = ('accepted');

SELECT DISTINCT users.id
FROM users
	LEFT JOIN friendship
		ON users.id = friendship.requested_by_user_id,
			OR users.id = friendship.requested_to_user_id;
	LEFT JOIN friendship_statuses
		ON friendship.status_id = friendship_statuses.id 
WHERE friendship_statuses.name = ('accepted');

DROP VIEW users_accepted_friendship;
CREATE VIEW users_accepted_friendship; AS 
SELECT DISTINCT users.id
FROM users
	LEFT JOIN friendship
		ON users.id = friendship.requested_by_user_id,
			OR users.id = friendship.requested_to_user_id;
	LEFT JOIN friendship_statuses
		ON friendship.status_id = friendship_statuses.id 
WHERE friendship_statuses.name = ('accepted');

DROP VIEW users_without_accepted_friendship;
CREATE VIEW users_without_accepted_friendship; AS 
SELECT id FROM users WHERE id NOT IN 
	(SELECT id FROM users_accepted_friendship);

BEGIN;

	DELETE 
		FROM photo
			USING users_without_accepted_friendship
		WHERE photo.owner_id = users_without_accepted_friendship.id;

-- Повторяем так со всеми данными

--№2

WITH users_photo_and_video_rating AS (
SELECT DISTINCT
	users.first_name,
	users.last_name,
	photo.count,
	video_count
	FROM users 
		JOIN (
			SELECT DISTINCT
			users.id,
			COUNT(photo.id) OVER (PARTITION BY users.id) AS photo_count		
				FROM users
					LEFT JOIN photo
						ON users.id = photo.owner_id
 ) AS selected_photo_count 
	ON users.id = selected_photo_count.id 
	JOIN (
		SELECT DISTINCT
			users.id,
			COUNT(video.id) OVER (PARTITION BY users.id) AS video_count		
				FROM users
					LEFT JOIN video
						ON users.id = video.owner_id
	) AS selected_video_count
		ON users.id = selected_video_count.id)

SELECT 
	first_name,
	last_name,
	photo_count,
	video_count,
	DENSE_RANK() OVER (ORDER BY photo_count DESC) AS photo_rank,
	DENSE_RANK() OVER (ORDER BY video_count DESC) AS video_rank
		FROM users_photo_and_video_rating
ORDER BY photo_rank, video_rank;

