# 01_eda_softdrinks.R
# Exploratory Data Analysis – Soft Drinks Merger Simulation

# ──────────────────────────────────────────────────────────────
# 📦 Load Required Packages
# ──────────────────────────────────────────────────────────────
library(here)        # for consistent project paths
library(tidyverse)   # for data manipulation and plotting
library(janitor)     # for cleaning variable names
library(scales)      # for pretty labels in plots
library(lubridate)   # optional if working with time/date variables

# ──────────────────────────────────────────────────────────────
# 📁 Set Paths and Load Data
# ──────────────────────────────────────────────────────────────
data_path <- here("Data", "Raw", "soft_drinks_market_52weeks.csv")

softdrinks <- read_csv(data_path) %>%
  clean_names()  # converts column names to snake_case

# ──────────────────────────────────────────────────────────────
# 🧹 Initial Checks
# ──────────────────────────────────────────────────────────────
glimpse(softdrinks)
summary(softdrinks)
any(is.na(softdrinks))  # check for missing values

# ──────────────────────────────────────────────────────────────
# 📊 Summary Statistics by Product
# ──────────────────────────────────────────────────────────────
softdrinks %>%
  group_by(product_name) %>%
  summarise(
    avg_price = mean(price),
    sd_price = sd(price),
    avg_quantity = mean(quantity),
    avg_market_share = mean(market_share),
    avg_brand_strength = mean(brand_strength)
  )

# ──────────────────────────────────────────────────────────────
# 📈 Time Series Plots
# ──────────────────────────────────────────────────────────────
# Market share over time
ggplot(softdrinks, aes(x = week, y = market_share)) +
  geom_line(color = "steelblue", size = 1) +
  facet_wrap(~product_name, ncol = 2) +
  labs(title = "Market Share Trends by Product", y = "Market Share", x = "Week") +
  scale_y_continuous(labels = percent_format()) +
  theme_minimal()



# Price over time
ggplot(softdrinks, aes(x = week, y = price)) +
         geom_line(color = "darkgreen", size = 1) + 
         facet_wrap(~product_name, ncol = 2) + 
         labs(title = "Price Trends Over Time", y = "Price (€)", x = "Week") +
         theme_minimal()

# Quantity sold over time
ggplot(softdrinks, aes(x = week, y = quantity)) +
  geom_line(color = "orange", size = 1) + 
  facet_wrap(~product_name, ncol = 2) + 
  labs(title = "Weekly Quantity Sold", y = "Units Sold", x = "Week") +
  theme_minimal()

# ──────────────────────────────────────────────────────────────
# 📁 Save Output (Optional)
# ──────────────────────────────────────────────────────────────
# ggsave(here("Output", "market_share_over_time.png"), width = 8, height = 5)

# ──────────────────────────────────────────────────────────────
# 📊 Brand Strength by Product
# ──────────────────────────────────────────────────────────────
softdrinks %>%
  group_by(product_name) %>%
  summarise(avg_brand_strength = mean(brand_strength)) %>%
  ggplot(aes(x = reorder(product_name, -avg_brand_strength), y = avg_brand_strength, fill = product_name)) +
  geom_col(width = 0.6) +
  labs(
    title = "Brand Strength Index by Product",
    x = "",
    y = "Brand Strength Index"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# ──────────────────────────────────────────────────────────────
# 📈 Correlation Matrix (Numerical Variables)
# ──────────────────────────────────────────────────────────────
# Option 1 – Simple correlation matrix
cor_matrix <- softdrinks %>%
  select(price, quantity, sugar, caffeine, brand_strength) %>%
  cor()

print(round(cor_matrix, 2))  # Optional: export to a table later

# Option 2 – Visual correlation plot (if you prefer visuals)
library(GGally)

softdrinks %>%
  select(price, quantity, sugar, caffeine, brand_strength) %>%
  ggpairs(title = "Correlation Matrix: Price, Quantity & Product Features")

# ──────────────────────────────────────────────────────────────
# 🧠 Analytical Guidance
# ──────────────────────────────────────────────────────────────
# - Look for negative correlation between price and quantity (price elasticity)
# - Check whether brand_strength correlates positively with quantity
# - Sugar and caffeine may reveal segment preferences (e.g. health-conscious consumers)
