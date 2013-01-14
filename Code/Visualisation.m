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

%Instead of simply plotting State we display only some important properties
%of the cells:
%Normal ; Hyperplastic ; Hyperlastic-Glycolytic ; And
%Hyperlastic-Glycolytic-Acid Resistant
%empty : 0			dark blue
%Normal : 1			blue
%Hyperplastic : 5 ; 7		cyan
%Hyperplastic-Gly : 6		yellow
%Hyperplastic-Gly-AR : 8	orange
%Anything else : some color	brown

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

subplot(3,2,1);
imagesc(toDisplay,[0 5]);
title('State Matrix');

%Draw the legend and #iterations
pos1 = 0.0125 + 0.05;
inc = 0.125 ;
subplot(3,2,2,'Color','none');
axis off;
rectangle('Position',[0,0,1,1]);

s = sprintf('Iteration # %d',iterations);

text(0.1,pos1 + 0.05 + inc*5,'Empty')
h = rectangle('Position',[0.02,pos1+5*inc,0.05,0.1]);
set(h,'facecolor', [0 0 0.5]);
text(0.1,pos1 + 0.05 + inc*4,'Normal')
h = rectangle('Position',[0.02,pos1+4*inc,0.05,0.1]);
set(h,'facecolor', [0 0 1]);
text(0.1,pos1 + 0.05 + inc*3,'Hyperplastic')
h = rectangle('Position',[0.02,pos1+3*inc,0.05,0.1]);
set(h,'facecolor', [0 1 1]);
text(0.1,pos1 + 0.05 + inc*2,'Hyperplastic - Glycolytic')
h = rectangle('Position',[0.02,pos1 + 2*inc,0.05,0.1]);
set(h,'facecolor', [1 1 0]);
text(0.1,pos1 + 0.05 + inc,'Hyperplastic - Glycolytic - Acid Resistant')
h = rectangle('Position',[0.02,pos1 + inc,0.05,0.1]);
set(h,'facecolor', [1  0.27 0]);
text(0.1,pos1 + 0.05,'Other') 
h = rectangle('Position',[0.02,pos1,0.05,0.1]);
set(h,'facecolor', [0.5 0 0]);


%Titles for all other subplots
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
