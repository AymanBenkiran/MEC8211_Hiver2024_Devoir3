close all; clc; clear all;

% Définir les paramètres de la distribution lognormale
mu = log(80.6); % Moyenne de la distribution logarithmique normale
sigma = log(14.7); % Écart-type de la distribution logarithmique normale

% Générer un échantillon de données suivant la distribution lognormale
echantillon = lognrnd(mu, sigma, 1000000, 1);

% Calculer la médiane de l'échantillon
median_echantillon = median(echantillon);

% Calculer l'intervalle d'incertitude autour de la médiane
manufacturier_incertitude = 10; % µm²
FVG = 0.5; % Facteur de variation géométrique
lower_bound = exp(log(median_echantillon) - FVG) - sqrt(manufacturier_incertitude); % Limite inférieure de l'intervalle
upper_bound = exp(log(median_echantillon) + FVG) + sqrt(manufacturier_incertitude); % Limite supérieure de l'intervalle
fprintf('Intervalle d''incertitude autour de la médiane : [%0.4f, %0.4f]\n', lower_bound, upper_bound);

% Tracer l'histogramme normalisé de l'échantillon
histogram(echantillon, 'Normalization', 'pdf', 'BinWidth', 10); % Normalisation par la densité de probabilité
hold on;

% Tracer la fonction de densité de probabilité (PDF) de la distribution lognormale
x = linspace(min(echantillon), max(echantillon), 100); % Créer une plage de valeurs pour x
%x = linspace(0, max(echantillon) * 2, 1000);
pdf_lognormale = lognpdf(x, mu, sigma); % Calculer la PDF de la distribution lognormale
plot(x, pdf_lognormale, 'r', 'LineWidth', 2); % Tracer la PDF

% Ajouter des étiquettes et une légende
xlabel('Valeurs');
ylabel('Densité de probabilité');
title('PDF de l''échantillon de données lognormale');
legend('Données', 'PDF Lognormale');