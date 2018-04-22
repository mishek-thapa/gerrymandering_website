library(tidyverse)
library(rvest)
library(robotstxt)

paths_allowed("https://www.nytimes.com/")

five <- read_html("https://fivethirtyeight.com/?s=gerrymandering")

url <- five %>%
  html_nodes(".article-title a") %>%
  html_attr("href")

title <- five %>%
  html_nodes(".article-title a") %>%
  html_text()

date <- five %>%
  html_nodes(".updated") %>%
  html_text()

date<- append(date, NA, 4)

five_table <- tibble(
  title,
  date,
  url
)

five_table <- five_table %>%
  separate(date, sep = "\\.", into = c("month", "day")) %>%
  separate(day, sep = "\\, ", into = c("day", "year"))

wapo <- read_html("https://www.google.com/search?q=gerrymandering+washington+post")
  
titles <- wapo %>% 
  html_nodes(xpath='//h3/a') %>% 
  html_text()

links <- wapo %>% 
  html_nodes(xpath='//h3/a') %>% 
  html_attr("href")

date <- wapo %>%
  html_nodes(xpath = "//SPAN/SPAN") %>%
  html_text()

gsub('/url\\?q=','',sapply(strsplit(links[as.vector(grep('url',links))],split='&'),'[',1))
