function [] = Visualisation(params,State,ATP,Glucose,Oxygen,Hydrogen)
%% Creates a subplot to visualise the state of the different variables.
% Display the State with colors.
% Display the other continuous variables using heatmaps

subplot(3,2,[1 2]);

%Instead of simply plotting State we display only some important properties
%of the cells:
%Normal ; Hyperplastic ; Hyperlastic-Glycolytic ; And
%Hyperlastic-Glycolytic-Acid Resistant
%Normal : 1
%Hyperplastic : 5 ; 7
%Hyperplastic-Gly : 6
%Hyperplastic-Gly-AR : 8
%Anything else : some color

epty = (State == 0);
normal = logical((State == 1));
hypl = logical((State == 5) + (State == 7));
hyplgly = logical((State == 6));
hyplglyar = logical((State == 8));

toDisplay = 5*ones(params.height, params.width);
toDisplay(epty) = 0;
toDisplay(normal) = 1;
toDisplay(hypl) = 2;
toDisplay(hyplgly) = 3;
toDisplay(hyplglyar) = 4;

imagesc(toDisplay,[0 5]);
title('State Matrix')
subplot(3,2,3);
imagesc(ATP);
title('ATP Matrix');
subplot(3,2,4);
imagesc(Glucose);
title('Glucose Matrix');
subplot(3,2,5);
imagesc(Oxygen);
title('Oxygen Matrix');
subplot(3,2,6);
imagesc(Hydrogen);
title('Hydrogen Matrix');