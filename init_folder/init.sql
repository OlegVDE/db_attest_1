CREATE TABLE IF NOT EXISTS public.stations
(
  lat FLOAT,
  loc VARCHAR,
  lon FLOAT,
  name VARCHAR,
  station_id smallint PRIMARY KEY,
  status VARCHAR
);

COPY public.stations
FROM '/docker-entrypoint-initdb.d/austin_bikeshare_stations.csv'
CSV HEADER;


CREATE TABLE IF NOT EXISTS public.trips
(
  bikeid float,
  checkout_time time,
  duration_minutes smallint,
  end_station_id float,
  end_station_name VARCHAR,
  month float,
  start_station_id float,
  start_station_name VARCHAR,
  start_time timestamp,
  subscriber_type VARCHAR,
  trip_id bigint,
  year float
);

COPY public.trips
FROM '/docker-entrypoint-initdb.d/austin_bikeshare_trips.csv'
CSV HEADER;

--Нужно заполнить год, где его нет из времени старта:
UPDATE public.trips 
SET year = EXTRACT(YEAR FROM start_time)
WHERE year IS NULL;