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
   
%run simulation

%Set here the number of iterations
Niter = 1000;

%Initialse the parameters with default values
setParams;

%Initialise the matrices
[State,ATP,Glucose,Oxygen,Hydrogen] = InitialiseProblem(params);

for i=1:Niter
    i
    %Start each iteration with a state update : cells can divide
    State = StateUpdate(params, State, ATP, Oxygen, Hydrogen, Glucose);
    
    Glucose = Diffusion(params,State,0);
    Oxygen = Diffusion(params,State,1);
    Hydrogen = Protons(params,State,Glucose,Oxygen);
    ATP = ATPUpdate(params, Glucose, Oxygen, State);
    
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
    set(gcf,'Renderer','zbuffer') %Fix windows 7 transparency problem.
    M(i)=getframe(gcf); %leaving gcf out crops the frame 
end;
    Visualisation(params,State,ATP,Glucose,Oxygen,Hydrogen);