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
   
function [ y ] = Mutate(params, parentState)
      % 
      % 
      % 

    y = parentState;
    u = rand(1);
    parentState = parentState - 1;
    binaryCoeffs = [ mod(floor(parentState/4),2) mod(floor(parentState/2),2) mod(parentState,2)];
    
    if(params.pa > u)   % if true then mutate
        bitPosition = randsample(3,1);
        binaryCoeffs(bitPosition) = mod(binaryCoeffs(bitPosition) + 1,2);
        y = binaryCoeffs(1)*4 + binaryCoeffs(2)*2 + binaryCoeffs(3) + 1;
    end
    
end