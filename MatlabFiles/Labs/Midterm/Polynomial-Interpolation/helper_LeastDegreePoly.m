

% function [leastDegree] = helper_LeastDegreePoly(loadedData)
function [leastDegree] = helper_LeastDegreePoly(loadedData, equation, startingPoint);
    leastDegree = -1; % Indicates failure to find a suitable degree initially
    N = [];
    

    % Find the unique X values to determine the maximum possible degree for interpolation
    uniqueX = unique(loadedData.X); % Assuming loadedData is a two-column matrix with X in the first column
    desiredDegree = length(uniqueX) - 1; % Start with the maximum degree possible

    % Loop through degrees from desiredDegree down to 1
    for degree = desiredDegree:-1:-1
        % Call PolynomialFit for the current degree
        % [solution_vector, general_solution, augmentedMatrix] = test_PolynomialFit(loadedData, degree, N, equation, startingPoint, false);
        [solution_vector, general_solution, augmentedMatrix] = PolynomialFit(loadedData, degree, N, false);
        % Convert augmentedMatrix to Reduced Row Echelon Form to check solutions
        rrefMatrix = rref(augmentedMatrix);

        % Identify non-basic columns (those that do not contain a leading one)
        basicColumns = sum(rrefMatrix(:, 1:end-1) ~= 0) == 1; % Logical array for columns with leading ones
        nonBasicColumnsExist = sum(basicColumns) < size(rrefMatrix, 2) - 1; % Exclude the last column (augmented part)

        % Check for the type of solution based on rrefMatrix
        if any(all(rrefMatrix(:, 1:end-1) == 0, 2) & rrefMatrix(:, end) ~= 0)
            leastDegree = degree + 1; % Update leastDegree to the current degree
            break; % Exit the loop as we found the required polynomial
        elseif nonBasicColumnsExist
            % Infinitely many solutions, continue to the next lower degree
            continue;
        else
            % Exactly one solution found
            continue;
        end
    end

    if leastDegree == -1
        error('Failed to find a polynomial that fits the data with exactly one solution.');
    end
end
