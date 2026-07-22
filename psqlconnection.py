import pandas as pd
from sqlalchemy import create_engine
from urllib.parse import quote_plus

# Read cleaned CSV
df = pd.read_csv("telco_cleaned.csv")

# PostgreSQL password
password = quote_plus("Allahlove1231#$#")   # Replace with your actual password

# Connect to PostgreSQL
engine = create_engine(
    f"postgresql://postgres:Allahlove1231#$#@localhost:1231/customer_churn"
)

print("Connected Successfully!")

# Upload data into PostgreSQL
df.to_sql(
    "customer_churn",
    engine,
    if_exists="replace",
    index=False
)

print("Data Uploaded Successfully!")