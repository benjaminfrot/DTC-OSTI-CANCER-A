function [] = Visualisation(params,State,ATP,Glucose,Oxygen,Hydrogen)
%% Creates a subplot to visualise the state of the different variables.
% Display the State with colors.
% Display the other continuous variables using heatmaps

subplot(3,2,[1 2]);
imagesc(State,[0 9]);
title('State Matrix')
subplot(3,2,3);
imagesc(ATP, [0 5]);
title('ATP Matrix');
subplot(3,2,4);
imagesc(Glucose, [0 5]);
title('Glucose Matrix');
subplot(3,2,5);
imagesc(Oxygen, [0 5]);
title('Oxygen Matrix');
subplot(3,2,6);
imagesc(Hydrogen, [0 5]);
title('Hydrogen Matrix');