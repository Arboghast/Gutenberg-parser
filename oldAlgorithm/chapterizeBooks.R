
library(stringr)

for(id in result)
{
  x <- paste(dirname(getwd()), "/Books/", id, ".txt")
  x <- str_replace_all(x, fixed(" "), "")
  x <- paste(x, " --nochapters")
  path <- paste("chapterize ", x)
  shell(path)  
}

