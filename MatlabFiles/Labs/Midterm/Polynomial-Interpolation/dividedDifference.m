%% Q4a
% Q4a
function D = dividedDifference(X)
    % Determine the length of the input vector X.
    n = length(X);
    
    % Initialize a square matrix D of zeros with dimensions n by n.
    % This matrix will store the computed values.
    D = zeros(n,n);
    
    % Outer loop iterates over each row of the matrix D.
    for i = 1:n
        % Inner loop iterates over each column up to the current row number
        % to ensure the computation is only done for the lower triangle of the matrix D.
        for j = 1:i
            % If we are at the first column, simply set the value to 1.
            % This is likely a specific initial condition for the problem being solved.
            if j == 1
                D(i,j) = 1;
            else
                % For other columns, calculate the value based on the previous column in the same row
                % and the difference between the current and a previous value in X.
                % This calculation is specific to the problem being solved and
                % resembles the process of constructing a table for divided differences or a similar operation.
                D(i,j) = D(i,j-1) * (X(i) - X(j-1));
            end
        end
    end
end

