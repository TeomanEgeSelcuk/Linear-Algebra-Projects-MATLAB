function [solution_vector, general_solution, augmentedMatrix] = PolynomialFit(loadedData, desiredDegree, N, verbose)
    % Set default value for verbose
    if nargin < 4
        verbose = true;
    end
    
    solution_vector = []; % Default empty, will be assigned based on the situation
    general_solution = []; % Default empty, will be assigned based on the situation
    augmentedMatrix = []; % Will be filled with actual data
    
    if verbose
        disp(['For the desired degree: ', num2str(desiredDegree)]);
    end


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
    
    if verbose
        % Display the original augmented matrix
        disp('The original augmented matrix V: Vandermode Matrix [V|Y] is:');
        disp(augmentedMatrix);
    end
    
    % Find the RREF of the augmented matrix
    rrefMatrix = rref(augmentedMatrix);
    
    if verbose
        % Display the RREF matrix
        disp('The row-reduced echelon form (RREF) of the augmented matrix is:');
        disp(rrefMatrix);
    end
    
    % Determine if the system is underdetermined
    if desiredDegree >= n
        if verbose
            disp('The system is underdetermined.');
        end
    else
        if verbose
            disp('The system is not underdetermined.');
        end
    end
    
    % Identify non-basic columns (those that do not contain a leading one)
    basicColumns = sum(rrefMatrix(:,1:end-1) ~= 0) == 1; % Logical array for columns with leading ones
    nonBasicColumnsExist = sum(basicColumns) < size(V, 2);
    
    % Check for solutions
    if any(all(rrefMatrix(:, 1:end-1) == 0, 2) & rrefMatrix(:, end) ~= 0)
        if verbose
            disp('No solutions.');
        end
    % Infinitely many solutions
    elseif nonBasicColumnsExist
        if verbose
            disp('Infinitely many solutions.');
        end
        % Display general solution in terms of t
        if verbose
            disp('General solution is of the form:');
        end
        
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
        if verbose
            disp('X = X1 + tX0');
            disp('X1 =');
            disp(solution_vector); % Display corrected particular solution
            disp('tX0 =');
            disp(general_solution);
        end
        % After solving for variables based on RREF and finding the general solution
        if ~isempty(N)
            for k = N
                % Generate example solution for each t = k
                example_solution = solution_vector + k * null_space;
                if verbose
                    disp(['Example solution for t = ', num2str(k), ':']);
                    disp(example_solution);
                end
        
                % Extract the Y vector from the augmentedMatrix for comparison
                Y_vector = augmentedMatrix(:, end);
        
                % Validate solution
                V_matrix = augmentedMatrix(:, 1:end-1);
                if all(abs(V_matrix * example_solution - Y_vector) < 1e-6)
                    if verbose
                        disp('This is a valid solution.');
                    end
                else
                    if verbose
                        disp('This is not a valid solution.');
                    end
                end
        
                % Display the polynomial equation for the example solution
                if verbose
                    disp(['The polynomial P(x) for t = ', num2str(k), ' is:']);
                    helper_dispPoly(example_solution, desiredDegree);
                end
            end
        end
    else
        if verbose
            disp('Exactly one solution.');
        end
        % Display the linear combination
        solution_vector = rrefMatrix(1:end, end);
        if verbose
            disp('X =');
            disp(solution_vector);
        
            % Display the polynomial equation for the example solution
            disp(['The polynomial P(x) is:']);
            helper_dispPoly(solution_vector, desiredDegree);
        end
    end
end
