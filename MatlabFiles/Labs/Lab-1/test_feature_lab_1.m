clear;  % Clear all variables from the workspace
clc;    % Clear the command window

%% Define Matrix A and Control Variables
% Uncomment the matrix A you want to test
% A = [1 2 3 1; 2 4 6 2; 1 2 3 4]; % No Solutions 
% A = [2, 4, 8, 0; -3, -6, -10, 0; 2, 5, 5, 0]; % Exactly One Solution 
% A = [2, 4, 8, 0; -3, -6, -10, 0; 2, 4, 5, 0]; % Infinitely Many Solutions 
% A = [1 1 1 1; 1 2 4 2]; 
% A = [2 4 8 -8;-3 -6 -10 8;2 4 5 -2];
A = [1 4 7 10; 2 5 8 11; 3 6 9 12]; % Example A
rref_A = rref(A);

N = [3,4]; % Control variable for generating example solutions
exercises = {'Determinant', @() det(A); 
             'Inverse', @() inv(A); 
             'Transpose', @() A'; 
             'RREF Transpose', @() rref_A';
             'Cholesky', @() chol(A)};
flags = [false, true, true, false, false];

%% Display Original Matrix and RREF
disp('=== Original Matrix A ===');
disp(A); 
disp('=== RREF of Matrix A ===');
disp(rref_A);

%% Perform and Display Exercises
for i = 1:size(exercises, 1)
    if flags(i)
        try
            result = exercises{i, 2}();
            disp(['=== ' exercises{i, 1} ' of the Matrix ===']);
            disp(result);
        catch
            disp(['Error: Unable to compute ' exercises{i, 1} '.']);
        end
    end
end

%% Check Linear Combination of the last column in RREF
disp('=== Linear Combination in terms of the of the last column (B) in RREF ===');
rref_A_without_last = rref_A(:, 1:end-1);
last_col_rref_A = rref_A(:, end);
nonzero_rows = find(any(rref_A_without_last, 2)); % Find rows with non-zero entries

linear_combination = '';
for i = 1:length(nonzero_rows)
    row = nonzero_rows(i);
    coeff = last_col_rref_A(row) / rref_A_without_last(row, i);
    if coeff ~= 0
        signStr = '+';
        if coeff < 0 || isempty(linear_combination)
            signStr = '';
        end
        linear_combination = [linear_combination, signStr, num2str(coeff), 'x', num2str(i)];
    end
end

if isempty(linear_combination)
    disp('The last column of RREF is not a linear combination of the other columns.');
else
    disp(['The last column of RREF is a linear combination: ', linear_combination]);
end

%% Solution Check
disp('=== Solution Check ===');
if any(all(rref_A(:, 1:end-1) == 0, 2) & rref_A(:, end) ~= 0)
    disp('No solutions.');
elseif rank(A(:, 1:end-1)) < size(A, 2)-1
    disp('Infinitely many solutions.');
    disp('General solution is of the form:');

    null_space = null(A(:, 1:end-1), 'r');
    solution_vector = zeros(size(A, 2)-1, 1);
    for i = 1:size(rref_A, 1)
        if any(rref_A(i, 1:end-1))
            leading_var_index = find(rref_A(i, 1:end-1), 1, 'first');
            solution_vector(leading_var_index) = rref_A(i, end);
        end
    end

    general_solution = null_space * sym('t');
    disp('X = X1 + tX0');
    disp('X1 =');
    disp(solution_vector);
    disp('tX0 =');
    disp(general_solution);

    % Generate and validate N example solutions
    if N > 0
        for k = 1:N
            example_solution = solution_vector + k * null_space;
            disp(['Example solution for t = ', num2str(k), ':']);
            disp(example_solution);
            % Validate solution
            B = A(:, end);
            if all(abs(A(:, 1:end-1) * example_solution - B) < 1e-6)
                disp('This is a valid solution.');
            else
                disp('This is not a valid solution.');
            end
        end
    end
else
    disp('Exactly one solution.');
    coefficients = rref_A(1:end-1, end);
    disp('Solution Vector X =');
    disp(coefficients);
end

%% Check if the System is Trivial or Nontrivial
disp('=== System Triviality Check ===');
if all(rref_A(:, end) == 0)
    disp('The system has a trivial solution.');
else
    disp('The system has a nontrivial solution.');
end

