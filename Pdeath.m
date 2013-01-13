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