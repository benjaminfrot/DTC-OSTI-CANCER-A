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
   
function State = StateUpdate(params, State, ATP, Oxygen, Hydrogen, Glucose)
    
    % death from low ATP
    State(ATP < params.a0) = 0;
    
    % death from low pH
    u = rand(params.height, params.width);
    State( Pdeath(params,State,Hydrogen) > u ) = 0;
    
    % death from non-hyperplasticity
    % FIXME: Does not work for some reason :( WHY?!! 
    mask = logical((State == 1) + (State == 2) + (State == 3) + (State == 4));
    State(mask(1:params.height -1,:)) = 0;
    
    % division or quiescence
    liveCells = (State ~= 0);
    mask = liveCells .* DivideStatus(params, ATP); % intersection between available cells and cells that will divide
	[rows, cols] = find(mask);
    % wrap around the y axis
    v = [ params.width 1:params.width 1 ];
    function [ y ] = yW(n)
      y = v(n + 1);
    end
    
    % update - reproduction step
    for k = 1:length(rows)
            x = rows(k);
            y = cols(k);
            tmpOq2 = zeros(3,1);
            isPositionAvailable = zeros(3,1);
            positionCell = {[], [], []};
            if ( x == params.height )
                isPositionAvailable = [ (State(x-1, y)==0),  (State(x, yW(y-1))==0),  (State(x, yW(y+1))==0) ];
                tmpO2 = [ Oxygen(x-1, y)  Oxygen(x, yW(y-1))  Oxygen(x, yW(y+1)) ];
                positionCell = { [x-1,y], [x, yW(y-1)], [x, yW(y+1)] };
            elseif ( x == 1 )
                isPositionAvailable = [ (State(x, yW(y-1))==0),  (State(x, yW(y+1))==0),  (State(x+1, y)==0) ];
                tmpO2 = [  Oxygen(x, yW(y-1))  Oxygen(x, yW(y+1))  Oxygen(x+1, y) ];
                positionCell = { [x, yW(y-1)], [x, yW(y+1)], [x+1, y] };                
            else    
                isPositionAvailable = [ (State(x-1, y)==0),  (State(x, yW(y-1))==0),  (State(x, yW(y+1))==0),  (State(x+1, y)==0) ];
                tmpO2 = [ Oxygen(x-1, y)  Oxygen(x, yW(y-1))  Oxygen(x, yW(y+1))  Oxygen(x+1, y) ];
                positionCell = { [x-1,y], [x, yW(y-1)], [x, yW(y+1)], [x+1, y] };
            end

            availables = find(isPositionAvailable);
            if (isempty(availables))
                continue;
            end;
            [maxO2,maxO2Position] = max(tmpO2(availables));  % index for the max oxygen of available neighbours. chooses the fisrt if there are multiple
            a = positionCell{maxO2Position};
            
            if (State(x,y) == 1)
                 State(x,y) = Mutate(params, State(x,y));
                 continue;
            end;
            
            % cf. comment line 24....
            m = Mutate(params,State(x,y));
            if ((a(1) < params.height) && ((m == 1) || (m == 2) || (m == 3) || (m ==4)))
                State(a(1),a(2)) = 0;
            else
                State(a(1),a(2)) = Mutate(params, State(x,y)); % update 1st daughter cell  
            end;

            m = Mutate(params, State(x,y));
            if ((x < params.height) && ((m == 1) || (m == 2) || (m == 3) || (m ==4)))
                State(x,y) = 0;
            else
                State(x,y) = Mutate(params, State(x,y));  % update 2nd daughter cell  
            end;
     
    end

    
    
    
    
    
end