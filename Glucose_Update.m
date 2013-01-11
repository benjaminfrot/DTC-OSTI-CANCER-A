% updates the glucose level based on the cell states.
N = params.width;
M = params.height;

% We approach this by solving a system of linear equations Mg=b

%% setting up M

% We start by setting up the matrix as if we were in an infinite field
% We will need to replace some of the entries later to account for
% boundaries

% this is sort of a tridiagonal matrix, just with 5 diagonals
va = -4*ones(1,N*M);
states = reshape(State, 1, []);
delta = params.dg*ones(1,N*M);    %normal cells
delta(states==2|states==4|states==6|states==8) = params.k*params.dg; % glycolytic cells
delta(states==0) = 0;
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
    %rather than the one one later we want N earlier
    Matrix(j*N,(j-1)*N+1)=1;
end

%all cells in the left hand boundary
for j=1:M-2
    Matrix(j*N+1,j*N)=0;
    %rather than the one one earlier we want N later
    Matrix(j*N+1,(j+1)*N-1)=1;
end


%% solving the system
b1 = zeros(N*(M-1),1);
b2 = ones(N,1); % constant concentration of 1 near membrane
RHS = [b1;b2];

SMatrix = sparse(Matrix);
g = SMatrix\RHS;

%% getting the glucose Matrix out again
temp = reshape(g,M,N);
Glucose = temp';
