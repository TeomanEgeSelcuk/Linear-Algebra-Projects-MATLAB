clear;  % Clear all variables from the workspace
clc;    % Clear the command window
clear; 
%% Test Cases 
% A = [1 2 3 1; 2 4 6 2; 1 2 3 4]; % No Solutions 
% A = [1 4 7 10; 2 5 8 11; 3 6 9 13]; % No solution
% A = [2, 4, 8, 0; -3, -6, -10, 0; 2, 5, 5, 0]; % Exactly One Solution 
% A = [2 -1 -5; 4 1 -1; -5 2 11]; % Exactly One Solution 
% Infinitely Many Solutions 3 down below 
% A = [2, 4, 8, 0; -3, -6, -10, 0; 2, 4, 5, 0];  
% A = [1 1 1 1; 1 2 4 2] ; 
% A = [2 4 8 -8;-3 -6 -10 8;2 4 5 -2];
A = [1 4 7 10; 2 5 8 11; 3 6 9 12];

% Example A's (Replace A with inteneded matrix)
% A = [ ... ]

% % Control variables for printing the following 
exercise_determinant = true;
exercise_inverse = true;
exercise_cholesky = true;
%% Transpose function add

% Display the original matrix A
disp('Original Matrix A:');
disp(A); 

% Find and display the reduced row echelon form of A
rref_A = rref(A);
disp('RREF of Matrix A:');
disp(rref_A);


% Determinant
if exercise_determinant
    try
        determinant_result = det(A); % Attempt to compute determinant
        disp('Determinant of the matrix:');
        disp(determinant_result);    % Display determinant if successful
    catch
        disp('Error: Unable to compute determinant.'); % Display an error message if there is an issue
    end
end

% Inverse
if exercise_inverse
    try
        inverse_result = inv(A); % Attempt to compute inverse
        disp('Inverse of the matrix:');
        disp(inverse_result);    % Display inverse if successful
    catch
        disp('Error: Unable to compute inverse.'); % Display an error message if there is an issue
    end
end


% Cholesky Factorization
if exercise_cholesky
    try
        cholesky = chol(A); 
        disp('Cholesky factorization of the matrix:');
        disp(cholesky);
    catch
        disp('Cholesky factorization does not exist.');
    end
end

% Check for solutions
if any(all(rref_A(:, 1:end-1) == 0, 2) & rref_A(:, end) ~= 0)
    disp('No solutions.');
% Infinitely many solutions
elseif rank(A(:, 1:end-1)) < size(A, 2)-1
    disp('Infinitely many solutions.');
    % Display general solution in terms of t
    disp('General solution is of the form:');
    
    null_space = null(A(:, 1:end-1), 'r');
    
    % Initialize solution vector
    solution_vector = zeros(size(A, 2)-1, 1);

    % Solve for variables based on RREF
    for i = 1:size(rref_A, 1)
        if any(rref_A(i, 1:end-1))
            leading_var_index = find(rref_A(i, 1:end-1), 1, 'first');
            solution_vector(leading_var_index) = rref_A(i, end);
        end
    end

    general_solution = null_space * sym('t');
    disp('X = X1 + tX0');
    disp('X1 =');
    disp(solution_vector); % Display corrected particular solution
    disp('tX0 =');
    disp(general_solution);
else
    disp('Exactly one solution.');
    % Display the linear combination
    coefficients = rref_A(1:end-1, end);
    disp('X =');
    disp(coefficients);
end

% Check if the system is trivial or nontrivial
if all(rref_A(:, end) == 0)
    disp('The solution is trivial.');
else
    disp('The solution is nontrivial.');
end


