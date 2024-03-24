"""
MEC8211 - Devoir 3 : Validation
Fichier : spatial_order_convergence_postprocessing.py
Description : Fichier de poatraitement pour l'etude de convergence en espace
Auteur.e.s : Amishga Alphonius (2030051), Ayman Benkiran (1984509) et Maxence Farin (2310129)
Date de creation du fichier : 24 mars 2024
"""
#%% Importation des modules
import numpy as np
import pandas as pd
import os

file="../../data/spatial_order_convergence_study/spatial_order_convergence_study.csv"
df_convergence_study = pd.read_csv(file)