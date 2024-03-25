%% MATLAB script pour le calcul de l'erreur expérimentale, considérant
%% une distriubtion lognormale de la perméabilité et une incertitude
%% présente fournie par le manufacturier
%% Auteur.e.s : Amishga Alphonius (2030051), Ayman Benkiran (1984509) et Maxence Farin (2310129)
%% Date de creation du fichier : 24 mars 2024

close all; clc; clear all;

% Définir les paramètres de la distribution lognormale
mu    = log(80.6); % Moyenne de la distribution logarithmique normale
sigma = log(14.7); % Écart-type de la distribution logarithmique normale

% Générer un échantillon de données suivant la distribution lognormale
echantillon = lognrnd(mu, sigma, 1000000, 1);

% Calculer la médiane de l'échantillon
median_echantillon = median(echantillon);

% Calculer l'intervalle d'incertitude autour de la médiane
FVG = 14.7; % Facteur de variation géométrique
lower_bound = exp(log(median_echantillon) - log(FVG)); % Limite inférieure de l'intervalle
upper_bound = exp(log(median_echantillon) + log(FVG)); % Limite supérieure de l'intervalle
fprintf(['Intervalle d''incertitude autour de la médiane sans considérer ' ...
    'l''incertitude du manufacturier: [%0.4f, %0.4f]\n'], lower_bound, upper_bound);

% Ajout de l'incertitude du manufacturier
manufacturier_incertitude = 10; % µm²
u_Data_min = sqrt(abs(lower_bound - median_echantillon) ^ 2 + manufacturier_incertitude ^ 2);
u_Data_max = sqrt(abs(upper_bound - median_echantillon) ^ 2 + manufacturier_incertitude ^ 2);

% Tracer l'histogramme normalisé de l'échantillon
histogram(echantillon, 'Normalization', 'pdf', 'BinWidth', 10); % Normalisation par la densité de probabilité
hold on;

% Tracer la fonction de densité de probabilité (PDF) de la distribution lognormale
x = linspace(min(echantillon), max(echantillon), 100); % Créer une plage de valeurs pour x
pdf_lognormale = lognpdf(x, mu, sigma); % Calculer la PDF de la distribution lognormale
plot(x, pdf_lognormale, 'r', 'LineWidth', 2); % Tracer la PDF

% Ajouter des étiquettes et une légende
xlabel('Valeurs');
ylabel('Densité de probabilité');
title('PDF de l''échantillon de données lognormale');
legend('Données', 'PDF Lognormale');