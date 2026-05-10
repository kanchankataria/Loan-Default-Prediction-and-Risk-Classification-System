import pandas as pd

# Load both datasets
print("Loading datasets...")

housing = pd.read_csv("data/raw/hmda_housing_loans.csv")
business = pd.read_csv("data/raw/sba_business_loans.csv")

# Housing data info
print("\n=== HOUSING LOANS ===")
print(f"Rows: {len(housing):,}")
print(f"Columns: {len(housing.columns)}")
print(f"Column names:\n{list(housing.columns)}")

# Business data info
print("\n=== BUSINESS LOANS ===")
print(f"Rows: {len(business):,}")
print(f"Columns: {len(business.columns)}")
print(f"Column names:\n{list(business.columns)}")
