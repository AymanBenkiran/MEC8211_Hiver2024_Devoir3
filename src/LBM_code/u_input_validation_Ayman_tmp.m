close all; clear all; clc;

%%
% Avec LHS
% Paramètres de porosité
poro = 0.9;
std_poro = 7.5e-3;
num_samples = 50; % Nombre d'échantillons LHS à générer

% Génération d'échantillons LHS pour la porosité
rng('default'); % Réinitialiser le générateur de nombres aléatoires pour la reproductibilité
lhs_samples = lhsdesign(num_samples, 1); % Générer des échantillons LHS pour une seule variable

% Transformation des échantillons LHS en porosité
poro_genere = norminv(lhs_samples, poro, std_poro);

% Affichage des échantillons de porosité générés
disp('Porosité générée avec LHS :');
disp(poro_genere);

% Tracé des échantillons de porosité générés
figure;
histogram(poro_genere, 'Normalization', 'probability', 'BinWidth', 0.02); % Histogramme des échantillons avec une largeur de bin de 0.02
xlabel('Porosité');
ylabel('Fréquence relative');
title('Distribution des échantillons de porosité générés avec LHS');
grid on;
% Avec normal
% %%% Générer une distribution gaussienne sur la porosité
% poro= 0.9 ;
% std_poro = 7.5e-3;
% poro_genere = normrnd(poro,std_poro,[1, 20]);
% 
% % Tracé de l'histogramme
% histogram(poro_genere, 'Normalization', 'pdf');
% hold on;
% 
% % Tracé de la distribution normale théorique
% x = linspace(poro - 4 * std_poro, poro + 4 * std_poro, 1000);
% y = normpdf(x, poro, std_poro);
% plot(x, y, 'r', 'LineWidth', 2);
% 
% % Ajout de légendes et de titres
% legend('Distribution des échantillons', 'Distribution normale théorique');
% xlabel('Poro');
% ylabel('Densité de probabilité');
% title('Distribution normale générée');
% 
% % Optionnel : affichage de la grille
% grid on;

%% Test
seed=101;
deltaP= 0.1 ; % pressure drop in Pa
NX= 100 ;

%%% Add normal distribution of porosity
%poro= 0.9 ;
%std_poro = 7.5e-3;
%poro_genere = normrnd(poro,std_poro,[1, 10]);

mean_fiber_d= 12.5 ; % in microns
std_d= 2.85 ; % in microns
dx= 2e-6 ; % grid size in m

% initialiser le vecteur permeabilite
permeabilite = zeros(length(poro_genere), 1);

for i = 1 : length(poro_genere)
    %filename= 'fiber_mat_{i}.tiff' ;
    filename = sprintf('fiber_mat_%d.tiff', i);

    % generation of the fiber structure
    %[d_equivalent]=Generate_sample(seed,filename,mean_fiber_d,std_d,poro,NX,dx);
    [d_equivalent]=Generate_sample(seed,filename,mean_fiber_d,std_d,poro_genere(i),NX,dx);

    % calculation of the flow field and the permeability from Darcy Law
    permeabilite(i) = LBM(filename,NX,deltaP,dx,d_equivalent);
end

%%
%%% Appel de la fonction Evaluate_LHS_sample pour evaluer u_input
u_input= Evaluate_LHS_sample(permeabilite);

%% 
% On commence par definir une fonction qui calcule u_input a partir des
% resultats d'echantillons LHS selon la methode de validation
function [u_input]= Evaluate_LHS_sample(Sample)
%INPUT VARIABLES:
%
% Sample: donnees d'echantillons
%
% OUTPUT VARIABLE:
%
% u_input: valeur sur l'incretitude d'entree recherchee

% Initialiser u_input et evaluer la valeur moyenne de l'echantillon genere
u_input = 0;
S_mean = mean(Sample);

% Boucle for pour effectuer la sommation
for i = 1 : length(Sample)
    u_input = u_input + (Sample(i) - S_mean) ^ 2;
end

% Evaluer u_input
u_input = sqrt(u_input)/(length(Sample) - 1);
end