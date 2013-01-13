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
   
function [] = Visualisation(params,State,ATP,Glucose,Oxygen,Hydrogen)
%% Creates a subplot to visualise the state of the different variables.
% Display the State with colors.
% Display the other continuous variables using heatmaps

subplot(3,2,[1 2]);
imagesc(State,[0 9]);
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