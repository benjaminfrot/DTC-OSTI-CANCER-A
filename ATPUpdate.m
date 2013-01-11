function [ATP] = ATPUpdate(params, Glucose, Oxygen, State)
%% Update the ATP matrix with both aerobic and anaerobic processes.
% State : A State matrix of size NxM with entries from 1 to 9
% Glucose : A Glucose matrix of size NxM. \phi_g
% Oxygen : A matrix of size NxM. \phi_c = C = c (because C_X = 1)

% \phi_a = c + n(\phi_g -c) . But here c = C/Cx and Cx = 1.
% Also, n = 2/params.na (paper P.711)
mask1 = logical((mod(State,2) == 0) .* (State > 0));
phiGlucose = zeros(params.height, params.width);
phiGlucose = Glucose;
phiGlucose(mask1) = params.k * Glucose(mask1);

tmp = phiGlucose - Oxygen;
tmp(State == 0) = 0;

mask2 = tmp >= 0;
ATP = (Oxygen .* (State ~=0)) + 2/(params.na) * (mask2 .* tmp);