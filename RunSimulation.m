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
Niter = 150;

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
    

end;
    Visualisation(params,State,ATP,Glucose,Oxygen,Hydrogen);