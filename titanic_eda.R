# Load necessary libraries
library(dplyr)
library(ggplot2)
library(tidyr)

# Load the Titanic training dataset
# Assuming the dataset is downloaded and saved as 'train.csv'
titanic_data <- read.csv('train.csv')

# View the first few rows of the dataset
head(titanic_data)

# Summary of the dataset
summary(titanic_data)

# Check for missing values
missing_values <- colSums(is.na(titanic_data))
print(missing_values)

# Handle missing values
# For simplicity, we'll fill NAs in 'Age' with the median age and 'Embarked' with the most frequent value
titanic_data$Age[is.na(titanic_data$Age)] <- median(titanic_data$Age, na.rm = TRUE)
titanic_data$Embarked[is.na(titanic_data$Embarked)] <- 'S'  # Most frequent value

# Convert categorical variables to factors
titanic_data$Survived <- as.factor(titanic_data$Survived)
titanic_data$Pclass <- as.factor(titanic_data$Pclass)
titanic_data$Sex <- as.factor(titanic_data$Sex)
titanic_data$Embarked <- as.factor(titanic_data$Embarked)

# Exploratory Data Analysis

## 1. Survival Rate by Gender
ggplot(titanic_data, aes(x = Sex, fill = Survived)) +
    geom_bar(position = 'fill') +
    labs(title = 'Survival Rate by Gender', y = 'Proportion', x = 'Gender') +
    scale_fill_manual(values = c('0' = 'red', '1' = 'green'))

## 2. Survival Rate by Passenger Class
ggplot(titanic_data, aes(x = Pclass, fill = Survived)) +
    geom_bar(position = 'fill') +
    labs(title = 'Survival Rate by Passenger Class', y = 'Proportion', x = 'Passenger Class') +
    scale_fill_manual(values = c('0' = 'red', '1' = 'green'))

## 3. Age Distribution of Survivors vs Non-Survivors
ggplot(titanic_data, aes(x = Age, fill = Survived)) +
    geom_histogram(binwidth = 5, position = 'dodge') +
    labs(title = 'Age Distribution of Survivors vs Non-Survivors', x = 'Age', y = 'Count') +
    scale_fill_manual(values = c('0' = 'red', '1' = 'green'))

## 4. Fare Distribution by Survival Status
ggplot(titanic_data, aes(x = Fare, fill = Survived)) +
    geom_histogram(binwidth = 10, position = 'dodge') +
    labs(title = 'Fare Distribution by Survival Status', x = 'Fare', y = 'Count') +
    scale_fill_manual(values = c('0' = 'red', '1' = 'green'))

# Save plots as images
ggsave('survival_rate_by_gender.png')
ggsave('survival_rate_by_class.png')
ggsave('age_distribution.png')
ggsave('fare_distribution.png')

# Generate a report with findings
report <- "
# Titanic Dataset EDA Report

## Overview
This report presents an exploratory data analysis of the Titanic dataset. We analyze survival rates, the effect of various features on survival, and distributions of age and fare.

## Key Findings
- **Survival Rate by Gender**: Women had a higher survival rate compared to men.
- **Survival Rate by Passenger Class**: Passengers in the first class had a higher survival rate compared to those in second and third classes.
- **Age Distribution**: Age distribution varies between survivors and non-survivors.
- **Fare Distribution**: Fare distribution shows that higher fares are associated with a higher survival rate.

## Visualizations
- ![Survival Rate by Gender](survival_rate_by_gender.png)
- ![Survival Rate by Passenger Class](survival_rate_by_class.png)
- ![Age Distribution](age_distribution.png)
- ![Fare Distribution](fare_distribution.png)
"

writeLines(report, "titanic_eda_report.md")
