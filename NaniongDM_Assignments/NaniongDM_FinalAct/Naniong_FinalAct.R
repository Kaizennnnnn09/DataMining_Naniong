# Load libraries
library(arules)
library(arulesViz)

# Load dataset
data("Groceries")

# Explore
itemFrequencyPlot(Groceries, topN = 15, type = "relative",
                  main = "Top 15 Most Frequent Items")

# Mine rules
rules <- apriori(Groceries,
                 parameter = list(
                   supp = 0.01,
                   conf = 0.3,
                   minlen = 2
                 ))

# Summary
summary(rules)

# Inspect rules
inspect(head(rules, 10))

# Sort rules
inspect(head(sort(rules, by = "lift"), 10))

# Filter rules
milk_rules <- subset(rules, rhs %in% "whole milk")
inspect(head(sort(milk_rules, by = "confidence"), 10))

# Visualizations
top50 <- head(sort(rules, by = "lift"), 50)
plot(rules, method = "scatterplot", shading = "lift")
plot(top50, method = "graph", control = list(type = "items"))
plot(rules, method = "grouped")
