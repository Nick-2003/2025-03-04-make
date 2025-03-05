library(readr)
library(ggplot2)
library(docopt)
"
This script loads, cleans, saves titanic data

Usage: 02-eda.R -- file_path=<file_path> --output_path=<output_path>
" -> doc 
opt <- docopt(doc)

# don't do this
# source("01-load_clean.R")

data <- readr::read_csv("data/clean/titanic_clean.csv") # Change file location

# eda

ggplot(data, aes(x = pclass, fill = as.factor(survived))) +
  geom_bar() +
  ggtitle("titanic")

ggsave("output/titanic1.png")

ggplot(data, aes(x = survived)) +
  geom_bar()
