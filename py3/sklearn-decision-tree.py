#!/usr/bin/env python3
# Experimente mit sklearn CART trees, um Anzahl benutzter Features auszulesen
from sklearn.tree import DecisionTreeClassifier
from sklearn import datasets
import pandas as pd

df = pd.read_csv("Liver RNA Data.csv")
clf = DecisionTreeClassifier(random_state=42).fit(df.iloc[0:200, 0:-1],
						  df.iloc[0:200, -1])

tree_depth = clf.tree_.max_depth

def get_used_features(tree):
    # recursive traversal of the tree
    features = []
    # features.append feature at root node of current subtree
    # if there are more subtrees:
    # features.append get_used_features( left subtree )
    # features.append get_used_features( right subtree )
    return features
