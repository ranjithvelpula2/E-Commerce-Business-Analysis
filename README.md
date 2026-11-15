# E-Commerce Business Performance Analysis

Beginner-friendly Business Analyst portfolio case study using the uploaded Sample Superstore dataset.

## Dataset profile
- Rows after exact-duplicate removal: 9,994
- Original columns: 21
- Distinct orders: 5,009
- Distinct customers: 793
- Order date range: 2014-01-03 to 2017-12-30

## Tools
Excel, MySQL 8.0+, Python (Pandas, NumPy), Matplotlib and Seaborn.

## Project structure
```
├── Dataset/
│   ├── Raw_Data/          Sample_Superstore.csv
│   └── Processed_Data/    Cleaned_Superstore.csv + summary CSVs
├── Python/                Ecommerce_Business_Analysis.ipynb
├── SQL/                   Database creation, data quality checks, 30 business queries
├── Excel/                 Data_Validation_and_Cleaning.xlsx
├── Documents/             Business requirements and insights report
├── Visuals/               Charts exported from the notebook
└── requirements.txt
```

## Important notes
- Each row is an order line. Count orders with distinct Order_ID, not row count.
- Negative profit is valid; do not delete it.
- Shipping_Days means order-to-ship duration, not delivery duration.
- Data is historical and not current market performance.
- Correlation does not prove causation.
