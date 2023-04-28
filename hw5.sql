-- №1

CREATE ROLE testers;
CREATE ROLE analysts;

CREATE USER fedors;
CREATE USER romanb;

GRANT analysts TO fedors;
GRANT testers TO romanb;

ALTER ROLE fedors WITH PASSWORD '123';
ALTER ROLE romanb WITH PASSWORD '321';

GRANT ALL ON ALL TABLES IN SCHEMA public TO testers;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO testers;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO analysts;



--№2

CREATE EXTENSION "uuid-ossp";

postgres=# SELECT * FROM pg_extension WHERE extname = 'uuid-ossp';