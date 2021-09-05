## set working directory
# the path can be changed accordingly as user wish
# the path need to contain the exercise file 'Data_Scientist_Exercise_File.xlsx'
setwd("~/Desktop/Data_scientist_R/instruction_materials")

## load library and read in the Excel file
library("openxlsx")
# read the excel file, use the first row as header and do not skip empty rows
exercise_file <- read.xlsx(xlsxFile = "Data_Scientist_Exercise_File.xlsx", sheet = 1, skipEmptyRows = FALSE)

## normalise the contents in the DISEASE column
exercise_file$DISEASE <- replace(exercise_file$DISEASE, exercise_file$DISEASE == 'TRYPs', 'Trypanosomosis')
exercise_file$DISEASE <- replace(exercise_file$DISEASE, exercise_file$DISEASE == 'PPR', 'Peste des petits ruminants')

## filter the dataframe, only entry with publication year later than 2010 (inclusive)
exercise_file <- exercise_file[exercise_file$YEAR_PUBLICATION >= 2010,]

## remove some columns 
exercise_file <- subset(exercise_file, select = -c(START_DATE_DATA, END_DATE_DATA))

## reorder the dataframe 
exercise_file <- exercise_file[ , c(1, 2, 5, 6, 7, 3, 4)]  
# or
new_order <- c('IDENTIFIER', 'YEAR_PUBLICATION', 'NUMBER_POSITIVE', 'NUMBER_TESTED', 'PERCENTAGE', 'STATE', 'DISEASE')
exercise_file <- exercise_file[ , new_order]  

## load library and split the IDENTIFIER column 
library("tidyr")
# use comma that precedening with space and a number (regex: ',\\s[0-9]') as separator 
# make a new column AUTHOR to hold the new separated information
# keep the IDENTIFIER column
exercise_file <- separate(exercise_file, IDENTIFIER, into = c('AUTHOR'), sep = ',\\s[0-9]', remove = FALSE, extra = "drop")

## To check the result table
print(exercise_file)

## load library and write the dataframe into an excel file
library("writexl")
# column names are kept, centered and bold by default in the output excel file  
write_xlsx(exercise_file, "~/Desktop/Data_scientist_R/Data_Scientist_Exercise_Output_File.xlsx")

# to print the IDENTIFIER column value with the highest value in the PERCENTAGE column
exercise_file$IDENTIFIER[exercise_file$PERCENTAGE == max(exercise_file$PERCENTAGE)]

# to print the sum of the values in the column NUMBER_TESTED
sum(exercise_file$NUMBER_TESTED)

#exercise_file$PERCENTAGE <- round(exercise_file$PERCENTAGE, digit=0)
#exercise_file <- subset(exercise_file, select = -YEAR_PUBLICATION)

