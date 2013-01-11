%run simulation

%Set here the number of iterations
Niter = 150;

%Initialse the parameters with default values
setParams;

%Initialise the matrices
[State,ATP,Glucose,Oxygen,Hydrogen] = InitialiseProblem(params);

for i=1:Niter
    i
    %Start each iteration with a state update : cells can divide
    State = StateUpdate(params, State, ATP, Oxygen, Hydrogen, Glucose);
    
    Glucose = Diffusion(params,State,0);
    Oxygen = Diffusion(params,State,1);
    Hydrogen = Protons(params,State,Glucose,Oxygen);
    ATP = ATPUpdate(params, Glucose, Oxygen, State);
    

end;
    Visualisation(params,State,ATP,Glucose,Oxygen,Hydrogen);