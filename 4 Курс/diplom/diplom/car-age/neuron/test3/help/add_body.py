import pandas as pd
import numpy as np

# Load the data
data = pd.read_csv('..\data\data.csv')

# List of body types for random selection
body_types = ['sedan', 'hatchback', 'wagon', 'coupe', 'crossover', 'SUV', 'minivan', 'pickup']

# Generate random body types
random_body_types = np.random.choice(body_types, size=len(data))

# Insert random body types between "Model" and "Age" columns
data.insert(loc=data.columns.get_loc('Age'), column='BodyType', value=random_body_types)

# Save the data to a new CSV file
data.to_csv('..\data\data_body.csv', index=False)

print("Data successfully augmented with random body types and saved to 'data_with_random_body_types.csv' file.")
