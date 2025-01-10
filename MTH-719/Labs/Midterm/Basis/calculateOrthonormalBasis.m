function Q5 = calculateOrthonormalBasis(V, verbose)
    % Function to find orthonormal basis for a given set of constraints
    % V is a row vector representing constraints
    % verbose is a boolean flag indicating whether to print detailed output
    
    if nargin < 2
        verbose = true;  % Default to verbose if not specified
    end
    
    % Ensure V is a column vector for calculations
    V = V(:);
    
    % Generate an identity matrix of the same length as V
    I = eye(length(V));
    
    % Find a basis for the null space of V'
    LnullA = null(V', 'r');  % 'r' ensures full rank
    
    % Print intermediate results
    if verbose
        fprintf('Original vector V:\n');
        disp(V);
        fprintf('Identity matrix I:\n');
        disp(I);
        
        fprintf('Null space of V (LnullA):\n');
        disp(LnullA);
        
        % Example general mathematical formula with explanation
        r = 1;  % Example index
        m = size(LnullA, 1);
        fprintf('LnullA = P(r+1:m,:) = P(%d+1:%d,:)'';\n', r, m);
        disp(LnullA(r + 1:m, :));
    end
    
    % Orthonormalize using the QR decomposition
    [Q, R] = qr(LnullA);
    
    % Set Q5 to the orthonormal basis
    Q5 = Q;
    
    if verbose
        fprintf('Orthonormal basis (Q):\n');
        disp(Q);
        
        fprintf('Upper triangular matrix (R):\n');
        disp(R);
    end
end
