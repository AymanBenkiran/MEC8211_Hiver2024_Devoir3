% MATLAB script to launch a fiber structure generation and the corresponding LBM simulation
%
%INPUT VARIABLES:
%
% SEED: integer representing the seed for initializing the random
% generator. If seed=0, automatic seed generation. If you want to reproduce
% the same fiber structure, use the same seed (fibers will be located at the same place). 
%
% MEAN_D: contains the mean fiber to be used
%
% STD_D: contains the standard deviation of the fiber diameters
%
% PORO: estimated porosity of the fiber structure to be generated
% 
% NX: domain lateral size in grid cell

function launch_simulationLBM(results_folder, data_file)
    seed=101;
    deltaP= 0.1 ; % pressure drop in Pa
    NX= 200.0;
    poro= 0.9 ;
    mean_fiber_d= 12.5 ; % in microns
    std_d= 2.85 ; % in microns
    dx= .000001000  ; % grid size in m
    results_filename = join([results_folder,"/fiber_mat_dx",num2str(dx),"_poro", num2str(poro),".tiff"],"") ;

    % generation of the fiber structure
    [d_equivalent]=Generate_sample(seed,results_filename,mean_fiber_d,std_d,poro,NX,dx);

    % calculation of the flow field and the permeability from Darcy Law
    LBM(results_filename,NX,deltaP,dx,d_equivalent,poro,data_file)
end
