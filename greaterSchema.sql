CREATE SCHEMA IF NOT EXISTS greater_sydney;

DROP TABLE IF EXISTS Business;
CREATE TABLE Business(
industry VARCHAR(255),
sa2_code INTEGER,
sa2_name VARCHAR(255),
0_to_50k_businesses INTEGER,
50k_to_200k_businesses INTEGER,
200k_to_2m_businesses INTEGER,
2m_to_5m_businesses INTEGER,
5m_to_10m_businesses INTEGER,
10m_or_more_businesses INTEGER,
total_businesses INTEGER
);

DROP TABLE IF EXISTS Stops;
CREATE TABLE Stops(
stop_id INTEGER,
stop_name VARCHAR(255),
location_type FLOAT,
geom GEOMETRY(POINT,4283)
);

DROP TABLE IF EXISTS Polls;
CREATE TABLE Polls(
division_id INTEGER,
division_name VARCHAR(255),
polling_place_id INTEGER,
polling_place_type_id INTEGER,
polling_place_name VARCHAR(255),
premises_name VARCHAR(255),
premises_suburb VARCHAR(255),
premises_post_code FLOAT,
geom GEOMETRY(POINT,4283)
);

DROP TABLE IF EXISTS Population;
CREATE TABLE Population (
sa2_code INTEGER,
sa2_name VARCHAR(255),
0_4_people INTEGER,
5_9_people INTEGER,
10_14_people INTEGER,
15_19_people INTEGER,
20_24_people INTEGER,
25_29_people INTEGER,
30_34_people INTEGER,
35_39_people INTEGER,
40_44_people INTEGER,
45_49_people INTEGER,
50_54_people INTEGER,
55_59_people INTEGER,
60_64_people INTEGER,
65_69_people INTEGER,
70_74_people INTEGER,
75_79_people INTEGER,
80_84_people INTEGER,
85_and_over_people INTEGER
);

DROP TABLE IF EXISTS Income;
CREATE TABLE Income(
sa2_code INTEGER,
sa2_name VARCHAR(100),
earners INTEGER,
median_age INTEGER,
median_income INTEGER,
mean_income INTEGER
);

DROP TABLE IF EXISTS Primary_School;
CREATE TABLE Primary_School(
use_id INTEGER,
catch_type VARCHAR(50),
use_desc VARCHAR(100),
add_date INTEGER,
geom GEOMETRY(MULTIPOLYGON,4283)
);

DROP TABLE IF EXISTS Secondary_School;
CREATE TABLE Secondary_School(
use_id INTEGER,
catch_type VARCHAR(50),
use_desc VARCHAR(100),
add_date INTEGER,
geom GEOMETRY(MULTIPOLYGON,4283)
);

DROP TABLE IF EXISTS Future_School;
CREATE TABLE Future_School(
use_id INTEGER,
catch_type VARCHAR(50),
use_desc VARCHAR(100),
add_date INTEGER,
geom GEOMETRY(MULTIPOLYGON,4283)
);

CREATE TABLE Greater_Sydney_Regions (
sa2_code21 INTEGER,
sa2_name21 VARCHAR(255),
gcc_code21 VARCHAR(255),
gcc_name21 VARCHAR(255),
area FLOAT,
geom GEOMETRY(MULTIPOLYGON,4283)
);
