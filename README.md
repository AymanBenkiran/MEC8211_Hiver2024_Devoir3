# MEC8211_Hiver2024_Devoir3

This is the repository for the 3rd MEC8211 homework of the Winter 2024 term.

## Authors 

Amishga Alphonius, Ayman Benkiran, and Maxence Farin.

# Project Description

This code validates a 2D LBM implementation used to model a filtering domains in HVAC systems.

Ultimately, the goal of the current code is to estimate the model error $`\delta_{\mathrm{model}}`$ with a confidence interval of $`95.4%`$.

The LBM code evaluates the permeability ($`k`$) of the filtering domain by supposing a Gaussian distribution of filtering fiber diameters. The code also greatly simplifies the problem by assuming that all fiber are oriented in the same direction.

Similarly, the porosity ($`\epsilon \in [0.90, 0.99]`$) is also assumed to follow a Gaussian distribution with $`\mu_{\epsilon}=0.900`$ and $`\sigma_{\epsilon}=7.50E-3`$. The mean ($`\mu_{\epsilon}`$) and standard deviation ($`\sigma_{\epsilon}`$) values are obtained from statistical treatment of experimental measurements. However, this distribution was not implemented to the code and therefore, has been added to it for error bound evaluations.

Following Darcy's law, the filtering domain's permeability is estimated as:

$`k = \frac{\mu U_\mathrm{i} \epsilon h}{\Delta P}`$

where 

- $`\mu`$ is the dynamic viscosity of the air flowing through the filter, 
- $`U_\mathrm{i}`$ is the interstitial velocity of the air, 
- $`h=\Delta x N_x`$ is the thickness of the filtering domain with $`\Delta x`$ is the spatial discretization and $`N_x`$ the number of elements along an axis,
- $`\Delta P`$ is the pressure drop through the filtering domain.

# Code requirements and Running the code

This project uses a MATLAB code to solve the problem described above using the lattice Boltzmann method (LBM).

- The spatial convergence analysis is run using a bash script (`src/LBM_code/spatial_order_convergence_study.sh`). It uses a Python script (`src/postprocessing/spatial_order_convergence_postprocessing.py`) to postprocess the results.

- Other 

To run all scripts of the code, the following Python modules are required:
    
  - `math`
  - `matplotlib`
  - `numpy`
  - `pandas`

# Code Architecture

- All source and postprocessing files are located in the `src` folder.

  -  In `LBM_code` all MATLAB scripts related to the LBM code is located:
  
- Produced raw results are stored in `CSV` format in the `data` folder.
- Postprocessed results (figures and data) are stored in the `results` folder.
- A change log is available in the `doc` folder.