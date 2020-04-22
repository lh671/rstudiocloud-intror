## -----------------------------------------------------------------------------------------------------
library(tidyverse) # libraries and packages are the same things

## -----------------------------------------------------------------------------------------------------
# Write csv and give the file a name
write_csv(iris, "iris.csv")


## -----------------------------------------------------------------------------------------------------
# read_csv(name.csv, tab) gives many options
iris_raw = read_csv("iris.csv" )


## -----------------------------------------------------------------------------------------------------
# Reading and writing to excel, downloads data in xlsx format as cannot read.
library(readxl)
library(writexl)
write_xlsx(iris, "iris.xlsx")
# Read excel file in csv.
read_excel("iris.xlsx")


## ----eval=FALSE---------------------------------------------------------------------------------------
## library(haven)
## write_dta( iris, "iris.dta")
## read_stata("iris.dta")


## ----eval=FALSE, tidy=TRUE----------------------------------------------------------------------------
## # above ensures 'tidy coding on output'
## # creating a report on your dataset - VERY COOL 🥳️
## DataExplorer::create_report(iris_raw, y="Species")


## -----------------------------------------------------------------------------------------------------
# Insert iris into pipes, avoids nested brackets. ctrl/comm+shift+m

# View top 10 rows
iris_raw %>% 
  head(10)
# View bottom 10 rows
iris_raw %>% 
  tail (10)

# Sample a random 10
iris_raw %>% 
  sample_n(10) # tidyverse package required

# Sample a percentage
iris_raw %>% 
  sample_frac(0.10)



## -----------------------------------------------------------------------------------------------------
# 2 conditions species = sertosa and sepal length must be greater than 5.5
iris_raw %>% 
  filter(Species=="setosa", Sepal.Length > 5.5)

#Not using pipeline
filter(iris_raw, Species =="setosa", Sepal.Length > 5.5)
  


## -----------------------------------------------------------------------------------------------------
iris_raw %>% 
  filter(Species =="setosa", 
         Sepal.Length < mean(Sepal.Length)) %>% 
  filter(Sepal.Width<3)


## -----------------------------------------------------------------------------------------------------
iris_raw %>% 
  filter((Species=="setosa" | Sepal.Length >= 5.5),
         Sepal.Width < 3)


## -----------------------------------------------------------------------------------------------------
TRUE & FALSE
TRUE & TRUE

# RULE: YELLOW & (BLUE OR RED)
# YELLOW & PURPLE
TRUE & ( FALSE )
# YELLOW & RED
TRUE & TRUE




## -----------------------------------------------------------------------------------------------------
# Filter a column if this condition is true, i.e. numeric. ~ unknown column, . is a place holder
iris_raw %>% 
  filter_if(is.numeric, ~ . < 5)
# Using any values
iris_raw %>% 
  filter_if(is.numeric, any_vars( . <1))


## -----------------------------------------------------------------------------------------------------
# Write a filter that gets all action movies from the movies dataset via the ggplot2movies package
library(ggplot2movies)
ggplot2movies::movies %>% 
  filter(Action == 1)



## -----------------------------------------------------------------------------------------------------
# Write a filter that removes films lasting more than 6 hours from the movies dataset
# Example: iris %>% filter_all(any_vars(. > 7.5))
# Condition the column first, "filter_if(is numeric, ..). iris %>% filter_if(is.numeric, all_vars(. < mean(.)))
ggplot2movies::movies %>% 
  filter_if(is.numeric, all_vars(length <= 360))


## -----------------------------------------------------------------------------------------------------
# Write a filter that checks to see if any of the films don’t have any genres flagged at all
# Example: iris %>% filter_at(vars(ends_with("Length")), all_vars(. < mean(.)))
ggplot2movies::movies %>% filter_at(vars(Action, Animation, Comedy, Drama, Documentary, Romance, Short), all_vars(. == 0))

