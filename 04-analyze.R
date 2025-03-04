library(readr)
library(ggplot2)
library(docopt)
"
This script loads, cleans, saves titanic data

Usage: 04-analyze.R --model=<model> --output_path=<output_path> -- output_fig=<output_fig>
" -> doc 
opt <- docopt(doc)

# model <- readr::read_rds("output/model.RDS")
model <- readr::read_rds(opt$model)

summary(model)

# results

coef <- broom::tidy(model)
coef

# process results

coef <- coef |>
  dplyr::mutate(or = exp(estimate))

coef

write_csv(coef, opt_output_coef)

# plot results


ggplot(coef |> dplyr::filter(term != "(Intercept)"), aes(x = term, y = or)) +
  geom_point() +
  coord_flip() +
  geom_hline(yintercept = 1)

ggsave(opt$output_fig)
