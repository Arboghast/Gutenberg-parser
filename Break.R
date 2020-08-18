library(jsonify)
library(RJSONIO)
library(readr)
library(sjmisc)
library(stringr)
library(stringi)
require("NLP")
require("'openNLPmodels.en")
library(openNLPmodels.en)

list.of.packages <- c("NLP", "openNLP", "SnowballC")

## Returns a not installed packages list
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

## Installs new packages
if(length(new.packages)) 
  install.packages(new.packages)

library(NLP)
library(openNLP)
library(SnowballC)



filenames <- c("A1.txt","A2.txt","A3.txt","A4.txt")

titles <- c("The Cash Boy", "Aladdin and the Magic Lamp", "Alice's Adventures in Wonderland", "The Book of DRAGONS")

ids <- c("296","57","19033","23661")

#example_text <- paste0("The Boy lives in Miami and studies in the St. Martin School. ","The boy has a heiht of 5.7 and weights 60 Kg's. ", "He has intrest in the Arts and crafts; and plays basketball. ")

#example_text <- as.String(example_text)
sent_token_annotator <- Maxent_Sent_Token_Annotator()
#annotation <- annotate(example_text, sent_token_annotator)

splited_text <- example_text[annotation]

master <- list()
df <- data.frame(ID = numeric(4), Title= character(4), Text = I(list(1:4,1:2,1:1,1:3)))

for(i in 1:4){
  Rstring <- read_file(filenames[i])
  
  #split by new line breaks
  split2 <- unlist(str_split(Rstring,"\\r\\r\\n\\r\\r\\n"))
  
  #convert unicode tag to quotes
  split2 <- str_replace_all(split2, "\uFFFD", '"')
  
  #convert back to spaces
  split2 <- str_replace_all(split2,"\\r\\r\\n", " ")
  
  split2 <- str_replace_all(split2, "\\[.+\\]", "")
  
  split2 <- str_replace_all(split2, "\\*+", "")
  
  split2 <- str_replace_all(split2, "(?<=\\w)\\_", "")
  
  split2 <- str_replace_all(split2, "\\_(?=\\w)", "")
  
  split3 <- as.list(split2)
  split4 <- list()
  for(i in 1:length(split3)){
    anote <- annotate(split3[i],sent_token_annotator)
    text <- as.String(split3[i])
    split <- text[anote]
    if(length(split) > 4){
      temp <- list()
      temp2 <- c()
      for(j in 1:length(split)){
        temp2 <- c(temp2, split[j])
        if(j %% 4 == 0)
        {
          temp[[length(temp)+1]] <- temp2
          temp2 <- c()
        }
      }
      if(length(temp2) == 0)
      {
        temp[[length(temp)+1]] <- temp2
      }
      
      for(k in 1:length(temp))
      {
        if(length(temp[[k]]) != 0)
        {
          split4[[length(split4)+1]] <- temp[[k]]
        }
      }
      
    }
    else{
      if(length(split) != 0)
      {
        split4[[length(split4)+1]] <- split
      }
    }
  }
  master[[length(master)+1]] <- split4
}

df$ID <- as.numeric(ids)
df$Title <- titles
df$Text <- I(master)

json <- to_json(df)
write(json, "test.json")

