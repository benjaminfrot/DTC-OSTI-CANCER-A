function y = StateUpdate(params, State, ATP, Oxygen, Hydrogen, Glucose)
    
    % create temporary State matrix
    tmpState = State;
    
    % death from low ATP
    State(ATP < params.a0) = 0;
    
    % death from low pH
    u = rand(params.height, params.width);
    State( Pdeath > u ) = 0;
    
    % death from non-hyperplasticity
    subsetState = State(1:params.height-1,:);
    subsetState( subsetState == 1 || subsetState == 2 || subsetState == 3 || subsetState == 4 ) = 0;
    State(1:params.height-1,:) = subsetState;
    
    % division or quiescence
    if( State ~= 0  &&  ATP > params.a0 )
        for i = 1:params.height
            for j = 1:params.width
                
                
                
            end
        end
        
    end
    
    
    
    
    
end