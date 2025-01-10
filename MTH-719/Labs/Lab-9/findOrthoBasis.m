% function Q = findOrthoBasis(A, verbose)
%     if nargin < 2
%         verbose = true; % Default verbose value is true
%     end
% 
%     % Get the size of the matrix A
%     [m, n] = size(A);
% 
%     if verbose
%         fprintf('Matrix A is of size %d x %d.\n', m, n);
%     end
% 
%     % Calculate the null space of A using Singular Value Decomposition
%     [U, S, V] = svd(A);
% 
%     if verbose
%         disp('Singular Value Decomposition (SVD) of A is performed:');
%         disp('A = U*S*V'', where U and V are orthogonal matrices, and S is a diagonal matrix with singular values.');
%     end
% 
%     % The rank of A determines how many singular values to consider
%     rankA = rank(S);
% 
%     if verbose
%         fprintf('Rank of A is determined to be %d.\n', rankA);
%         fprintf('Therefore, the last n-rank(A) = %d columns of V form a basis for the null space of A.\n', n-rankA);
%     end
% 
%     % The last n-rank(A) columns of V form a basis for the null space of A
%     disp('V = ');
%     disp(V);
%     nullBasis = V(:, rankA+1:end);
% 
%     if verbose
%         disp('Basis for the null space of A, extracted from the last columns of V:');
%         disp(nullBasis);
%     end
% 
%     % Use QR factorization to find an orthonormal basis for the null space
%     [Q, R] = qr(nullBasis, 0);
% 
%     if verbose
%         disp('Performed QR factorization on the basis for the null space to find an orthonormal basis (Q):');
%         disp('The orthonormal basis (Q) is:');
%         disp(Q);
%         disp('The upper triangular matrix (R) from QR factorization is (not necessarily used here, but informative):');
%         disp(R);
%     end
% 
%     if ~verbose
%         disp('Orthonormal basis for the null space has been found.');
%     end
% end

function Q = findOrthoBasis(A, verbose)
    if nargin < 2
        verbose = true; % Default verbose value is true
    end

    % Get the size of the matrix A
    [m, n] = size(A);
    
    if verbose
        fprintf('Matrix A is of size %d x %d.\n', m, n);
    end
    
    % Calculate the null space of A using Singular Value Decomposition
    [U, S, V] = svd(A);
    
    if verbose
        disp('Singular Value Decomposition (SVD) of A is performed:');
        disp('A = U*S*V'', where U and V are orthogonal matrices, and S is a diagonal matrix with singular values.');
    end

    % The rank of A determines how many singular values to consider
    rankA = rank(S);
    
    if verbose
        fprintf('Rank of A is determined to be %d.\n', rankA);
        fprintf('Therefore, the last n-rank(A) = %d columns of V form a basis for the null space of A.\n', n-rankA);
    end
    
    % The last n-rank(A) columns of V form a basis for the null space of A
    nullBasis = V(:, rankA+1:end);
    
    if verbose
        disp('Basis for the null space of A, extracted from the last columns of V:');
        disp(nullBasis);
    end
    
    % Use QR factorization to find an orthonormal basis for the null space
    [Q, R] = qr(nullBasis, 0);
    
    if verbose
        disp('Performed QR factorization on the basis for the null space to find an orthonormal basis (Q):');
        disp('The orthonormal basis (Q) is:');
        disp(Q);
        disp('The upper triangular matrix (R) from QR factorization is (not necessarily used here, but informative):');
        disp(R);
    end
    
    % Check if AQ is a zero matrix
    check = A*Q
    if check == zeros(size(check))
        disp('The first two columns of Q form a basis for the right null space of A.');
    else
        disp('The first two columns of Q do not form a basis for the right null space of A.');
    end

    % Make Q a 4x4 matrix by appending two more columns that are orthogonal to the first two columns
    Q2 = [Q, null(Q')];

    disp('The 4x4 orthogonal matrix Q is:');
    disp(Q2);
    
    if ~verbose
        disp('Orthonormal basis for the null space has been found.');
    end
end

