connection: "big-query-international-census"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: international_census_data_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: international_census_data_default_datagroup

explore: birth_death_growth_rates {    join: age_specific_fertility_rates {
    sql_on: ${birth_death_growth_rates.country_code} = ${age_specific_fertility_rates.country_code} AND ${birth_death_growth_rates.year} = ${age_specific_fertility_rates.year} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: midyear_population {
    sql_on: ${birth_death_growth_rates.country_code} = ${midyear_population.country_code} AND ${birth_death_growth_rates.year} = ${midyear_population.year} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: country_names_area {
    sql_on: ${birth_death_growth_rates.country_code} = ${country_names_area.country_code} ;;
    relationship: one_to_one
    type: left_outer
  }
  }

explore: age_specific_fertility_rates {}

explore: midyear_population_5yr_age_sex {}

explore: mortality_life_expectancy {
  join: midyear_population {
    sql_on: ${mortality_life_expectancy.country_code} = ${midyear_population.country_code} AND ${mortality_life_expectancy.year} = ${midyear_population.year} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: country_names_area {
    sql_on: ${mortality_life_expectancy.country_code} = ${country_names_area.country_code} ;;
    relationship: one_to_one
    type: left_outer
  }}

explore: country_names_area {}

explore: midyear_population_age_sex {  join: midyear_population {
    sql_on: ${midyear_population.country_code} = ${midyear_population.country_code} AND ${midyear_population.year} = ${midyear_population.year} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: country_names_area {
    sql_on: ${midyear_population.country_code} = ${country_names_area.country_code} ;;
    relationship: one_to_one
    type: left_outer
  }}

explore: midyear_population {}

explore: midyear_population_agespecific {}
