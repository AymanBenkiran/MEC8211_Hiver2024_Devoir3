%% Generate a porosity value according to a Gaussian distribution

function [porosity_value]=distribution_of_porosity(mean_poro,std_poro)
%INPUT VARIABLES:
%
% mean_poro : contains the mean porosity to be used
%
% std_poro: contains the standard deviation of the porosity

    rng('shuffle');
    porosity_value=normrnd(mean_poro,std_poro);
end