function Q = makeInvertible(col_space)
    % Number of rows in col_space
    rows = size(col_space, 1);
    
    % Create a vector x that is not in the column space of col_space
    % Start with a vector of ones
    x = ones(rows, 1);
    
    % If x is in the column space of col_space, create a new random x
    while rank([col_space, x]) == rank(col_space)
        x = rand(rows, 1);
    end
    
    % Concatenate x and col_space to form Q
    Q = [col_space, x];
    
    % Check if Q is invertible
    if rank(Q) == size(Q, 1)
        disp("Successfully created an invertible matrix Q.")
    else
        disp("Failed to create an invertible matrix Q.")
    end
end
