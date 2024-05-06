# greater-sydney-analysis

## introduction

- aus has 2000 "statistical area level 2" (SA2) distinct geographical regions which represent communities.
- **for this assignment**, we focus on the 350+ SA2s within **Greater Sydney**.

> :exclamation: our task is the **develop a "bustling" metric for each SA2 region** of Greater Sydney - trying to quantify just how busy the districts in our city are.

## preparation

steps include:

1. initial **data loading** and **cleaning** in `python`
2. `sql` is used to **merge datasets** and **produce scores**.
3. code and results are to be collated in a neat, concise `Jupyter notebook` file.

***Week-8*** tutorial covers instructions for managing spatial data and installing `PostGIS`.

clicking this link will download a shapefile for the SA2 digital boundaries from the ABS website: [Greater Sydney SA2 Shapefile](https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/SA2_2021_AUST_SHP_GDA2020.zip). 

we need to use these alongside the data sources on canvas.

## tasks

### task 1
- **import** all datasets.
- **clean** data in `python`.
- make a data schema.
- **transport** data to `postgresql`.

the sources we have on canvas are:
- sa2 regions
- businesses: number of businesses by industry and sa2 region, reported by turnover size
- stops: locations of all PT stops (train and bus) in ***General Transit Feed Specification*** (GTFS) format
- polls: locations of polling places for the 2019 federal election
- schools: geographical regions in which students must live to attend primary, secondary and future govt schools.
- population: estimates the number of people living in each SA2 by age range (for "per capita" calculations)
- income: total earnings statistics by SA2

> :warning: we need to make sure that our spatial datasets consider the correct SRID, which can differ between datasets (e.g. 4283, vs 4326).

### task 2
we need to compute a score for how "bustling" each neighbourhood is, according to the following formula:

$$
\text{doin}
$$