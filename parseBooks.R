library(jsonlite)
library(readr)
library(sjmisc)

remove(j)
remove(rel_path)
remove(tags)

df <- data.frame(ID=numeric(), Title=character(), stringsAsFactors = FALSE)
chunkedText <- list()

for(i in json_data)
{
  if(i$Num %in% result)
  {
    path <- paste(i$`gd-num-padded`, "-extracted.txt") 
    path <- str_replace_all(path, fixed(" "), "")
    Rstring <- read_file(path)
    
    #Chunk up the text via punctuation marks
    split <- unlist(str_split(Rstring, "(?<=\\!)."))
    split <- unlist(str_split(Rstring, "(?<=\\?)."))
    split <- unlist(str_split(Rstring, "(?<=\\;)."))
    #[\\!\\?\\;]
    
    #split by new line breaks
    split2 <- unlist(str_split(split,"\\r\\n\\r\\n"))
    
    #replace line break spaces with space character
    split3 <- unlist(str_replace_all(split2,"\\r\\n"," "))
    
    #split by double dash characters
    split4 <- unlist(str_split(split3, "\\-\\-"))
    
    #split by excess quote characters
    split5 <- unlist(str_split(split4,'\\"'))
    
    #split by periods, with the exception of name titles
    split6 <- str_split(split5,"(?<!(Mr.|Mrs.|Dr.))(?<=\\.)[[:blank:]]")
    #(?<=(?<!(Mr.|Mrs.|Dr.)\\.))\\s
    
    #Removes all empty strings from the list
    split6[!str_detect(split6, '')] <- NULL
    
    #Removes white spaces from either side of sentences
    split7 <- str_trim(unlist(split6))
    
    #Remove empty strings again
    split8 <- split7[str_detect(split7,"")]
    
    
    
    chunkedText[length(chunkedText)+1] <- list(split8) #dont unlist it
    df <- rbind(df, data.frame(ID=i$Num, Title=i$Title))
  }
}
df$Text <- chunkedText


