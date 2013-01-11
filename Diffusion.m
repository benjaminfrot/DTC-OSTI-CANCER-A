function [updated] = Diffusion(params,State,species)

% updates the concentration of diffusive species.
% d^2 * grad^2(x) - phi_x = 0
% the state of the cell influences uptake
% type of diffusive species: 0 - C6H12O6; 1 - O2
N = params.width;
M = params.height;

% We approach this by solving a system of linear equations Matrix * x = b

%% setting up the Matrix 

% We start by setting up the matrix as if we were in an infinite field
% We will need to replace some of the entries later to account for
% boundaries

% this is sort of a tridiagonal matrix, just with 5 diagonals
va = -4*ones(1,N*M);
states = reshape(State, 1, []);

if species == 0; % for glucose
    % glucose uptake by cells (phi_g)
    phi_g = ones(1,N*M);    % normal cells
    phi_g(states==2|states==4|states==6|states==8) = params.k; % glycolytic cells
    phi_g(states==0) = 0;   % vacant cells
    delta = params.dg*phi_g;
end

if species == 1; % for oxygen
    % oxygen uptake c
    c = ones(1,N*M);
    c(states==0) = 0;
    delta = params.dc*c;
end

va = va + delta;
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
b1 = zeros(N*(M-1),1);
b2 = ones(N,1); % constant concentration near membrane
RHS = [b1;b2];

SMatrix = sparse(Matrix);
x = SMatrix\RHS;

%% getting the updated Matrix out
temp = reshape(x,N,M);
updated = temp';
