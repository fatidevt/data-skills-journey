## Matplotlib Cheat Sheet

### Quick Recall
Q: Difference between plt.plot() and fig, ax?
A: plt.plot() is quick/simple; fig,ax gives full control + subplots

Q: Bar chart vs Histogram?
A: Bar = categorical data; Histogram = numerical distribution

Q: How to plot directly from Pandas?
A: df.plot(x='col', y='col2', kind='bar', ax=ax)

### Chart Types
| Chart     | Code                                      |
|-----------|-------------------------------------------|
| Line      | ax.plot(x, y, marker='o', label='name')   |
| Bar       | ax.bar(x, y, color='steelblue')           |
| Scatter   | ax.scatter(x, y, color='purple')          |
| Histogram | ax.hist(data, bins=10)                    |
| Pie       | ax.pie(values, labels=labels, autopct='%1.1f%%') |

### Subplots
- fig, ax = plt.subplots()                    # single plot
- fig, axes = plt.subplots(2, 3, figsize=(18,10))  # grid
- axes[0, 0].plot(...)                        # access each cell
- fig.suptitle('Main Title')                  # overall title

### Customization
- ax.set_title('Title')
- ax.set_xlabel('X') / ax.set_ylabel('Y')
- ax.legend(loc='upper left')
- ax.grid(True, linestyle='--', alpha=0.5)
- plt.xticks(rotation=45)
- plt.tight_layout()
- plt.show()

### Golden Pattern (freelance standard)
fig, ax = plt.subplots(figsize=(10, 6))
df.plot(x='month', y='revenue', kind='bar', ax=ax)
ax.set_title('Title')
ax.set_xlabel('X')
ax.set_ylabel('Y')
plt.tight_layout()
plt.show()

### Groupby before pie chart
category_data = df.groupby('category')['revenue'].sum()
ax.pie(category_data.values, labels=category_data.index, autopct='%1.1f%%')

### Two lines on same subplot
ax.plot(x, y1, label='Revenue', marker='o')
ax.plot(x, y2, label='Expenses', marker='o')
ax.legend()
