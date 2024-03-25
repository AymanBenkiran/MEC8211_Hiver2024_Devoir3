"""
MEC8211 - Devoir 3 : Validation
Fichier : Devoir3_u_Data.py
Description : Fichier de calcul de l'erreur expérimentale, considérant
une distriubtion lognormale de la perméabilité et une incertitude
présente fournie par le manufacturier
Auteur.e.s : Amishga Alphonius (2030051), Ayman Benkiran (1984509) et Maxence Farin (2310129)
Date de creation du fichier : 24 mars 2024

"""

# Importation des modules
import math

# Données
mu = math.log(80.6)  # Moyenne de la distribution log-normale
sigma = math.log(14.7)  # Écart-type de la distribution log-normale
manufacturier_incertitude = 10  # Incertitude du manufacturier (écart-type)

# Calcul de la médiane et du FVG
median = math.exp(mu)
FVG = math.exp(sigma)

# Calcul de l'intervalle d'incertitude autour de la médiane
lower_bound = median / FVG
upper_bound = median * FVG

# Affichage des résultats
print("Médiane :", median)
print("Facteur de Variation Géométrique (FVG) :", FVG)
print("Intervalle d'incertitude autour de la médiane : [{:.4f}, {:.4f}]".format(lower_bound, upper_bound))

# Ajout de l'incertitude du anufacturier

      