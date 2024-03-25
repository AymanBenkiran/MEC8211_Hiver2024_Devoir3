"""
MEC8211 - Devoir 3 : Validation
Fichier : spatial_order_convergence_postprocessing.py
Description : Fichier de postraitement pour l'etude de la propagation de l'erreur des donnees d'entree
Auteur.e.s : Amishga Alphonius (2030051), Ayman Benkiran (1984509) et Maxence Farin (2310129)
Date de creation du fichier : 24 mars 2024

Usage : python3 input_error_postprocessing.py
"""

#%% Importation des modules
import numpy as np
import pandas as pd

data_folder = '../../data/input_error_study'
results_file=f"{data_folder}/input_error_study.csv"

# Load dataframe
df_convergence_study = pd.read_csv(results_file, index_col=False)

# Extract values
permeability=df_convergence_study["k_in_micron2"].to_numpy()
n = len(permeability)

# Compute u_{input}^2
mean_k = 1/n * sum(permeability)
diff = [(k - mean_k)**2 for k in permeability]
u_input_sqr = 1/(n-1)*sum(diff)

# Screen print
print("number of samples: ", n)
print("u_{input}^2: ", u_input_sqr)
print("u_{input}: ", np.sqrt(u_input_sqr))
