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
   
function [ y ] = Pdeath(params,State,Hydrogen)
        % create a matrix to hold the probabilities of cell death from
        % low pH (acidic) -- eqn3
    p = zeros(params.height, params.width);
    mask = logical((Hydrogen < params.hn)  .*  (( State == 1) + (State == 2) + (State == 5) + (State == 6))); 
    p(mask) = Hydrogen(mask) / params.hn;
    mask = logical((Hydrogen >= params.hn)  .*  (( State == 1) + (State == 2) + (State == 5) + (State == 6))); 
    p(mask) = 1;
    mask = logical((Hydrogen < params.ht)  .*  (( State == 3) + (State == 4) + (State == 7) + (State == 8)));
    p( mask ) = Hydrogen(mask) / params.ht;
    mask = logical((Hydrogen >= params.ht)  .*  (( State == 3) + (State == 4) + (State == 7) + (State == 8)));
    p( mask ) = 1;
    y = p;
    
end