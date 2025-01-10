% Load the matrix A from the provided data file
load('MTH719Quiz6Data.mat')

%% Code 
% Determine the size of matrix A
[m, n] = size(A);
% Calculate the rank of matrix A
r = rank(A);

% Calculate the normal form of A, which helps in finding the bases of the four fundamental subspaces
[P, Q] = normalForm(A);

% Calculate the reduced row echelon form of A and the pivot columns
[Ea, c] = rref(A);

% ColA: Basis for the column space of A
% This is obtained by selecting the columns of A corresponding to the pivot columns in the RREF of A
ColA = A(:,c);

% RowA: Basis for the row space of A
% This is obtained by transposing the first r rows of the RREF of A,
% where r is the rank of A. These rows are linearly independent and span the row space.
RowA = Ea(1:r,:)';

% RnullA: Basis for the null space of A
% This is obtained by taking the columns of matrix Q corresponding to the free variables, i.e., from the (rank+1)th column to the nth column
RnullA = Q(:,r+1:n);

% LnullA: Basis for the left null space of A
% This is obtained by taking the rows of matrix P corresponding to the free variables, i.e., from the (rank+1)th row to the mth row
LnullA = P(r+1:m,:)';

% Save the variables ColA, RowA, RnullA, and LnullA to a file named Quiz6.mat
% These variables represent bases for the column space, row space, null space, and left null space of matrix A, respectively
save('Quiz6','ColA','RowA','RnullA','LnullA')
