-- №1

SELECT
	id,
	url,
	(SELECT first_name FROM users WHERE users.id=video.owner_id) AS first_name,
	(SELECT first_name FROM users WHERE users.id=video.owner_id) AS last_name,
	(SELECT
		(SELECT url FROM photo WHERE photo.id=users.main_photo_id)
		FROM users WHERE users.id=video.owner_id) AS main_photo_url,
	size
FROM video
ORDER BY size DESC LIMIT 15;

--№2

SELECT video.id,
	first_name,
	last_name,
	photo.url AS main_photo url,
	video.url AS video_url,
	video.size
FROM users
	JOIN video
	ON video.owner_id = users.id
	LEFT JOIN photo
	ON photo.id = users.main_photo_id
ORDER BY size DESC
LIMIT 10;



--№3

CREATE TEMPORARY TABLE big_video (
	id INT,
	url VARCHAR(150),
	size INT,
	owner_id INT
);

INSERT INTO big_video
	SELECT id, url, size, owner_id
	FROM video
	ORDER BY size DESC
	LIMIT 15;

SELECT big_video.id,
	first_name,
	last_name,
	photo.url AS main_photo_url,
	big_video.url AS video_url,
	big_video.size
FROM users
	JOIN big_video
	ON big_video.owner_id = users.id
	LEFT JOIN photo
	ON photo.id = users.main_photo.id
;




--№4

WITH big_video AS
	(SELECT id, url, size, owner_id FROM video
	ORDER BY size DESC LIMIT 15)
SELECT big_video.id,
	first_name,
	last_name,
	photo.url AS main_photo_url,
	big_video.url AS video_url,
	big_video.size
FROM users
	JOIN big_video
	ON big_video.owner_id = users.id
	LEFT JOIN photo
	ON photo.id = users.main_photo.id
ORDER BY size DESC;

