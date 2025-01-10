%{
This function, we first perform a singular value decomposition (SVD) of the matrix A. 
The SVD is a factorization of a matrix into three matrices U, S, and V. We then calculate 
the rank r of the matrix A. The matrices B and C are then calculated from the U, S, and V
matrices and the rank r. Please note that this is a simplified version and may not cover
all edge cases.
%}


function [B, C] = factorize(A, verbose)
    if nargin < 2
        verbose = true; % Default to verbose output
    end
    
    % Step 1: Singular Value Decomposition
    [U, S, V] = svd(A); % SVD decomposes A into U, S, and V
    r = rank(A); % Rank of matrix A
    
    if verbose
        fprintf('Step 1: Singular Value Decomposition (SVD)\n');
        fprintf('SVD decomposes A into three matrices: U, S, and V such that A = U * S * V''.\n');
        
        fprintf('Given matrix A:\n');
        disp(mat2str(A, 4)); % Display A in a more compact way
        
        fprintf('U matrix from SVD:\n');
        disp(mat2str(U, 4));
        
        fprintf('S matrix (diagonal) from SVD:\n');
        disp(mat2str(S, 4));
        
        fprintf('V matrix from SVD:\n');
        disp(mat2str(V, 4));
        
        fprintf('Rank of matrix A (r): %d\n', r);
    end
    
    % Step 2: Calculate matrices B and C
    B = U(:, 1:r) * sqrt(S(1:r, 1:r)); % m x r matrix
    C = sqrt(S(1:r, 1:r)) * V(:, 1:r)'; % r x n matrix

    if verbose
        fprintf('Step 2: Derivation of B and C from SVD and rank\n');
        fprintf('General formula for B: U(:, 1:r) * sqrt(S(1:r, 1:r))\n');
        fprintf('With specific values:\n');
        fprintf('B = U(:, 1:%d) * sqrt(S(1:%d, 1:%d))\n', r, r, r);
        disp(mat2str(B, 4));
        
        fprintf('General formula for C: sqrt(S(1:r, 1:r)) * V(:, 1:r)''\n');
        fprintf('With specific values:\n');
        fprintf('C = sqrt(S(1:%d, 1:%d)) * V(:, 1:%d)''\n', r, r, r);
        disp(mat2str(C, 4));
    end
end
