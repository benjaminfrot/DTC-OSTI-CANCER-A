% Input : params, a structure with the following fields :
%    params.k : glycolytic rate (e.g. k = 10)
%    params.ht : tumour cell acidity threshold (should be 8.6 10^3)
%    params.hn : normal cell acidity thereshold (should be 9.3 10^2)
%    params.pa : Adaptation rate (10^-3)
%    params.width : Width of the grid (50)
%    params.height : Height of the grid 
%    params.na : Number of ATP molecules produced during complete oxydation
%    (Eq (1) of the paper). Typically 36
%    params.a0 : Minimum ATP for a cell to survive. Typically 0.1
%    params.dg : 1/dg^2, where dg is diffusion coefficient for glucose. (1.3*10^2)
%    params.dc : 1/dc^2, where dc is the diffusion coefficient for oxygen.

params.k = 10;
params.ht = 8600;
params.hn = 930;
params.pa = 0.001;
params.width = 50;
params.height = 35;
params.na = 36;
params.a0 = 0.1;
params.dg = 1/130^2;
params.dc = 1/25;
