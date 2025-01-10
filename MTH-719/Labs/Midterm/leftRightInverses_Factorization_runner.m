clc; clear;

chosenFile = 0;

%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    % X = MatrixOperations.X; % Comment the read files like this 
    % Y = MatrixOperations.Y;
    disp('WARNING: X and Y are overwritten becuase of file read');
    disp('==========================');
end

%% Run the code

%{
Question:
Perform Singular Value Decomposition (SVD) on a given matrix to derive
the matrices B and C from the factorization, based on the rank of the
input matrix.

Inputs:
- A: The square matrix to decompose.
- verbose: If true, provide detailed explanations.

Outputs:
- B: The m x r factorized matrix.
- C: The r x n factorized matrix.
%}

% Define the input matrix A
% A = [1 2 3; 4 5 6; 7 8 9]; % Example 3x3 matrix

% Set verbose to true for detailed outputs
factorize_verbose = true;
factorize_run = false;  % Control function execution

% Execute the function only if factorize_run is true
if factorize_run
    if factorize_verbose
        disp('============Perform Singular Value Decomposition (SVD) with Factorization==============');
    end
    % Run the function with the verbose parameter
    [B, C] = factorize(A, factorize_verbose);
end

%{
Question:
Calculate the left inverse BA = I_n of a given matrix using the formula 
(A' * A)^-1 * A', and, if it fails, use the pseudoinverse for non-square 
or singular matrices.

Inputs:
- A: The matrix to find the left inverse of.
- verbose: If true, provide detailed steps and explanations.

Outputs:
- B: The left inverse of matrix A. If no left inverse is found, an empty 
array is returned.
%}

% Define the input matrix A
A = [1 2 3; 4 5 6; 7 8 9]; % Example 3x3 matrix
% A = [1 2; 3 4]; % Example full rank matrix
% A = [1 0 1/4; 
%      1 0 -1/4;
%      1 1 3/4;
%      1 1 5/4];

% Set verbose to true for detailed outputs
leftInverse_verbose = true;
leftInverse_run = false;  % Control function execution

if leftInverse_run
    % Run the function with verbose control
    if leftInverse_verbose
        disp('=================Left Inverse Calculation=================');
    end
    
    B = leftInverse(A, leftInverse_verbose);
end

%{
This function calculates the right inverse AB = I_m of a matrix if it has 
full row rank. The formula used for the right inverse is B = A' * inv(A * A'). 
If the matrix does not have a right inverse, the function returns an empty 
matrix.

Inputs:
- A: The matrix to check for the right inverse.
- verbose: If true, detailed explanations are provided.

Outputs:
- B: The right inverse of matrix A if it has full row rank. Otherwise, an empty array.
%}

% Define matrix A (example)
% A = [1 2 3; 4 5 6; 7 8 9]; % Example 3x3 matrix
A = [1 2; 3 4]; % Example full rank matrix

% Set verbose to true for detailed outputs
rightInverse_verbose = true;
rightInverse_run = true;  % Control function execution

% Only run the function if rightInverse_run is true
if rightInverse_run
    % Run the rightInverse function with verbose control
    if rightInverse_verbose
        disp('=================Right Inverse Calculation=================');
    end
    
    B = rightInverse(A, rightInverse_verbose);
end
%% Optionally, save results to a .mat file
saveFile = false; % Set to true to save results
outputFileName = 'Quiz10.mat'; % Define output file name
varsToSave = {'P'}; % Specify variables to save

if saveFile
    % Specify the directory path
    outputDirectory = 'Outputs';  % Assuming "Outputs" directory is inside the main directory

    % Construct the full path to the output file
    outputFilePath = fullfile(outputDirectory, outputFileName);

    % Save specified variables in the Outputs directory
    save(outputFilePath, varsToSave{:});

    disp('==========================');
    disp('Variable(s) are saved in the Outputs directory');
end
