texas_acs_code <- "48"
harris_county_acs_code <- "201"

age_labels = data.frame(
  acs_label = c(
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
  ), 
  display_label = c(
    "Total population Under 5 years",
    "Total population 5 to 9 years",
    "Total population 10 to 14 years",
    "Total population 15 to 19 years",
    "Total population 20 to 24 years",
    "Percent Under 5 years",
    "Percent 5 to 9 years",
    "Percent 10 to 14 years",
    "Percent 15 to 19 years",
    "Percent 20 to 24 years"
  )
)

poverty_labels = data.frame(
  acs_label = c(
    "Estimate!!Below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years",
    "Estimate!!Below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years!!Under 5 years",
    "Estimate!!Below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years!!5 to 17 years",
    "Estimate!!Percent below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years",
    "Estimate!!Percent below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years!!Under 5 years",
    "Estimate!!Percent below poverty level!!Population for whom poverty status is determined!!AGE!!Under 18 years!!5 to 17 years"
  ), 
  display_label = c(
    "Below poverty level Under 18 years",
    "Below poverty level Under 5 years",
    "Below poverty level 5 to 17 years",
    "Percent below poverty level Under 18 years",
    "Percent below poverty level Under 5 years",
    "Percent below poverty level 5 to 17 years"
  )
)

language_labels = data.frame(
  acs_label = c(
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
  ), 
  display_label = c(
    "Total Population 5 years and over who Speak only English",
    "Total Population 5 years and over who speak a language other than English: Spanish",
    "Total Population 5 years and over who speak a language other than English: Other languages",
    "Total Population 5 years and over who speak a language other than English: Other Indo-European languages",
    "Total Population 5 years and over who speak a language other than English: Asian and Pacific Island languages",
    "Percent Population 5 years and over who Speak only English",
    "Percent Population 5 years and over who speak a language other than English: Spanish",
    "Percent Population 5 years and over who speak a language other than English: Other languages",
    "Percent Population 5 years and over who speak a language other than English: Other Indo-European languages",
    "Percent Population 5 years and over who speak a language other than English: Asian and Pacific Island languages"
  )
)

opp_youth_labels = data.frame(
  acs_label = c(
    "Estimate!!Unemployment rate!!Population 16 years and over",
    "Estimate!!Unemployment rate!!Population 16 years and over!!AGE!!16 to 19 years",
    "Estimate!!Unemployment rate!!Population 16 years and over!!AGE!!20 to 24 years"
  ),
  display_label = c(
    "Unemployment ratePopulation 16 years and over",
    "Unemployment rate 16 to 19 years",
    "Unemployment rate 20 to 24 years"
  )
)

household_type_labels = data.frame(
  acs_label = c(
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
  ), 
  display_label = c(
    "Total households Married-couple family With own children of the householder under 18 years",
    "Total households Cohabiting couple household With own children of the householder under 18 years",
    "Total households Male householder, no spouse/partner present With own children of the householder under 18 years",
    "Total households Female householder, no spouse/partner present With own children of the householder under 18 years",
    "Number of grandparents living with own grandchildren under 18 years Grandparents responsible for grandchildren",
    "Percent households Married-couple family With own children of the householder under 18 years",
    "Percent households Cohabiting couple household With own children of the householder under 18 years",
    "Percent households Male householder, no spouse/partner present With own children of the householder under 18 years",
    "Percent households Female householder, no spouse/partner present With own children of the householder under 18 years",
    "Percent of households withgrandparents living with own grandchildren under 18 years Grandparents responsible for grandchildren"
  )
)

health_care_coverage_labels = data.frame(
  acs_label = c(
    "Estimate!!Uninsured!!Civilian noninstitutionalized population!!AGE!!Under 6 years",
    "Estimate!!Uninsured!!Civilian noninstitutionalized population!!AGE!!6 to 18 years",
    "Estimate!!Percent Uninsured!!Civilian noninstitutionalized population!!AGE!!Under 6 years",
    "Estimate!!Percent Uninsured!!Civilian noninstitutionalized population!!AGE!!6 to 18 years"
  ), 
  display_label = c(
    "Uninsured Civilian noninstitutionalized population Under 6 years",
    "Uninsured Civilian noninstitutionalized population 6 to 18 years",
    "Percent Uninsured Civilian noninstitutionalized population Under 6 years",
    "Percent Uninsured Civilian noninstitutionalized population 6 to 18 years"
  )
)

new_american_children_element_variables <-c(
  "B05009_005", # Estimate!!Total:!!Under 6 years:!!Living with two parents:!!Child is foreign born
  "B05009_008", # Estimate!!Total:!!Under 6 years:!!Living with two parents:!!Both parents foreign born:!!Child is native
  "B05009_018", # Estimate!!Total:!!Under 6 years:!!Living with one parent:!!Foreign-born parent:!!Child is native
  "B05009_023", # Estimate!!Total:!!6 to 17 years:!!Living with two parents:!!Child is foreign born
  "B05009_026", # Estimate!!Total:!!6 to 17 years:!!Living with two parents:!!Both parents foreign born:!!Child is native
  "B05009_036"  # Estimate!!Total:!!6 to 17 years:!!Living with one parent:!!Foreign-born parent:!!Child is native
)
