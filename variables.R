texas_acs_code <- "48"
harris_county_acs_code <- "201"

age_labels <- c(
  "Estimate!!Total!!Total population!!AGE!!Under 5 years",
  "Estimate!!Total!!Total population!!AGE!!5 to 9 years",
  "Estimate!!Total!!Total population!!AGE!!10 to 14 years",
  "Estimate!!Total!!Total population!!AGE!!15 to 19 years",
  "Estimate!!Total!!Total population!!AGE!!20 to 24 years",
  "Estimate!!Percent!!Total population!!AGE!!Under 5 years",
  "Estimate!!Percent!!Total population!!AGE!!5 to 9 years",
  "Estimate!!Percent!!Total population!!AGE!!10 to 14 years",
  "Estimate!!Percent!!Total population!!AGE!!15 to 19 years",
  "Estimate!!Percent!!Total population!!AGE!!20 to 24 years"
)

poverty_labels <- c(
  "Estimate!!Below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years",
  "Estimate!!Below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years!!Under 5 years",
  "Estimate!!Below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years!!5 to 17 years",
  "Estimate!!Percent below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years",
  "Estimate!!Percent below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years!!Under 5 years",
  "Estimate!!Percent below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years!!5 to 17 years"
)

language_labels <- c(
  "Estimate!!Total!!Population 5 years and over!!Speak only English",
  "Estimate!!Total!!Population 5 years and over!!SPEAK A LANGUAGE OTHER THAN ENGLISH!!Spanish",
  "Estimate!!Total!!Population 5 years and over!!SPEAK A LANGUAGE OTHER THAN ENGLISH!!Other languages",
  "Estimate!!Total!!Population 5 years and over!!SPEAK A LANGUAGE OTHER THAN ENGLISH!!Other Indo-European languages",
  "Estimate!!Total!!Population 5 years and over!!SPEAK A LANGUAGE OTHER THAN ENGLISH!!Asian and Pacific Island languages",
  "Estimate!!Percent!!Population 5 years and over!!Speak only English",
  "Estimate!!Percent!!Population 5 years and over!!SPEAK A LANGUAGE OTHER THAN ENGLISH!!Spanish",
  "Estimate!!Percent!!Population 5 years and over!!SPEAK A LANGUAGE OTHER THAN ENGLISH!!Other languages",
  "Estimate!!Percent!!Population 5 years and over!!SPEAK A LANGUAGE OTHER THAN ENGLISH!!Other Indo-European languages",
  "Estimate!!Percent!!Population 5 years and over!!SPEAK A LANGUAGE OTHER THAN ENGLISH!!Asian and Pacific Island languages"
)

opp_youth_labels <- c(
  "Estimate!!Unemployment rate!!Population 16 years and over",
  "Estimate!!Unemployment rate!!Population 16 years and over!!AGE!!16 to 19 years",
  "Estimate!!Unemployment rate!!Population 16 years and over!!AGE!!20 to 24 years"
)

household_type_labels <- c(
  "Estimate!!HOUSEHOLDS BY TYPE!!Total households!!Married-couple family!!With own children of the householder under 18 years",
  "Estimate!!HOUSEHOLDS BY TYPE!!Total households!!Cohabiting couple household!!With own children of the householder under 18 years",
  "Estimate!!HOUSEHOLDS BY TYPE!!Total households!!Male householder, no spouse/partner present!!With own children of the householder under 18 years",
  "Estimate!!HOUSEHOLDS BY TYPE!!Total households!!Female householder, no spouse/partner present!!With own children of the householder under 18 years",
  "Estimate!!GRANDPARENTS!!Number of grandparents living with own grandchildren under 18 years!!Grandparents responsible for grandchildren",
  "Percent!!HOUSEHOLDS BY TYPE!!Total households!!Married-couple family!!With own children of the householder under 18 years",
  "Percent!!HOUSEHOLDS BY TYPE!!Total households!!Cohabiting couple household!!With own children of the householder under 18 years",
  "Percent!!HOUSEHOLDS BY TYPE!!Total households!!Male householder, no spouse/partner present!!With own children of the householder under 18 years",
  "Percent!!HOUSEHOLDS BY TYPE!!Total households!!Female householder, no spouse/partner present!!With own children of the householder under 18 years",
  "Percent!!GRANDPARENTS!!Number of grandparents living with own grandchildren under 18 years!!Grandparents responsible for grandchildren"
  
)

health_care_coverage_labels <-c(
  "Estimate!!Uninsured!!Civilian noninstitutionalized population!!AGE!!Under 6 years",
  "Estimate!!Uninsured!!Civilian noninstitutionalized population!!AGE!!6 to 18 years",
  "Estimate!!Percent Uninsured!!Civilian noninstitutionalized population!!AGE!!Under 6 years",
  "Estimate!!Percent Uninsured!!Civilian noninstitutionalized population!!AGE!!6 to 18 years"
)