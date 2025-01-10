%{
This function, we first perform a singular value decomposition (SVD) of the matrix A. 
The SVD is a factorization of a matrix into three matrices U, S, and V. We then calculate 
the rank r of the matrix A. The matrices B and C are then calculated from the U, S, and V
matrices and the rank r. Please note that this is a simplified version and may not cover
all edge cases.
%}

function [B, C] = factorize(A)
    [U, S, V] = svd(A); % Singular Value Decomposition
    r = rank(A); % Rank of matrix A
    B = U(:, 1:r) * sqrt(S(1:r, 1:r)); % m x r matrix
    C = sqrt(S(1:r, 1:r)) * V(:, 1:r)'; % r x n matrix
end
