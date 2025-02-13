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

$$\text{score} = S(z_{\text{business}} + z_{\text{stops}} + z_{\text{polls}} + z_{\text{schools}})$$

| **metric** | **definition** | **file** | **data source** |
|---|---|---|---|
| business | selected industry businesses per 1000 people | `Businesses.csv` | [ABS](https://www.abs.gov.au/statistics/economy/business-indicators/counts-australian-businesses-including-entries-and-exits/latest-release#data-downloads_) |
| stops | number of public transport stops | `Stops.txt` | [transport for nsw](https://opendata.transport.nsw.gov.au/dataset/timetables-complete-gtfs) |
| polls | federal election polling locations (as of 2019) | `PollingPlaces2019.csv` | [australian electoral commission](https://data.aurin.org.au/dataset/au-govt-aec-aec-federal-election-polling-places-2019-na) |
| schools | school catchments areas per 1000 **young people** | `SchoolCatchments.zip` | [nsw dept of education](https://data.cese.nsw.gov.au/data/dataset/school-intake-zones-catchment-areas-for-nsw-government-schools) |

here, $S$ is the [sigmoid function](https://en.wikipedia.org/wiki/Sigmoid_function), $z$ is the normalised [z-score](https://en.wikipedia.org/wiki/Standard_score), and 'young people' is defined as anyone aged 0-19 years old. we only need to calculate scores for SA2 regions with a population of at least 100, and we can extend the scoring function however we deem necessary, if a rational explanation is provided. (e.g. other mathematical standardisation techniques, mitigating the impact of outliers, calculating some metrics per-capita or per-sqkm etc)

we are being encouraged to extend the scoring function, for example the $z_{\text{business}}$ definition is intentionally broad. we need to select a cross-section of specific industries within the provided dataset (e.g. "retail trade") that we believe will be the best refelction of how "bustling" the area is. we need to describe this rationale in ther report.

### Task 3
then we need to extend the score, by sourcing one additional dataset for each group member, and then incorporating these datasets into our scoring function. at least **one dataset should be of spatial data**, and at least one should be of a **type not used far** in this assignment ***(e.g. JSON, XML, or collated via web scraping)***.

any subject matter is permissible, but it just has to be reelvant to the calculation of the "bustling" metric (e.g. public facilities, other census statistics, local wildlife)

for either version of the scoring function:
- visualise your score in an engaging way and summarise key results in a table (including a useful map-overlau visualisation or an interactive graph)
- include **in-depth analysis** into results, noting 1. interesting findings, 2. limitations discussion, 3. summarised key conclusions
- determine if there is any **correlation** between the score and the median income of each region
- ensure at least one useful **index** (ideally spatial) has been used for your calculation

## TASKS BROKEN DOWN

as per the assignment [faqs](https://edstem.org/au/courses/14533/discussion/1950035):

### task 1

#### dataset ingestion
- achieved through combination of `jupyter notebook` and localhost database server, demonstrated in week 8 tutorial. 
- as per [#671](https://edstem.org/au/courses/14533/discussion/1931931) we clean the data using python first and then import into the postgresql database.
- as per [#744](https://edstem.org/au/courses/14533/discussion/1942944) we load data into the jupyter notebook after cleaning, and then use `create table` using SQL, and then using the `to_sql` function to input data into the database

#### data cleaning
- only completely remove data points if necessary. e.g., if a row has a null value, we shouldn't completely leave it out.
- we are welcome to filter down the abs digi boundaries to only the greater sydeny region

#### data semantics
- some datasets may require additional transformation, like overlap in school catchments. we will see what this means
- this part basically meant the data is up to date and we should look at the source websites for descriptions if we want

#### geospatial data
- consult week 8 tutorial to see how to handle common spatial errors such as handling polygons or latitude/longitutde coordinates.
- best practice is to use the public schema for PostGIS oeprations. this is just the default schema in the postgres database.

#### naming conventions
- some columns need renaming (e.g. one of the table names is `primary` which is a reserved keyword in SQL)
- may need to consider case sensitivity and ensure only lowercase is used for column and table names when ingesting data [#625](https://edstem.org/au/courses/14533/discussion/1924072)

### task 2

#### calculation logistics
- full marks requires calculation within SQL, z-scores and sigmoid functions included
- regions can be excluded if they have a population of less than 100

#### calculation logic
- there is intentional rationale for calculation components such as z-scores [#602](https://edstem.org/au/courses/14533/discussion/1920392)
- a couple of ed posts which talk about nuanced stuff, including 'per 1000 people' [#560](https://edstem.org/au/courses/14533/discussion/threads/560) and [#793](https://edstem.org/au/courses/14533/discussion/threads/793)
- we must consider the best strategies for outliers, as the wisest approach will differ case-by-case [#606](https://edstem.org/au/courses/14533/discussion/threads/606)

### task 3
most of the information here was negligible.