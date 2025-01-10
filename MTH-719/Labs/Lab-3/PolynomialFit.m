function PolynomialFit(loadedData, desiredDegree, N , findLeastDegreePoly)
    
    % Ensure all vectors in loadedData are row vectors
    fnames = fieldnames(loadedData);
    for i = 1:length(fnames)
        if iscolumn(loadedData.(fnames{i}))
            loadedData.(fnames{i}) = loadedData.(fnames{i}).';
        end
    end
    
    % Proceed with the original logic using loadedData directly
    % Example: Assuming loadedData contains X and Y for polynomial fitting
    
    % Ensure X and Y fields exist
    if ~isfield(loadedData, 'X') || ~isfield(loadedData, 'Y')
        error('loadedData must contain both ''X'' and ''Y'' fields.');
    end
    
    X = loadedData.X;
    Y = loadedData.Y;

    %% Polynomial fitting process
    % Number of data points
    n = length(X);
    
    % Create the Vandermonde-like matrix
    V = zeros(n, desiredDegree + 1);
    for i = 1:n
        for j = 1:desiredDegree + 1
            V(i, j) = X(i)^(j-1);
        end
    end
    
    % Form the augmented matrix [V|Y]
    augmentedMatrix = [V, Y'];
    
    % Display the original augmented matrix
    disp('The original augmented matrix [V|Y] is:');
    disp(augmentedMatrix);
    
    % Find the RREF of the augmented matrix
    rrefMatrix = rref(augmentedMatrix);
    
    % Display the RREF matrix
    disp('The row-reduced echelon form (RREF) of the augmented matrix is:');
    disp(rrefMatrix);
    
    % Determine if the system is underdetermined
    if desiredDegree >= n
        disp('The system is underdetermined.');
    else
        disp('The system is not underdetermined.');
    end
    
    % Identify non-basic columns (those that do not contain a leading one)
    basicColumns = sum(rrefMatrix(:,1:end-1) ~= 0) == 1; % Logical array for columns with leading ones
    nonBasicColumnsExist = sum(basicColumns) < size(V, 2);
    
    % Check for solutions
    if any(all(rrefMatrix(:, 1:end-1) == 0, 2) & rrefMatrix(:, end) ~= 0)
        disp('No solutions.');
    % Infinitely many solutions
    elseif nonBasicColumnsExist
        disp('Infinitely many solutions.');
        % Display general solution in terms of t
        disp('General solution is of the form:');
        
        null_space = null(augmentedMatrix(:, 1:end-1), 'r');
        
        % Initialize solution vector
        solution_vector = zeros(size(augmentedMatrix, 2)-1, 1);
    
        % Solve for variables based on RREF
        for i = 1:size(rrefMatrix, 1)
            if any(rrefMatrix(i, 1:end-1))
                leading_var_index = find(rrefMatrix(i, 1:end-1), 1, 'first');
                solution_vector(leading_var_index) = rrefMatrix(i, end);
            end
        end
    
        general_solution = null_space * sym('t');
        disp('X = X1 + tX0');
        disp('X1 =');
        disp(solution_vector); % Display corrected particular solution
        disp('tX0 =');
        disp(general_solution);
        % After solving for variables based on RREF and finding the general solution
        if ~isempty(N)
            for k = N
                % Generate example solution for each t = k
                example_solution = solution_vector + k * null_space;
                disp(['Example solution for t = ', num2str(k), ':']);
                disp(example_solution);
        
                % Extract the Y vector from the augmentedMatrix for comparison
                Y_vector = augmentedMatrix(:, end);
        
                % Validate solution
                V_matrix = augmentedMatrix(:, 1:end-1);
                if all(abs(V_matrix * example_solution - Y_vector) < 1e-6)
                    disp('This is a valid solution.');
                else
                    disp('This is not a valid solution.');
                end
        
                % Display the polynomial equation for the example solution
                disp(['The polynomial P(x) for t = ', num2str(k), ' is:']);
                dispPoly(example_solution, desiredDegree);
            end
        end
    else
        disp('Exactly one solution.');
        % Display the linear combination
        coefficients = rrefMatrix(1:end, end);
        disp('X =');
        disp(coefficients);
    
        % Display the polynomial equation for the example solution
        disp(['The polynomial P(x) is:']);
        dispPoly(coefficients, desiredDegree);
    end
    
    %% Optionally adjust desiredDegree based on findLeastDegreePoly flag
    if findLeastDegreePoly
        % Adjust desiredDegree based on the unique X values
        uniqueX = unique(X);
        desiredDegree = length(uniqueX) - 1; % Least degree polynomial for interpolation
        disp(['Adjusted degree for least degree polynomial: ', num2str(desiredDegree)]);
    end
end
