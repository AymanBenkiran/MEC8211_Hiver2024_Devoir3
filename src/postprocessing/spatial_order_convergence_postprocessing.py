"""
MEC8211 - Devoir 3 : Validation
Fichier : spatial_order_convergence_postprocessing.py
Description : Fichier de poatraitement pour l'etude de convergence en espace
Auteur.e.s : Amishga Alphonius (2030051), Ayman Benkiran (1984509) et Maxence Farin (2310129)
Date de creation du fichier : 24 mars 2024

Usage : python3 spatial_order_convergence_postprocessing.py
"""

#%% Importation des modules
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

results_folder = '../../results/spatial_order_convergence_study'
data_folder = '../../data/spatial_order_convergence_study'
results_file=f"{data_folder}/spatial_order_convergence_study.csv"

# Load dataframe
df_convergence_study = pd.read_csv(results_file, index_col=False)

# Extract values
dx_values=df_convergence_study["dx"].to_numpy()
permeability=df_convergence_study["k_in_micron2"].to_numpy()

# Set finest level as analytical solution
dx_truth = dx_values[-1]
permeability_truth=permeability[-1]

# Evaluate GCI
p_formel = 2
r12 = dx_values[-2]/dx_values[-1]
r23 = dx_values[-3]/dx_values[-2]
p_hat = (np.log((r12**p_formel-1)*
               (permeability[-3]-permeability[-2])/
               (permeability[-2]-permeability[-1])
               + r12**p_formel)
         /np.log(r12*r23))
p_rel = abs((p_hat-p_formel)/p_formel)

if p_rel <= 0.1:
    GCI = 1.25/(r12**p_formel-1)*abs(permeability[-1]-permeability[-2])
else:
    p = min(max(p_hat, 0.5), p_formel)
    GCI = 3/(r12**p-1)*abs(permeability[-1]-permeability[-2])
    print("p: ", p)

print("p_hat: ", p_hat)
print("r12: ", r12)
print("GCI: ", GCI)
print("u_{num}: ", GCI/2)

# ADD CONVERGENCE PLOT (RECOVER 2nd ORDER)
error = [abs(k-permeability_truth) for k in permeability[:-1]]

plt.figure()
n = len(error)

print("error: ", error)
print("k: ", permeability)