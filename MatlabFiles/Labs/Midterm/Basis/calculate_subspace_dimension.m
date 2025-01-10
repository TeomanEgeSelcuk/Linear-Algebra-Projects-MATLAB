function [dimension, rankVal] = calculate_subspace_dimension(m, v, inner_product_rule, verbose)
    % m - number of variables in the R^n space
    % v - vector defining the subspace condition
    % inner_product_rule - expected inner product value to determine subspace condition
    % verbose - whether to print detailed information or run silently (default is true)

    if nargin < 4
        verbose = true; % Default to verbose output
    end
    
    % Check if the given vector 'v' is a single row or column
    [rows, cols] = size(v); % Determine the shape of 'v'
    % if min(rows, cols) > 1
    %     error('The vector v must be a single row or column.'); % Ensure 'v' is a vector, not a matrix
    % end
    
    % Calculate the transpose of the vector v
    v_transpose = v'; % Transpose of 'v'

    % Find the rank of the matrix v^T
    rankVal = rank(v_transpose); % Since v^T is a 1x4 matrix, the rank is 1
    
    % Calculate the dimension of the subspace based on the rank-nullity theorem
    dimension = m - rankVal; % Using the rank-nullity theorem
    
    % Verbose output to explain the steps and justify the dimension
    if verbose
        fprintf('============Calculating the Dimension of Subspace==============\n');
        fprintf('Number of variables in R^n: %d\n', m);
        fprintf('Number of elements in the vector v: %d\n', max(rows, cols)); % Display vector's length
        fprintf('Value of the inner product: %d\n', inner_product_rule);
        
        fprintf('Let v = [');
        fprintf('%d ', v);
        fprintf('];\n');

        fprintf('Let S be the subset of all vectors X in R^%d such that <v, X> = %d.\n', m, inner_product_rule);

        % Justification of dimension based on the rank-nullity theorem
        fprintf('\n(b) **What is the dimension of S? Justify your answer.**\n');
        
        fprintf('The equation <v, X> = v^T X represents a single linear equation in R^%d.\n', m);
        fprintf('Given that v is [');
        fprintf('%d ', v);
        fprintf('], the transpose v^T is a %dx%d matrix.\n', rows, cols);
        
        fprintf('The rank of the matrix v^T (number of linearly independent rows) is %d.\n', rankVal);
        fprintf('Using the rank-nullity theorem, dimension = number of variables - rank = %d - %d = %d.\n', m, rankVal, dimension);
        
        fprintf('Therefore, the dimension of S is:\n');
        fprintf('dim(S) = %d\n', dimension);
    end
end
