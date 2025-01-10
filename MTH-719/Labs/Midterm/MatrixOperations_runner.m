clc; clear;

%% Variables 
%% Define Matrix A and Control Variables
% Uncomment the matrix A you want to test
% MatrixOperations.A = [1 2 3 1; 2 4 6 2; 1 2 3 4]; % No Solutions 
% MatrixOperations.A = [2, 4, 8, 0; -3, -6, -10, 0; 2, 5, 5, 0]; % Exactly One Solution 
% MatrixOperations.A = [2, 4, 8, 0; -3, -6, -10, 0; 2, 4, 5, 0]; % Infinitely Many Solutions 
% MatrixOperations.A = [1 1 1 1; 1 2 4 2]; 
% MatrixOperations.A = [2 4 8 -8;-3 -6 -10 8;2 4 5 -2];
% MatrixOperations.A = [1 2 3; 1 3 4; -1 1 1; 2 2 -1]; % Example A
% MatrixOperations.A = [1, 1, -1; 2, 3, 1; 3, 4, 1; 2, 2, -1];
% Define matrix A directly
% MatrixOperations.A = [
%     2  1  1  3   0   4  1;
%     4  2  4  4   1   5  5;
%     2  1  3  1   0   4  3;
%     6  3  4  8   -3  9  5;
%     0  0  3  -3  0   0  3;
%     8  4  2  14  1   13 3
% ];
% MatrixOperations.A = [1 0 2 0 3;0 1 1 0 1;0 0 0 1 1; 0 0 0 0 1];
% MatrixOperations.A = [1 i 3; i 0 2+i; 1-i i 1-i];

chosenFile = 1;
%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    disp('WARNING: MatrixOperations.A is Overwritten by file read');
    disp('==========================');
end

% Other variables 
MatrixOperations.N = [1,2,3]; % Control variable for generating example solutions
%{
        'Determinant', @() det(A); 
        'Inverse', @() inv(A); 
        'Transpose', @() A'; 
        'RREF', @() rref(A);
        'Cholesky', @() chol(A)
%}
MatrixOperations.flags = [false, false, false, false, false];
NumberOfUniqueP = 3;

%% Run the Code 

[solution_vector, general_solution, linear_combination, basic_cols, non_basic_cols] = BasicMatrixOperations(MatrixOperations, true);
[trivialSolution, nontrivialSolution] = TrivialandNonTrivialSolutions(MatrixOperations.A);
[P, Q] = normalForm(MatrixOperations.A);
% checkNoSolutionCondition(P, true);
Rs = findAnotherP(MatrixOperations.A, P, NumberOfUniqueP, true);
elementaryMatrices = rrefmovie(MatrixOperations.A, true);

% % Print the contents of Rs
% fprintf('Rs =\n');
% for i = 1:numel(Rs)
%     fprintf('  Rs{%d} =\n', i);
%     disp(Rs{i});
% end

%% Optionally, save results to a .mat file
saveFile = false; % Set to true to save results
outputFileName = 'Midterm.mat'; % Define output file name
varsToSave = {'P','Q'}; % Specify variables to save

if saveFile
    % Specify the directory path
    outputDirectory = 'Outputs';  % Assuming "Outputs" directory is inside the main directory

    % Construct the full path to the output file
    outputFilePath = fullfile(outputDirectory, outputFileName);

    % Save specified variables in the Outputs directory
    save(outputFilePath, varsToSave{:});
end


%% Returns 

%{
    * `solution_vector`: This would typically contain the specific solution to the linear system if it has exactly one solution.
      Its purpose is to provide the explicit values that satisfy the equations.

    * `general_solution`: For systems with infinitely many solutions, this variable would represent the general solution in terms of free variables.
      It shows how solutions can be expressed as a linear combination of basic solutions and a particular solution.

    * `linear_combination`: Represents how the last column of the matrix (often the constants in an augmented matrix) can be expressed as a linear combination of the other columns.
      Useful for understanding dependencies between variables.

    * `basic_cols`: Indices of the basic columns in the matrix, which correspond to the pivot positions in the RREF.
      These columns form a basis for the column space of the matrix.

    * `non_basic_cols`: Indices of the non-basic columns, which do not contain pivot positions in the RREF.
      These columns can often be expressed as a linear combination of the basic columns in systems with infinitely many solutions.

    * `augmentedMatrix`: The original matrix `A` passed into the function, which might be augmented with a column for constants in a system of linear equations.
      It's useful for reference or further calculations.
%}
