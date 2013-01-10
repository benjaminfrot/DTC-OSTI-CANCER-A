function [State,ATP,Glucose,Oxygen,Hydrogen] = InitialiseProblem(params)
%% Initialise the problem using the params structure
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

% A cell can have one of 9 states : Empty or a combination of all these
%states : hyperplastic, glycolytic ; acid-resitant. In this implementation
% the state of the cell is described by a number between 0 and 9.
% 0 : Empty
% 1 : Normal
% x : decimal representation of the binary number described by
% Hyperplastic Acid-Resistant Glycolytic plus one.
%For example, if the cell is Hyperplastic and Glycolytic it is 101 --> 5 +
%1 = 6

%Initialise by setting a layer of normal cells. The rest is empty.
State = zeros(params.width,params.height);
State(params.height,:) = 1; %Start with normal cells 000 + 1

%All initial levels are set to one and any changes are just expressed
%as fractions of 1.
ATP = zeros(params.width,params.height);
ATP(params.height,:) = 1;

Glucose = zeros(params.width,params.height);
Glucose(params.height,:) = 1;

Oxygen = zeros(params.width,params.height);
Oxygen(params.height,:) = 1;

Hydrogen = zeros(params.width,params.height);
Hydrogen(params.height,:) = 0;