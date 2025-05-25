# Merger Simulation: Soft Drinks Market (Logit Demand Estimation)

This repository contains a simulated dataset and an econometric framework to analyse the competitive effects of a hypothetical merger in the soft drinks sector. The project replicates standard methods used in competition economics, particularly by consultancies and regulatory bodies in merger assessments.

## 📌 Case Overview

**Title**: Acquisition of *Zest Beverages Ltd.* by *Aria Drinks GmbH*  
**Industry**: Non-alcoholic ready-to-drink (RTD) soft beverages  
**Geographic Scope**: Germany (national market)  
**Timeframe**: Weekly data for 1 year (52 weeks)  
**Firms Involved**:  
- Aria Drinks GmbH (`AriaCola`)  
- Zest Beverages Ltd. (`ZestTea`)  
- Frisch & Klar AG (`F&K Lemon`, `F&K Apple`)

## 📊 Dataset

The dataset includes 208 observations (52 weeks × 4 products). Each observation contains:

- `week`: Week number
- `product_id`: Unique product code
- `firm`: Company name
- `product_name`: Brand name
- `price`: Weekly price per unit (€)
- `quantity`: Weekly units sold
- `sugar`: Sugar content (g/100ml)
- `caffeine`: Caffeine content (mg/l)
- `brand_strength`: Index (proxy for brand equity)
- `market_total`: Total market sales that week
- `market_share`: Share of total market sales

## 📈 Objective

Estimate a **multinomial logit model** to recover demand elasticities and simulate potential **unilateral price effects** resulting from the merger. This mirrors typical analyses in Phase I and Phase II merger investigations.

## 📂 File

- `soft_drinks_market_52weeks.csv` – Simulated panel data ready for analysis

## 🔧 Methods to Apply

- Logit demand estimation  
- Own- and cross-price elasticity calculation  
- Merger simulation (unilateral effects)  
- Market definition sensitivity

## 🧰 Requirements (R packages)

- `tidyverse`  
- `nnet` or `mlogit` for multinomial logit  
- `sandwich` / `lmtest` for robust standard errors (optional)


---

**Author**: Luis Carlos Castillo Téllez  
