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
\text{score} = S(z_{\text{business}} + z_{\text{stops}} + z_{\text{polls}} + z_{\text{schools}})
$$

| **metric** | **definition** | **file** | **data source** |
|---|---|---|---|
| business | selected industry businesses per 1000 people | `Businesses.csv` | [ABS](https://www.abs.gov.au/statistics/economy/business-indicators/counts-australian-businesses-including-entries-and-exits/latest-release#data-downloads_) |
| stops | number of public transport stops | `Stops.txt` | [transport for nsw](https://opendata.transport.nsw.gov.au/dataset/timetables-complete-gtfs) |
| polls | federal election polling locations (as of 2019) | `PollingPlaces2019.csv` | [australian electoral commission](https://data.aurin.org.au/dataset/au-govt-aec-aec-federal-election-polling-places-2019-na) |
| schools | school catchments areas per 1000 **young people** | `SchoolCatchments.zip` | [nsw dept of education](https://data.cese.nsw.gov.au/data/dataset/school-intake-zones-catchment-areas-for-nsw-government-schools) |

here, $S$ is the [sigmoid function](https://en.wikipedia.org/wiki/Sigmoid_function), $z$ is the normalised [z-score](https://en.wikipedia.org/wiki/Standard_score), and 'young people' is defined as anyone aged 0-19 years old. we only need to calculate scores for SA2 regions with a population of at least 100, and we can extend the scoring function however we deem necessary, if a rational explanation is provided. (e.g. other mathematical standardisation techniques, mitigating the impact of outliers, calculating some metrics per-capita or per-sqkm etc)

we are being encouraged to extend the scoring function, for example the $z_{\text{business}$ definition is intentionally broad. we need to select a cross-section of specific industries within the provided dataset (e.g. "retail trade") that we believe will be the best refelction of how "bustling" the area is. we need to describe this rationale in ther report.