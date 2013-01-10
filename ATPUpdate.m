function [ATP] = ATPUpdate(params,Glucose,Oxygen)
%% Update the ATP matrix with both aerobic and anaerobic processes.
% State : A State matrix of size NxM with entries from 1 to 9
% Glucose : A Glucose matrix of size NxM. \phi_g
% Oxygen : A matrix of size NxM. \phi_c = C = c (because C_X = 1)

% \phi_a = c + n(\phi_g -c) . But here c = C/Cx and Cx = 1.
% Also, n = 2/params.na (paper P.711)
tmp = Glucose - Oxygen;
mask = tmp >= 0;
ATP = Oxygen + 2/(params.na) * (mask .* tmp);