clc; clear; 
chosenFile = 0


%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    % X = MatrixOperations.X;
    % Y = MatrixOperations.Y;
    disp('WARNING: X and Y are overwritten becuase of file read');
    disp('==========================');
end

%% Run the code

%{
Question:
Given a square matrix, determine the eigenvalues and eigenvectors,
along with unique eigenvalues, their multiplicities, and the basis for
each eigenspace. Also check if the matrix is a stochastic matrix and
whether the eigendecomposition can reconstruct the original matrix
accurately.

Inputs:
- A: The square matrix to analyze.
- verbose: If true, the code provides detailed output and explanations.

Outputs:
- V: The matrix of eigenvectors.
- D: The diagonal matrix of eigenvalues.
- eigenvalues: A vector of eigenvalues.
- eigenvectors: The matrix of eigenvectors.
- normalizationCheck: A check for stochastic matrix normalization.
- decompositionCheck: A check to verify the eigendecomposition.
- algebraic_multiplicity: The multiplicities of unique eigenvalues.
- eigenspace_basis: The basis for each eigenspace.
%}

% Define the input matrix A
A = [1 1/2 1 -1/2; 1 1/2 0 1/2; 1/2 0 1/2 1; -1/2 1 1/2 1];

% Set verbose to true for detailed outputs
EigenValueVectorMatrix_verbose = true;
EigenValueVectorMatrix_run = true;  % Control function execution

% Execute the function only if EigenValueVectorMatrix_run is true
if EigenValueVectorMatrix_run
    if EigenValueVectorMatrix_verbose
        disp('============Eigen Value Runner==============');
    end
    % Run the function with verbose enabled/disabled
    [V, D, eigenvalues, eigenvectors, normalizationCheck, decompositionCheck, algebraic_multiplicity, eigenspace_basis] = EigenValueVectorMatrix(A, ...
        EigenValueVectorMatrix_verbose);
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
