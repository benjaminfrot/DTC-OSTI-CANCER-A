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
   
function [ y ] = Pdivide(params, ATP)
      % create a matrix to hold the probabilities of cell division -- eqn4
        
    p( ATP > params.a0  &&  ATP < 1 ) = (ATP - params.a0) / (1 - params.a0);
    p( ATP >= 1 ) = 1;
    
    y = p;
    
end