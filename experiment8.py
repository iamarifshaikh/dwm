import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
from sklearn.datasets import make_blobs

# Generate synthetic data with 3 clusters
X, y = make_blobs(n_samples=300, centers=3, cluster_std=0.60, random_state=42)

# Plot the data before clustering
plt.scatter(X[:, 0], X[:, 1], s=50, cmap="viridis")
plt.title("Data before clustering")
plt.show()

# Apply KMeans clustering
kmeans = KMeans(n_clusters=3)
kmeans.fit(X)

# Get the cluster centers and labels
centers = kmeans.cluster_centers_
labels = kmeans.labels_

# Plot the clustered data with centroids
plt.scatter(X[:, 0], X[:, 1], c=labels, s=50, cmap="viridis")

# Plot the centroids
plt.scatter(centers[:, 0], centers[:, 1], c="red", s=200, alpha=0.75, marker="x")
plt.title("Data after K-Means clustering")
plt.show()

# Predict the cluster for a new point
new_point = np.array([[3, 4]])
cluster = kmeans.predict(new_point)
print(f"The new point belongs to cluster: {cluster[0]}")