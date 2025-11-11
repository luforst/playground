#!/usr/bin/env python3
# Experimente mit sklearn CART trees, um Anzahl benutzter Features auszulesen
from sklearn.tree import DecisionTreeClassifier
from sklearn import datasets

data = datasets.load_breast_cancer()
clf = DecisionTreeClassifier(random_state=42).fit(data[:, 0:-1],
						  data[:, -1])

tree_depth = clf.tree_.max_depth

