library(readr)
library(docopt)
"
This script loads, cleans, saves titanic data

Usage: 03-model.R -- file_path=<file_path> --output_path=<output_path>
" -> doc 
opt <- docopt(doc)

# data <- readr::read_csv("data/clean/titanic_clean.csv") # Change file location
data <- readr::read_csv(opt$file_path) # Change file location

model <- glm(survived ~ as.factor(pclass) + sex + age + fare,
  data = data,
  family = "binomial"
)

summary(model)

# Add to use later
# readr::write_rds(model, "output/model.RDS")
readr::write_rds(model, opt$output_path)