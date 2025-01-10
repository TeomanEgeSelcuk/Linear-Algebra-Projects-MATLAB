function [solution_vector, general_solution, linear_combination, basic_cols, non_basic_cols] = BasicMatrixOperations(MatrixOperations, verbose)
    % Initialize output variables
    solution_vector = [];
    general_solution = [];
    linear_combination = '';
    basic_cols = [];
    non_basic_cols = [];

    % Check if MatrixOperations structure has all required fields
    requiredFields = {'A', 'N', 'flags'};
    missingFields = setdiff(requiredFields, fieldnames(MatrixOperations));
    
    if ~isempty(missingFields)
        error(['Missing required fields in MatrixOperations: ', strjoin(missingFields, ', ')]);
    end
    
    % Extract variables from MatrixOperations
    A = MatrixOperations.A;
    N = MatrixOperations.N;
    exercises = {
        'Determinant', @() det(A); 
        'Inverse', @() inv(A); 
        'Transpose', @() A'; 
        'RREF', @() rref(A);
        'Cholesky', @() chol(A)
    };
    flags = MatrixOperations.flags;

    % Find and display the RREF of the matrix A
    [rrefMatrix, jb] = rref(A); % R is the RREF of A, jb contains the indices of the basic columns
    
    % Perform and Display Exercises
    for i = 1:size(exercises, 1)
        if flags(i)
            try
                result = exercises{i, 2}();
                if verbose 
                    disp(['=== ' exercises{i, 1} ' of the Matrix ===']);
                    disp(result);
                end 
            catch
                disp(['Error: Unable to compute ' exercises{i, 1} '.']);
            end
        end
    end

    if verbose
        fprintf('Matrix A:\n');
        disp(A);
        fprintf('Reduced Row Echelon Form of A (RREF):\n');
        disp(rrefMatrix);
    end
    
    % Identify basic and non-basic columns
    basic_cols = jb;
    non_basic_cols = setdiff(1:size(A,2), basic_cols);
    
    % Display basic and non-basic columns
    if verbose
        fprintf('Basic Columns: %s\n', mat2str(basic_cols));
        fprintf('Non-Basic Columns: %s\n', mat2str(non_basic_cols));
    end
    %% Check Linear Combination of the last column in RREF
    if verbose
        disp('=== Linear Combination in terms of the of the last column (B) in RREF V = (V1|V2|...Vn)===');
    end
    rref_A_without_last = rrefMatrix(:, 1:end-1);
    last_col_rref_A = rrefMatrix(:, end);
    nonzero_rows = find(any(rref_A_without_last, 2)); % Find rows with non-zero entries
    
    % Iterate over the columns of rref_A_without_last to calculate the linear combination
    for col = 1:size(rref_A_without_last, 2)
        coeff = rrefMatrix(col, end); % Coefficient for the linear combination from the last column of RREF
        
        if real(coeff) == 0
            coeffStr = sprintf('%gi', imag(coeff)); % Purely imaginary coefficient
        elseif imag(coeff) ~= 0
            coeffStr = sprintf('(%g%+gi)', real(coeff), imag(coeff)); % Complex coefficient
        else
            coeffStr = sprintf('%g', real(coeff)); % Real coefficient
        end

        % Determine if a positive sign should be added
        if ~isempty(linear_combination) && (real(coeff) >= 0 || (real(coeff) == 0 && imag(coeff) >= 0))
            signStr = '+ ';
        else
            signStr = '';
        end

        linear_combination = [linear_combination, sprintf('%s%sV%d ', signStr, coeffStr, col)];
        
    end

    % Remove trailing space
    linear_combination = strtrim(linear_combination);
    
    % Display the linear combination
    if verbose
        if isempty(linear_combination)
            disp('The last column of RREF is not a linear combination of the other columns.');
        else
            disp(['The last column of RREF is a linear combination: ', linear_combination]);
        end
    end

   if verbose
        fprintf('\nExpressing non-basic columns as linear combinations of basic columns (A1 | A2 | ... | An):\n\n');
    end
    
    % Expressing non-basic columns as linear combinations of basic columns
    for k = non_basic_cols
        if verbose
            fprintf('A%d = ', k);
            isFirstTerm = true; % Flag to track the first term in the combination
            
            for i = 1:length(basic_cols)
                coeff = rrefMatrix(i, k); % Adjusted: Directly access rrefMatrix using row i and column k

                % Format coefficient string based on its value (including zero)
                if coeff == 0
                    coeffStr = '0'; % Handle zero coefficient
                elseif isreal(coeff)
                    coeffStr = sprintf('%g', coeff); % Real coefficient
                elseif imag(coeff) ~= 0 && real(coeff) == 0
                    coeffStr = sprintf('%gi', imag(coeff)); % Purely imaginary
                else
                    coeffStr = sprintf('(%g%+gi)', real(coeff), imag(coeff)); % Complex
                end

                % Adjust the first coefficient's format to not prepend a '+ ' for a cleaner output
                if isFirstTerm && coeff ~= 0
                    isFirstTerm = false; % Update flag after processing the first term
                else
                    coeffStr = ['+ ' coeffStr]; % Prepend '+ ' for subsequent terms
                end
                
                fprintf('%s*A%d ', coeffStr, basic_cols(i));
            end
            fprintf('\n');
        end
    end



    %% Solutions Check 
    % Check for solutions
    if any(all(rrefMatrix(:, 1:end-1) == 0, 2) & rrefMatrix(:, end) ~= 0)
        if verbose
            disp('No solutions.');
        end
    
    % Infinitely many solutions
    elseif ~(isempty(non_basic_cols) || (length(non_basic_cols) == 1 && non_basic_cols(1) == size(A, 2)))
        if verbose
            disp('Infinitely many solutions.');
            disp('General solution is of the form:');
        end

        null_space = null(A(:, 1:end-1), 'r');
        solution_vector = zeros(size(A, 2)-1, 1);
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
            disp(solution_vector);
            disp('tX0 =');
            disp(general_solution);
        end
    
        for current_N = N
            if current_N > 0
                for k = current_N
                    example_solution = solution_vector + k * null_space;
                    if verbose
                        disp(['Example solution for t = ', num2str(k), ':']);
                        disp(example_solution);
                    end
                    % Validate solution
                    B = A(:, end);
                    % if all(abs(A(:, 1:end-1) * example_solution - B) < 1e-6) && verbose
                    %     disp('This is a valid solution.');
                    % elseif verbose
                    %     disp('This is not a valid solution.');
                    % end
                end
            end
        end
            
    else
        if verbose
            disp('Exactly one solution.');
        end
    end

    %% Check if the System is Trivial or Nontrivial
    if verbose
        disp('=== System Triviality Check ===');
        if all(rrefMatrix(:, end) == 0)
            disp('The system has a trivial solution.');
        else
            disp('The system has a nontrivial solution.');
        end
        disp('==========================================================');
    end
end
