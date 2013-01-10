function [ y ] = Pdivide(params, ATP)
      % create a matrix to hold the probabilities of cell division -- eqn4
        
    p( ATP > params.a0  &&  ATP < 1 ) = (ATP - params.a0) / (1 - params.a0);
    p( ATP >= 1 ) = 1;
    
    y = p;
    
end