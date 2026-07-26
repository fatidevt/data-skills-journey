# Pandas + Matplotlib — Complete Reference

---

## Two Ways to Plot

### Way 1 — Matplotlib directly (full control)
```python
import matplotlib.pyplot as plt

fig, ax = plt.subplots()
ax.plot(df['month'], df['revenue'])
ax.set_title('Monthly Revenue')
plt.show()
```

### Way 2 — Pandas `.plot()` shortcut (quick & clean)
```python
# Line chart
df.plot(x='month', y='revenue', kind='line')

# Bar chart
df.plot(x='month', y='orders', kind='bar')

# Multiple columns at once
df.plot(x='month', y=['revenue', 'expenses'], kind='line')

# Histogram
df['revenue'].plot(kind='hist', bins=10)

# Pie chart
df.set_index('month')['revenue'].plot(kind='pie')

# Area chart
df.plot(x='month', y='revenue', kind='area')
```

---

## Adding Titles + Labels with Pandas `.plot()`
```python
ax = df.plot(x='month', y='revenue', kind='bar')
ax.set_title('Monthly Revenue')
ax.set_xlabel('Month')
ax.set_ylabel('Revenue (MAD)')
plt.show()
```
> `.plot()` returns an `ax` object — customize it like regular Matplotlib

---

## Subplots with Pandas
```python
df.plot(subplots=True, layout=(2, 2), figsize=(10, 8))
plt.show()
```

---

## 🔑 Golden Pattern for Freelance Work
```python
fig, ax = plt.subplots(figsize=(10, 6))
df.plot(x='month', y='revenue', kind='bar', ax=ax)  # ax= connects them
ax.set_title('Monthly Revenue')
ax.set_xlabel('Month')
ax.set_ylabel('Revenue (MAD)')
plt.tight_layout()
plt.show()
```
> Pandas handles the data, Matplotlib handles the styling

---

## When to Use Each

| Situation | Use |
|---|---|
| Quick exploration of a DataFrame | `df.plot()` |
| Full control, custom layout | `fig, ax = plt.subplots()` |
| Mixing multiple DataFrames | `fig, ax` |
| Client-ready polished chart | `fig, ax` |

---

## Chart Types Quick Reference

| Chart | Use Case | `kind=` |
|---|---|---|
| Line | Trends over time | `'line'` |
| Bar | Compare categories | `'bar'` |
| Horizontal bar | Long category names | `'barh'` |
| Histogram | Distribution of numbers | `'hist'` |
| Pie | Part-to-whole breakdown | `'pie'` |
| Scatter | Relationship between 2 numbers | `'scatter'` |
| Area | Cumulative trends | `'area'` |

---

## Matplotlib Standalone — Key Functions

### Basic Plot
```python
fig, ax = plt.subplots(figsize=(10, 6))
ax.plot(x, y, color='blue', linewidth=2, linestyle='--', marker='o')
ax.set_title('Title')
ax.set_xlabel('X Label')
ax.set_ylabel('Y Label')
ax.legend()
plt.show()
```

### Customization Options
```python
# Line styles
linestyle = 'solid'    # ─────
linestyle = 'dashed'   # ─ ─ ─
linestyle = 'dotted'   # ·······
linestyle = 'dashdot'  # ─·─·─
linestyle = 'None'     # no line (markers only)

# Marker options
marker = 'o'   # circle
marker = 's'   # square
marker = '^'   # triangle
marker = 'D'   # diamond

# Marker customization
markersize = 8
markerfacecolor = 'red'
markeredgecolor = 'black'
```

### Labels + Grid
```python
ax.set_title('Title', fontsize=16)
ax.set_xlabel('X', fontsize=12)
ax.set_ylabel('Y', fontsize=12)
ax.legend(['Series 1', 'Series 2'])
ax.grid(True, linestyle='--', alpha=0.5)
```

### Bar Chart
```python
fig, ax = plt.subplots()
ax.bar(categories, values, color='steelblue', edgecolor='black')
ax.set_title('Bar Chart')
plt.xticks(rotation=45)  # rotate labels if long
plt.tight_layout()
plt.show()
```

### Pie Chart
```python
fig, ax = plt.subplots()
ax.pie(values, labels=labels, autopct='%1.1f%%', startangle=90)
ax.set_title('Pie Chart')
plt.show()
```

### Scatter Plot
```python
fig, ax = plt.subplots()
ax.scatter(x, y, color='red', alpha=0.5, s=50)  # s = marker size
ax.set_title('Scatter Plot')
plt.show()
```

### Histogram
```python
fig, ax = plt.subplots()
ax.hist(data, bins=20, color='steelblue', edgecolor='black')
ax.set_title('Distribution')
plt.show()
```

### Subplots Grid
```python
fig, axes = plt.subplots(2, 2, figsize=(12, 8))

axes[0, 0].plot(x, y1)
axes[0, 0].set_title('Plot 1')

axes[0, 1].bar(categories, values)
axes[0, 1].set_title('Plot 2')

axes[1, 0].scatter(x, y2)
axes[1, 0].set_title('Plot 3')

axes[1, 1].hist(data, bins=10)
axes[1, 1].set_title('Plot 4')

plt.tight_layout()
plt.show()
```

---

## 🔑 Golden Rules

```python
# 1. Always use tight_layout to avoid overlapping
plt.tight_layout()

# 2. Always end with plt.show()
plt.show()

# 3. Set figsize for client-ready charts
fig, ax = plt.subplots(figsize=(10, 6))

# 4. Use ax= to connect pandas .plot() with fig/ax
df.plot(x='col', y='col2', kind='bar', ax=ax)

# 5. Rotate x-axis labels when they overlap
plt.xticks(rotation=45)

# 6. Add grid for readability
ax.grid(True, linestyle='--', alpha=0.5)

# 7. Always add title + axis labels for client deliverables
ax.set_title('Title')
ax.set_xlabel('X')
ax.set_ylabel('Y')
```
