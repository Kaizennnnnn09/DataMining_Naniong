#setwd("C:/Users/Earl Ryan/Documents/wordcloud_exam")
#install.packages(c("tm", "SnowballC", "wordcloud", "RColorBrewer"))
# wordcloud_exam.R
# Packages

library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

# ---------------- Part 1: Data Preparation ----------------

text <- readLines("feedback.txt", encoding = "UTF-8", warn=FALSE)
text <- c(text, "uniqueword1 uniqueword2 rareword rareword2")

corpus <- Corpus(VectorSource(text))

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, content_transformer(function(x) gsub("[^a-z ]", " ", x)))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument)


# ---------------- Part 2: Word Frequency Analysis ----------------
tdm <- TermDocumentMatrix(corpus)
m <- as.matrix(tdm)
word_freqs <- sort(rowSums(m), decreasing = TRUE)
df <- data.frame(word = names(word_freqs), freq = word_freqs)

print("Top 10 most frequent words")
head(df, 10)
#The results show that the word “process” appears the most, with 98 occurrences, meaning many respondents repeatedly mention or emphasize the process in their feedback. 
#The words “need” (90) and “personnel” (74) also appear frequently, suggesting that requirements and staff involvement are common points of discussion. 
#Words like “assist” (69) and “facil” (61) indicate that assistance and facilities are also major themes raised multiple times. 
#Meanwhile, terms such as “idl,” “paper,” and “transact” appearing around 50 times each show recurring concerns about ID-related matters, paperwork, and transactions. 
#Overall, the high frequencies reflect which aspects of the service people mention the most, highlighting common experiences and issues.

# ---------------- Part 3: Main Word Cloud ----------------
png("wordcloud_exam.png", width = 800, height = 600)
set.seed(112605)
wordcloud(
  words = df$word,
  freq = df$freq,
  min.freq = 2,
  max.words = 1000,
  random.order = FALSE,
  rot.per = 0.35,
  colors = brewer.pal(8, "Dark2")
)
dev.off()

# ---------------- Part 4: Rare Words Cloud ----------------
raredf<- subset(df, freq==1)

print("Top 5 Least frequent words")
head(raredf, 5)

png("wordcloud_rare.png", width = 800, height = 600)
set.seed(1234)
wordcloud(
  words = raredf$word,
  freq = raredf$freq,
  min.freq = 1,
  max.words = 1000,
  random.order = FALSE,
  rot.per = 0.35,
  colors = brewer.pal(8, "Dark2")
)
dev.off()

