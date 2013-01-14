DTC-OSTI-CANCER-A
=================

MATLAB implementation of "Metabolic changes during carcinogenesis: Potential impact on invasiveness."


To run the simulation, from MATLAB:
cd Code/
RunSimulation

To change the number of iterations, edit RunSimulaiton and change NIter.


setParams.m
  Initialises a structure with the following parameters:
  Glycolytic rate,
  Tumour cell acidity threshold,
  Normal cell acidity thereshold,
  Adaptation rate,
  Width of the grid,
  Height of the grid,
  Number of ATP molecules produced during complete oxydation,
  Minimum ATP for a cell to survive,
  Diffusion coefficient for glucose,
  Diffusion coefficient for oxygen,

InitialiseProblem.m
Initialise the problem using the params structure.

diffusion.m
Updates the concentration of diffusive species (oxygen & glucose) by solving a system of linear equations Matrix * x = b.

ATPUpdate.m
Updates the ATP matrix with both aerobic and anaerobic processes based on glucose and oxygen concentrations.

Pdeath.m
Creates a matrix holding the probabilities of cell death from low pH.

DivideStatus.m
Calculates the probability of survival as a function of ATP and subsequently creates a matrix with ones and zeros (1=divide).

StateUpdate.m
Updates the State matrix.
Cells can die from low ATP or pH as wells as detachment from basement membrane (if they are not hyperblastic).
Depending on probabilites in Pdivide, cells divide into available space  with highest O2 concentration.
Upon division both, mother and daughter cell, may undergo one of 4 mutations (normal, hyperblastic, glycolytic, acid-resistant).
State matrix is updated accordingly.

Visualisation.m
Creates a subplot to visualise the state of the different cells in different colours and displays the other continuous variables using heatmaps.


