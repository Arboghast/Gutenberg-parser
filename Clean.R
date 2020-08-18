library(jsonlite)
library(readr)
library(sjmisc)
library(stringr)
library(stringi)

filenames <- c("296-0.txt","57.txt","pg19033.txt","pg23661.txt")
  #dir(pattern="*.txt")

titles <- c("The Cash Boy", "Aladdin and the Magic Lamp", "Alice's Adventures in wonderland", "The Book of DRAGONS")

ids <- c("296","57","19033","23661")

newName <- c("1.txt","2.txt","3.txt","4.txt")

helper <- function(x){
  roman <- as.roman(x);
  num <- as.numeric(roman)
  return(num)
}

for(i in 1:4){
  Rstring <- read_file(filenames[i])
  
  #split by new line breaks
  split2 <- unlist(str_split(Rstring,"\\r\\r\\n\\r\\r\\n"))
  
  #convert unicode tag to quotes
  split2 <- unlist(str_replace_all(split2, "\uFFFD", '"'))
  
  #convert back to spaces
  split2 <- unlist(str_replace_all(split2,"\\r\\r\\n", " "))
  
  #convert roman to integers
  #split2 <- unlist(str_replace_all(split2, "(?<=CHAPTER\\s)[:upper:]+", helper))
  
  split2 <- unlist(str_replace_all(split2, "\\[.+\\]", ""))
  
  split2 <- unlist(str_replace_all(split2, "\\*+", ""))
  
  split2 <- unlist(str_replace_all(split2, "(?<=\\w)\\_", ""))
  
  split2 <- unlist(str_replace_all(split2, "\\_(?=\\w)", ""))
  
  writeLines(split2, newName[i])
}



