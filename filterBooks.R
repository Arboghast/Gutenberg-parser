#!/usr/bin/env Rscript
install.packages("rjson")
install.packages("stringr")
library("rjson")
library("stringr")

containsTrue <- function(j,tags){
  hit <- str_detect(j,tags)
  for(i in hit)
  {
    if(i)
    {
      return(TRUE)
    }
  }
  return(FALSE)
}

json_file <- "gutenberg-metadata.json"
json_data <- fromJSON(file=json_file)
result <- c()
rel_path <- c()

tags <- c("Children's stories", "Children's literature", "Juvenile")

for(i in json_data)
{
  for(j in i$Subject)
  {
    if(containsTrue(j,tags))
    {
      print(j)

      result <- c(result, i$`gd-num-padded`)
      rel_path <- c(rel_path, i$`gd-path`)
    }
  }
}

result <- unique(result)
rel_path <- unique(rel_path)

dir.create("Books")
for(path in rel_path)
{
  file.copy(path, "Books")
}

