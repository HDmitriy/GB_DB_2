ALTER TABLE users
	ADD CONSTRAINT users_main_photo_id_fk
	FOREIGN KEY (main_photo_id)
	REFERENCES photo (id);

ALTER TABLE messages
	ADD CONSTRAINT messages_from_user_id_fk
	FOREIGN KEY (from_user_id)
	REFERENCES users (id);

ALTER TABLE messages
	ADD CONSTRAINT messages_to_user_id_fk
	FOREIGN KEY (to_user_id)
	REFERENCES users (id);

ALTER TABLE friendship
	ADD CONSTRAINT requested_by_user_id_fk
	FOREIGN KEY (requested_by_user_id)
	REFERENCES users (id);

ALTER TABLE friendship
	ADD CONSTRAINT requested_to_user_id_fk
	FOREIGN KEY (requested_to_user_id)
	REFERENCES users (id);

ALTER TABLE friendship
	ADD CONSTRAINT status_id_fk
	FOREIGN KEY (status_id)
	REFERENCES  friendship_statuses (id);

ALTER TABLE communities
	ADD CONSTRAINT creator_id_fk
	FOREIGN KEY (creator_id)
	REFERENCES  users (id);

ALTER TABLE communities_users
	ADD CONSTRAINT community_id_fk
	FOREIGN KEY (community_id)
	REFERENCES  communities (id);

ALTER TABLE communities_users
	ADD CONSTRAINT user_id_fk
	FOREIGN KEY (user_id)
	REFERENCES  users (id);

ALTER TABLE photo
	ADD CONSTRAINT owner_id_fk
	FOREIGN KEY (owner_id)
	REFERENCES  users (id);
	
	
-- №3

ALTER TABLE photo ADD COLUMN metadata JSON;
UPDATE photo SET metadata = json_build_object(
	'id', id,
	'url', url,
	'size' size
);
