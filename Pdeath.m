function [ y ] = Pdeath(params, Hydrogen)
        % create a matrix to hold the probabilities of cell death from
        % low pH (acidic) -- eqn3
        
    p(Hydrogen < params.hn  &&  ( State == 1 || State == 2 || State == 5 || State == 6) ) = Hydrogen / hn;
    p(Hydrogen < params.ht  &&  ( State == 3 || State == 4 || State == 7 || State == 8) ) = Hydrogen / ht;
    
    y = p;
    
end