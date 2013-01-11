function State = StateUpdate(params, State, ATP, Oxygen, Hydrogen, Glucose)
    
    % death from low ATP
    State(ATP < params.a0) = 0;
    
    % death from low pH
    u = rand(params.height, params.width);
    State( Pdeath(params,State,Hydrogen) > u ) = 0;
    
    % death from non-hyperplasticity
    subsetState = State(1:params.height-1,:);
    subsetState( subsetState == 1 + subsetState == 2 + subsetState == 3 + subsetState == 4 ) = 0;
    State(1:params.height-1,:) = subsetState;
    
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
            tmp02 = zeros(params.height,params.width);
            isPositionAvailable = zeros(params.height,params.width);
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
                return;
            end;
            [maxO2,maxO2Position] = max(tmp02(availables));  % index for the max oxygen of available neighbours. chooses the fisrt if there are multiple
            a = positionCell{maxO2Position};
            
            if (State(x,y) == 1)
                 State(x,y) = Mutate(params, State(x,y));
                 return;
            end;
            
            State(a(1),a(2)) = Mutate(params, State(x,y));   % update 1st daughter cell     
            State(x,y) = Mutate(params, State(x,y));          % update 2nd daughter cell
     
    end

    
    
    
    
    
end