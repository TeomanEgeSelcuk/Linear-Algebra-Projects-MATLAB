%{
 function checks if the rank of A is equal to the number of its rows, 
which indicates that A has full row rank and hence a right inverse exists.
 It then calculates the right inverse using the formula (A' * A)^-1 * A'.
 If A doesn’t have a right inverse, the function returns an empty matrix.

Right Inverse: If A has full row rank, the right inverse B is given by B = A’ * (A * A’)^-1. 
This is because AB = I_m, and hence B = A^-1 * I_m = A’ * (A * A’)^-1.
%}

% Function to calculate the right inverse
function B = rightInverse(A, verbose)
    if nargin < 2
        verbose = true; % Default to verbose output
    end
    
    [m, n] = size(A); % Get the dimensions of the matrix
    
    if verbose
        fprintf('Checking if the matrix has full row rank.\n');
        fprintf('Matrix dimensions: %dx%d (m x n)\n', m, n);
        fprintf('Rank of the matrix: %d\n', rank(A));
    end
    
    % Check if the matrix has full row rank
    if m <= n && rank(A) == m
        B = A' * inv(A * A'); % Calculate the right inverse
        
        if verbose
            fprintf('General formula for right inverse: A'' * inv(A * A'')\n');
            fprintf('Specific formula: A'' * inv(');
            disp(mat2str(A * A')); % Display A * A'
            fprintf(') resulting in:\n');
            disp(B); % Display the calculated right inverse
        end
    else
        B = []; % Return an empty array if no right inverse exists
        
        if verbose
            disp('Not a square matrix or not full rank!!');
        end
    end
end


