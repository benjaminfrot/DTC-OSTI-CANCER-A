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