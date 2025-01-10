function [D_transformed, P] = find_DiagnoziableD_invertableP(A, verbose)
    if nargin < 2
        verbose = true; % Default to verbose
    end

    % Step 1: Compute eigenvalues and eigenvectors
    [P, D] = eig(A);

    if verbose
        fprintf('Step 1: Compute eigenvalues and eigenvectors\n');
        fprintf('General formula: [P, D] = eig(A)\n');
        fprintf('Given matrix A:\n');
        disp(A);
        
        fprintf('Eigenvector matrix (P):\n');
        disp(P);
        
        fprintf('Diagonal matrix (D) of eigenvalues:\n');
        disp(D);
    end

    % Check if the matrix of eigenvectors is invertible (determines if diagonalizable)
    if det(P) ~= 0
        invP = inv(P); % Compute the inverse of P
        D_transformed = invP * A * P; % Apply the transformation for diagonalization

        if verbose
            fprintf('Step 2: Check if the eigenvector matrix (P) is invertible\n');
            fprintf('General formula for inverse of P: inv(P)\n');
            fprintf('Determinant of P: %f\n', det(P));
            
            fprintf('General formula for diagonalization: invP * A * P\n');
            fprintf('With invP:\n');
            disp(invP);
            fprintf('This results in D_transformed:\n');
            disp(D_transformed);
        end
    else
        if verbose
            fprintf('The matrix is not diagonalizable because its eigenvectors do not form a basis for R^n.\n');
        end
        P = []; % Return empty if not diagonalizable
        D = []; % Return empty if not diagonalizable
    end
end
