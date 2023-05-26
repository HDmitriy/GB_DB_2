SELECT
	id,
	url,
	(SELECT first_name FROM users WHERE users.id=video.owner_id) AS first_name,
	(SELECT last_name FROM users WHERE users.id=video.owner_id) AS last_name
FROM video
-- Большинство запросов можно отпимизировать переведя в JOIN 

SELECT
	video.id,
	url,
	last_name,
	first_name
FROM video
	JOIN users
	ON video.owner_id = users.id
LIMIT 5;

-- Индексы ускоряют поиск по запросу, благодаря индексу user_pkey, что создается автоматически дополнительные можно не создавать
-- Всегда стоит ограничивать количество строк LIMITом, если только не нужны все, для быстроты поиска
-- Всегда нужно оптимизировать запросы для кеша запросов.
