%{
This function uses the formula (A’ * A)^-1 * A’ to calculate the left inverse of A.
Note that this formula is valid only when A’ * A is invertible, which is the case if 
and only if A has full column rank. The function rank(A) returns the rank of A, and
the equality rank(A) == n checks if A has full column rank.

Please note that the function inv(A’*A)*A’ might not be numerically stable for all 
matrices. If you encounter numerical issues, you might want to use the pinv function,
which calculates the Moore-Penrose pseudoinverse of a matrix, which is a generalization
of the concept of inverse to non-square matrices or singular square matrices.

Left Inverse: If A has full column rank, the left inverse B is given by B = (A’ * A)^-1 * A’.
This is because BA = I_n, and hence B = I_n * A^-1 = (A’ * A)^-1 * A’.
%}

% Function to calculate the left inverse of a given matrix
function B = leftInverse(A, verbose)
    if nargin < 2
        verbose = true; % Default to verbose output
    end
    
    [m, n] = size(A); % Dimensions of the input matrix
    
    if verbose
        fprintf('Matrix dimensions: %dx%d\n', m, n);
        fprintf('Step 1: Check if A has full column rank and m >= n\n');
        fprintf('General formula for checking full column rank: rank(A) == n\n');
        fprintf('With specific values: rank(A) = %d, n = %d\n', rank(A), n);
        if rank(A) == n && m >= n
            fprintf('A has full column rank and m is greater than or equal to n.\n');
        else
            fprintf('A does not have full column rank or m is less than n.\n');
        end
    end
    
    % Step 2: Calculate the left inverse if A has full column rank
    if rank(A) == n && m >= n
        B = inv(A' * A) * A'; % Left inverse calculation
        
        if verbose
            fprintf('General formula for left inverse: inv(A'' * A) * A''\n');
            fprintf('With specific values: inv(A'' * A) = inv(');
            disp(mat2str(A' * A)); % Display the calculation for A' * A
            fprintf('Resulting in: \n');
            disp(B); % Display the result
            
            % Check if B * A is close to the identity matrix
            fprintf('Check if B * A is approximately the identity matrix.\n');
            disp(B * A); % Display B * A
        end
        
        if norm(B * A - eye(n)) < 1e-7
            return; % If it works, return B
        end
    end
    
    % Step 3: Calculate the pseudoinverse if the first method fails
    % Perform Singular Value Decomposition (SVD)
    [U, S, V] = svd(A);
    
    % Create S_inv by replacing non-zero diagonal elements with their reciprocals
    S_inv = S;
    S_inv(S_inv ~= 0) = 1 ./ S_inv(S_inv ~= 0);

    B = pinv(A); % Pseudoinverse calculation
    
    if verbose
        % Print the general formula and intermediate steps
        fprintf('General formula for pseudoinverse: V * S_inv'' * U''\n');
        
        % Display intermediate results with variable-specific values
        fprintf('U Matrix:\n');
        disp(U);
        
        fprintf('S Matrix (diagonal):\n');
        disp(S);
        
        fprintf('V Matrix:\n');
        disp(V);
    
        fprintf('S_inv with reciprocals:\n');
        disp(S_inv);
    
        % Final calculation
        fprintf('Final calculation for pseudoinverse B:\n');
        fprintf('V * S_inv'' * U'' = V * (');
        fprintf(mat2str(S_inv', 4)); % S_inv' with significant digits
        fprintf(') * U''\n');
        fprintf('Resulting in:\n');
        disp(B); % Display the pseudoinverse
        
        fprintf('Check if B * A is approximately the identity matrix with pseudoinverse.\n');
        disp(B * A); % Display B * A with the pseudoinverse
    end
    
    if norm(B * A - eye(n)) < 1e-7
        return; % If pseudoinverse works, return B
    end
    
    % Step 4: Return an empty matrix if none of the methods work
    B = []; % Return empty if no valid left inverse found
    
    if verbose
        fprintf('No valid left inverse found.\n');
    end
end

