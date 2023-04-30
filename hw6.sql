-- №1

CREATE VIEW video_info_by_size AS
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


CREATE VIEW video_upload_last_month AS
SELECT * FROM video
	WHERE uploaded_at > (current_timestamp - interval '1 month');


UPDATE video_upload_last_month SET description = 'Descrip' WHERE id = 1;



--№2

CREATE OR REPLACE PROCEDURE check_owner_photo ()

LANGUAGE SQL AS

-- TODO SELECT * FROM photo WHERE photo.owner_id=user.id

$$


$$

