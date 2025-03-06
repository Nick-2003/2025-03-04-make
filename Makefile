# titanic_clean.csv relies on 01-load_clean.R 
data/clean/titanic_clean.csv: 01-load_clean.R data/original/titanic.csv
	Rscript 01-load_clean.R -- file_path=data/original/titanic.csv --output_path=data/clean/titanic_clean.csv

output/titanic1.png: 02-eda.R data/clean/titanic_clean.csv
	Rscript 02-eda.R -- file_path=data/clean/titanic_clean.csv --output_path=output/titanic1.png

output/model.RDS: 03-model.R data/clean/titanic_clean.csv
	Rscript 03-model.R -- file_path=data/clean/titanic_clean.csv --output_path=output/model.RDS

output/coef.csv output/fig.png: 04-analyze.R output/model.RDS
	Rscript 04-analyze.R --model=output/model.RDS --output_path=output/coef.csv -- output_fig=output/fig.png

index.html: report.qmd output/coef.csv output/fig.png
	quarto render report.qmd --output index.html

# analysis:
# 	Rscript 01-load_clean.R
# 	Rscript 02-eda.R
# 	Rscript 03-model.R
# 	Rscript 04-analyze.R
analysis: 
	data/clean/titanic_clean.csv \ 
	output/titanic1.png \
	output/model.RDS \ 
	output/coef.csv output/fig.png \
	index.html

# download:
# 	Rscript 01-load_clean.R

# -r: Recursively removes all files and subdirectories inside 
# -f: Force delete
clean:
	rm -rf output/ 
	rm -rf data/clean/
	rm -rf index.html 
	rm -rf *.pdf

