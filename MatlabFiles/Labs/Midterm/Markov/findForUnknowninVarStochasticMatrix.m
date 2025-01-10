function [max_value, x_at_max] = findForUnknowninVarStochasticMatrix(initial_vector, expected_vector, A_sym, x_range, verbose)
    % This function finds the maximum value in the second component of a symbolic
    % matrix raised to a high power, given an initial vector and an expected result vector.
    
    % Define the symbolic variable
    syms x
    
    % Raise the symbolic matrix to a high power (e.g., 1000th power)
    A_1000 = A_sym^100;
    
    % Create the symbolic equation
    eqn = A_1000 * initial_vector - expected_vector;
    
    % Convert the symbolic expression to a MATLAB function
    f = matlabFunction(eqn);
    
    % Define a range of values for 'x'
    x_values = linspace(x_range(1), x_range(2), 100); % Adjust as needed
    
    % Evaluate the function for the defined range
    y_values = f(x_values);
    
    % Extract the second component (e.g., the second row)
    y2_values = y_values(2, :);
    
    % Find the maximum value in y2 and its index
    [max_y2, max_y2_idx] = max(y2_values);
    
    % Determine the corresponding 'x' value at the maximum
    x_at_max_y2 = x_values(max_y2_idx);
    
    % Display the maximum value and the corresponding 'x' value
    if verbose
        fprintf('The maximum value in y2 is %f, which occurs at x = %f.\n', max_y2, x_at_max_y2);
    end

    % Return the maximum value and the corresponding 'x' value
    max_value = max_y2;
    x_at_max = x_at_max_y2;
end
