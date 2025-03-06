netflix <- read.csv("netflix daily top 10.csv")
#View(netflix)

# Check for missing values and get a summary of the dataset
summary(netflix)

# View the current column names
colnames(netflix)

# Rename columns for clarity
colnames(netflix) <- c("Date", "Rank", "Year_to_Date_Rank", "Last_Week_Rank", "Title", "Type", 
                       "Netflix_Exclusive", "Release_Date", "Days_in_Top_10", "Viewership_Score")

colnames(netflix)

# Create a histogram to visualize the distribution of ranks
#library(ggplot2)

# Plot the distribution of ranks
ggplot(netflix, aes(x = Rank)) +
  geom_histogram(binwidth = 1, fill = "steelblue", color = "black") +
  labs(title = "Distribution of Netflix Ranks", x = "Rank", y = "Count") +
  theme_minimal()

# Plot the distribution of Viewership Scores
ggplot(netflix, aes(x = Viewership_Score)) +
  geom_histogram(binwidth = 50, fill = "coral", color = "black") +
  labs(title = "Distribution of Viewership Scores", x = "Viewership Score", y = "Count") +
  theme_minimal()

# Plot the distribution of Days in Top 10
ggplot(netflix, aes(x = Days_in_Top_10)) +
  geom_histogram(binwidth = 10, fill = "darkgreen", color = "black") +
  labs(title = "Distribution of Days in Netflix Top 10", x = "Days in Top 10", y = "Count") +
  theme_minimal()

# Bar plot to show the number of Movies vs TV Shows in the Top 10
ggplot(netflix, aes(x = Type)) +
  geom_bar(fill = "purple", color = "black") +
  labs(title = "Movies vs TV Shows in Netflix Top 10", x = "Content Type", y = "Count") +
  theme_minimal()

# Check data types
str(netflix)

# Check for duplicates
sum(duplicated(netflix))

# Convert Date column to Date type
netflix$Date <- as.Date(netflix$Date, format="%Y-%m-%d")

# Convert Release_Date column to Date type
netflix$Release_Date <- as.Date(netflix$Release_Date, format="%b %d, %Y")

# Convert Year_to_Date_Rank to numeric
netflix$Year_to_Date_Rank <- as.numeric(netflix$Year_to_Date_Rank)

# Convert Last_Week_Rank to numeric, replacing "-" with NA
netflix$Last_Week_Rank <- as.numeric(gsub("-", NA, netflix$Last_Week_Rank))

# Check the structure of the dataset
str(netflix)

# Scatter plot for Viewership Score vs. Days in Top 10
ggplot(netflix, aes(x = Days_in_Top_10, y = Viewership_Score)) +
  geom_point(alpha = 0.5, color = 'blue') +
  geom_smooth(method = 'lm', color = 'red') +
  labs(title = "Viewership Score vs. Days in Top 10", 
       x = "Days in Top 10", 
       y = "Viewership Score") +
  theme_minimal()

# Scatter plot for Rank vs. Viewership Score
ggplot(netflix, aes(x = Rank, y = Viewership_Score)) +
  geom_point(alpha = 0.5, color = 'green') +
  geom_smooth(method = 'lm', color = 'red') +
  labs(title = "Rank vs. Viewership Score", 
       x = "Rank", 
       y = "Viewership Score") +
  theme_minimal()

# Viewership Score over Time
ggplot(netflix, aes(x = Date, y = Viewership_Score, color = Type)) +
  geom_line() +
  labs(title = "Viewership Score Over Time", 
       x = "Date", 
       y = "Viewership Score") +
  theme_minimal()

# Comparing TV Shows to Movies
# Boxplot for Viewership Score by Type (TV Show vs Movie)
ggplot(netflix, aes(x = Type, y = Viewership_Score, fill = Type)) +
  geom_boxplot() +
  labs(title = "Viewership Score: TV Shows vs Movies",
       x = "Content Type",
       y = "Viewership Score")

# Boxplot for Rank by Type (TV Show vs Movie)
ggplot(netflix, aes(x = Type, y = Rank, fill = Type)) +
  geom_boxplot() +
  labs(title = "Rank: TV Shows vs Movies",
       x = "Content Type",
       y = "Rank")

# Release Date Impact
# Scatter plot of Viewership Score vs Release Date
ggplot(netflix, aes(x = Release_Date, y = Viewership_Score, color = Type)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "loess", se = FALSE, color = "red") +
  labs(title = "Viewership Score vs Release Date",
       x = "Release Date",
       y = "Viewership Score")

# Line plot of Days in Top 10 vs Release Date
ggplot(netflix, aes(x = Release_Date, y = Days_in_Top_10, color = Type)) +
  geom_line(stat = "summary", fun = "mean") +
  labs(title = "Days in Top 10 vs Release Date",
       x = "Release Date",
       y = "Average Days in Top 10")

# Extract the month from Release_Date
netflix$Release_Month <- format(netflix$Release_Date, "%B")

# Create a season based on Release_Date
netflix$Season <- cut(as.numeric(format(netflix$Release_Date, "%m")),
                      breaks = c(0, 3, 6, 9, 12),
                      labels = c("Winter", "Spring", "Summer", "Fall"))

# Calculate rank change from last week
netflix$Rank_Change <- netflix$Last_Week_Rank - netflix$Rank

# Convert Netflix_Exclusive to binary (1 for Yes, 0 for others)
netflix$Netflix_Exclusive_Binary <- ifelse(netflix$Netflix_Exclusive == "Yes", 1, 0)

# Summarize by content type (TV shows vs. Movies)
summary_by_type <- netflix %>%
  group_by(Type) %>%
  summarize(
    avg_viewership = mean(Viewership_Score, na.rm = TRUE),
    avg_rank = mean(Rank, na.rm = TRUE),
    avg_rank_change = mean(Rank_Change, na.rm = TRUE)
  )
summary_by_type

# Summarize by release month
summary_by_month <- netflix %>%
  group_by(Release_Month) %>%
  summarize(
    avg_viewership = mean(Viewership_Score, na.rm = TRUE),
    avg_rank = mean(Rank, na.rm = TRUE),
    avg_days_in_top_10 = mean(Days_in_Top_10, na.rm = TRUE)
  )
summary_by_month

# Summarize by Netflix exclusivity
summary_by_exclusive <- netflix %>%
  group_by(Netflix_Exclusive_Binary) %>%
  summarize(
    avg_viewership = mean(Viewership_Score, na.rm = TRUE),
    avg_rank = mean(Rank, na.rm = TRUE),
    avg_days_in_top_10 = mean(Days_in_Top_10, na.rm = TRUE)
  )
summary_by_exclusive

# Summarize by season of release
summary_by_season <- netflix %>%
  group_by(Season) %>%
  summarize(
    avg_viewership = mean(Viewership_Score, na.rm = TRUE),
    avg_rank = mean(Rank, na.rm = TRUE),
    avg_days_in_top_10 = mean(Days_in_Top_10, na.rm = TRUE)
  )
summary_by_season

# Bar plot for average viewership score by content type
ggplot(summary_by_type, aes(x = Type, y = avg_viewership, fill = Type)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Viewership Score by Content Type", x = "Content Type", y = "Average Viewership Score") +
  theme_minimal()

# Bar plot for average rank change by content type
ggplot(summary_by_type, aes(x = Type, y = avg_rank_change, fill = Type)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Rank Change by Content Type", x = "Content Type", y = "Average Rank Change") +
  theme_minimal()

# Bar plot for average viewership score by release month
ggplot(summary_by_month, aes(x = Release_Month, y = avg_viewership, fill = Release_Month)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Viewership Score by Release Month", x = "Month", y = "Average Viewership Score") +
  theme_minimal()

# Line plot for average rank by release month
ggplot(summary_by_month, aes(x = Release_Month, y = avg_rank, group = 1)) +
  geom_line(color = "blue") +
  labs(title = "Average Rank by Release Month", x = "Month", y = "Average Rank") +
  theme_minimal()

# Bar plot for average viewership score by Netflix exclusivity
ggplot(summary_by_exclusive, aes(x = as.factor(Netflix_Exclusive_Binary), y = avg_viewership, fill = as.factor(Netflix_Exclusive_Binary))) +
  geom_bar(stat = "identity") +
  labs(title = "Average Viewership Score: Netflix Exclusive vs Non-Exclusive", x = "Netflix Exclusive", y = "Average Viewership Score") +
  scale_x_discrete(labels = c("Non-Exclusive", "Exclusive")) +
  theme_minimal()

# Bar plot for average days in top 10 by Netflix exclusivity
ggplot(summary_by_exclusive, aes(x = as.factor(Netflix_Exclusive_Binary), y = avg_days_in_top_10, fill = as.factor(Netflix_Exclusive_Binary))) +
  geom_bar(stat = "identity") +
  labs(title = "Average Days in Top 10: Netflix Exclusive vs Non-Exclusive", x = "Netflix Exclusive", y = "Average Days in Top 10") +
  scale_x_discrete(labels = c("Non-Exclusive", "Exclusive")) +
  theme_minimal()

# Bar plot for average viewership score by season
ggplot(summary_by_season, aes(x = Season, y = avg_viewership, fill = Season)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Viewership Score by Season", x = "Season", y = "Average Viewership Score") +
  theme_minimal()

# Bar plot for average days in top 10 by season
ggplot(summary_by_season, aes(x = Season, y = avg_days_in_top_10, fill = Season)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Days in Top 10 by Season", x = "Season", y = "Average Days in Top 10") +
  theme_minimal()





