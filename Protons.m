function [updated] = Protons(params,State, Glucose, Oxygen)

% updates the concentration of protons.
% the state of the cell influences uptake

N = params.width;
M = params.height;

% We approach this by solving a system of linear equations Matrix * x = b

%% setting up the Matrix 

% We start by setting up the matrix as if we were in an infinite field
% We will need to replace some of the entries later to account for
% boundaries

% this is sort of a tridiagonal matrix, just with 5 diagonals
va = -4*ones(1,N*M);
M1a = diag(va);
vb = ones(1,N*M-1);
M1b = diag(vb,1) + diag(vb,-1);
vc = ones(1,N*(M-1));
M1c = diag(vc,N) + diag(vc,-N);
Matrix = M1a + M1b + M1c;

% zero flux boundary condition at the top
Matrix(1:N,:)=0;
for i=1:N
    Matrix(i,i) = 1;
    Matrix(i, i+N ) = -1;
end

% constant concentration at the bottom
Matrix(N*(M-1)+1:N*M,:)=0;
for i=1:N
    Matrix(N*(M-1)+i,N*(M-1)+i)=1;    
end


% periodic boundary conditions
%all cells in the right hand boundary
for j=2:M-1
    Matrix(j*N,j*N+1)=0;
    %rather than the one one later we want N-1 earlier
    Matrix(j*N,(j-1)*N+1)=1;
end

%all cells in the left hand boundary
for j=1:M-2
    Matrix(j*N+1,j*N)=0;
    %rather than the one one earlier we want N-1 later
    Matrix(j*N+1,(j+1)*N-1)=1;
end


%% solving the system

states = reshape(State', 1, []);
% glucose uptake by cells (phi_g)
phi_g = reshape(Glucose',1,[]);    % normal cells
phi_g(states==2|states==4|states==6|states==8) = ...
    params.k*phi_g(states==2|states==4|states==6|states==8); % glycolytic cells
phi_g(states==0) = 0;   % vacant cells

% oxygen uptake c
c = reshape(Oxygen',1,[]);
c(states==0) = 0;

b2 = (c - phi_g)';
b2(1:N) = 0;
b2(end - N:end) = 0;
RHS = b2;
SMatrix = sparse(Matrix);
x = SMatrix\RHS;

%% getting the updated Matrix out
temp = reshape(x,N,M);
updated = temp';
