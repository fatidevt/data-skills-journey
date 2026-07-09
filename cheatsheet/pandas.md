# 🐼 Pandas Cheat Sheet

A quick-reference guide for common Pandas operations: filtering, updating, cleaning, aggregating, and working with dates.

## Table of Contents

- [Filtering Rows](#filtering-rows)
- [Selecting & String Filtering](#selecting--string-filtering)
- [Updating Data](#updating-data)
- [Adding Columns](#adding-columns)
- [Renaming & Dropping](#renaming--dropping)
- [Adding Rows](#adding-rows)
- [Sorting & Ranking](#sorting--ranking)
- [Grouping & Aggregation](#grouping--aggregation)
- [Missing Values](#missing-values)
- [Data Types](#data-types)
- [Dates & Time Series](#dates--time-series)

---

## Filtering Rows

```python
# Basic filter
df[df['age'] > 30]

# Multiple conditions (AND / OR)
df[(df['age'] > 30) & (df['city'] == 'Rabat')]
df[(df['age'] > 30) | (df['city'] == 'Rabat')]

# NOT condition
df[~(df['city'] == 'Casablanca')]
# or
df[df['city'] != 'Casablanca']

# isin — match list of values
df[df['city'].isin(['Rabat', 'Fes'])]
```

## Selecting & String Filtering

```python
# Filter rows + select columns
df.loc[df['salary'] > 6000, ['name', 'salary']]

# String filtering
df[df['name'].str.contains('a', case=False)]

# Strip + normalize messy text before filtering
df['city'].str.strip().str.lower().str.title()
```

## Updating Data

```python
# Update whole column
df['salary'] = df['salary'] * 1.15

# Update specific rows
df.loc[2, 'city'] = 'Casablanca'

# Update multiple columns, one row
df.loc[2, ['salary', 'seniority']] = [df.loc[2, 'salary'] * 1.20, 'senior']

# Update multiple rows, one column at a time
df.loc[df['city'] == 'Casablanca', 'salary'] = 7500
df.loc[df['city'] == 'Casablanca', 'status'] = 'active'
```

## Adding Columns

```python
# Add new column
df['salary_mad'] = df['salary'] * 10

# Conditional new column
df['seniority'] = df['experience'].apply(
    lambda x: 'senior' if x >= 5 else 'junior')

# np.where — faster alternative
df['seniority'] = np.where(df['experience'] >= 5, 'senior', 'junior')
```

## Renaming & Dropping

```python
# Rename columns
df = df.rename(columns={'years_experience': 'experience'})

# Drop a column
df = df.drop(columns=['age'])

# Drop multiple columns
df = df.drop(columns=['age', 'city'])

# Drop a row by index
df = df.drop(index=3)

# Drop rows by condition
df = df[df['experience'] >= 2].reset_index(drop=True)
```

## Adding Rows

```python
# Add a new row
new_row = pd.DataFrame([{'name': 'Youssef', 'age': 30}])
df = pd.concat([df, new_row], ignore_index=True)

# Add multiple rows at once
new_rows = pd.DataFrame([
    {'name': 'Nour', 'age': 26},
    {'name': 'Tariq', 'age': 33}
])
df = pd.concat([df, new_rows], ignore_index=True)

# Reset index cleanly
df = df.reset_index(drop=True)
```

## Sorting & Ranking

```python
# Sort ascending (default)
df = df.sort_values(by='salary')

# Sort descending
df = df.sort_values(by='salary', ascending=False)

# Sort by multiple columns
df = df.sort_values(by=['city', 'salary'], ascending=[True, False])

# Sort + reset index
df = df.sort_values(by='experience', ascending=False)
df = df.reset_index(drop=True)

# Top N rows
df.sort_values(by='salary', ascending=False).head(3)

# Add rank column after sorting
df = df.reset_index(drop=True)
df['rank'] = df.index + 1
```

## Grouping & Aggregation

```python
# Single aggregation
df.groupby('city')['salary'].mean()
df.groupby('city')['salary'].sum()
df.groupby('city')['salary'].max()
df.groupby('department')['name'].count()

# Multiple metrics on one column
df.groupby('city')['salary'].agg(['mean', 'max', 'sum'])

# Multiple columns, same metric
df.groupby('city')[['salary', 'experience']].mean()

# Named aggregation — professional standard
df.groupby('department').agg(
    total_salary=('salary', 'sum'),
    avg_experience=('experience', 'mean'),
    headcount=('name', 'count')
).reset_index()

# Group by two columns
df.groupby(['city', 'department'])['salary'].mean().reset_index()

# Filter after groupby
result = df.groupby('city')['salary'].mean().reset_index()
result = result[result['salary'] > 6000]
```

## Missing Values

```python
# Missing values audit
missing_count = df.isnull().sum()
missing_pct = (df.isnull().sum() / len(df)) * 100
audit_df = pd.DataFrame({
    'missing_count': missing_count,
    'missing_pct': missing_pct
})
audit_df = audit_df[audit_df['missing_count'] > 0]

# Drop missing
df = df.dropna()                        # all rows with any NaN
df = df.dropna(subset=['name'])         # only where 'name' is NaN

# Fill missing
df['city'] = df['city'].fillna('Unknown')
df['salary'] = df['salary'].fillna(df['salary'].median())  # median for numbers
df['age'] = df['age'].fillna(round(df['age'].mean(), 1))   # mean for age
df['visits'] = df['visits'].fillna(0)  # 0 when no visits = no activity

# Conditional fill
missing = df['department'].isna()
df['department'] = np.where(
    missing & (df['city'] == 'Rabat'), 'Nursing',
    np.where(missing, 'Admin', df['department'])
)
```

## Data Types

```python
# Cast datatype
df['salary'] = df['salary'].astype(float)

# Safe cast — won't crash on messy data
df['salary'] = pd.to_numeric(df['salary'], errors='coerce')
```

## Dates & Time Series

| Method | Purpose |
|---|---|
| `pd.to_datetime()` | Convert string column to datetime |
| `.dt.year` / `.dt.month` / `.dt.day` | Extract date parts |
| `.dt.day_name()` | Extract day name |
| `.dt.quarter` | Extract quarter number |
| `.set_index('date')` | Set date as index (required for resample) |
| `.resample()` | Group by time period (requires date index) |
| `pd.date_range()` | Generate a sequence of dates |

```python
# Convert string column to datetime
df['date'] = pd.to_datetime(df['date'], errors='coerce')

# Extract date parts
df['year'] = df['date'].dt.year
df['month'] = df['date'].dt.month

# Extract day name
df['day_name'] = df['date'].dt.day_name()  # 'Monday', 'Tuesday'...

# Extract quarter number
df['quarter'] = df['date'].dt.quarter  # 1, 2, 3, or 4

# Date range filter — filter between two dates
filt = (df['date'] >= '2024-03-01') & (df['date'] <= '2024-06-30')
df = df[filt].reset_index(drop=True)

# Set date as index (required for resample)
df = df.set_index('date')

# Group by time period
df.resample('ME').sum()   # monthly
df.resample('QE').sum()   # quarterly
df.resample('Y').sum()    # yearly

# Resample + named agg — professional summary by period
df.resample('QE').agg(
    total_revenue=('revenue', 'sum'),
    avg_units=('units_sold', 'mean')
).reset_index()

# Generate a sequence of dates
pd.date_range(start='2024-01-01', periods=12, freq='ME')
```

---

*Feel free to fork and extend this cheat sheet with your own snippets.*
