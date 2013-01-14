% Copyright 2013 A-team
%    Licensed under the Apache License, Version 2.0 (the "License");
%    you may not use this file except in compliance with the License.
%    You may obtain a copy of the License at
% 
%        http://www.apache.org/licenses/LICENSE-2.0
% 
%    Unless required by applicable law or agreed to in writing, software
%    distributed under the License is distributed on an "AS IS" BASIS,
%    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%    See the License for the specific language governing permissions and
%    limitations under the License.
   
function textHandle = Visualisation(params,iterations,textHandle,State,ATP,Glucose,Oxygen,Hydrogen)
%% Creates a subplot to visualise the state of the different variables.
% Display the State with colors.
% Display the other continuous variables using heatmaps
subplot(3,2,1);

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
title('State Matrix');

pos1 = 0.0125+0.05;
inc = 0.125 ;
%Draw the legend and #iterations
subplot(3,2,2,'Color','none');
axis off;
rectangle('Position',[0,0,1,1]);

text(0.1,pos1 + 0.05,'Other') 
h = rectangle('Position',[0.02,pos1,0.05,0.1]);
set(h,'facecolor', [0.5 0 0]);
text(0.1,pos1 + 0.05 + inc,'Hyperplastic - Glycolytic - Acid Resistant')
h = rectangle('Position',[0.02,pos1+inc,0.05,0.1]);
set(h,'facecolor', [1  0.27 0]);
text(0.1,pos1 + 0.05 + inc*2,'Hyperplastic - Glycolytic')
h = rectangle('Position',[0.02,pos1+2*inc,0.05,0.1]);
set(h,'facecolor', [1 1 0]);
text(0.1,pos1 + 0.05 + inc*3,'Hyperplastic')
h = rectangle('Position',[0.02,pos1+3*inc,0.05,0.1]);
set(h,'facecolor', [0 1 1]);
text(0.1,pos1 + 0.05 + inc*4,'Normal')
h = rectangle('Position',[0.02,pos1+4*inc,0.05,0.1]);
set(h,'facecolor', [0 0 1]);
text(0.1,pos1 + 0.05 + inc*5,'Empty')
h = rectangle('Position',[0.02,pos1+5*inc,0.05,0.1]);
set(h,'facecolor', [0 0 0.5]);
s = sprintf('Iteration # %d',iterations);

textHandle = text(0.1,pos1 + 0.05 + inc*6,s);
subplot(3,2,3);
imagesc(ATP, [0 2]);
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