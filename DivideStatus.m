function [ y ] = DivideStatus(params, ATP)
      % create a matrix to hold division status (1=divide) -- eqn4
    
    mask = (ATP > params.a0) .* (ATP < 1);    
    p( mask ) = (ATP(mask) - params.a0) / (1 - params.a0);
    p( ATP >= 1 ) = 1;
    
    u = rand(params.height, params.width);
    p( p > u ) = 1;
    p( p < u ) = 0;
    
    y = p;
    
end