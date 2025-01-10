clc; clear; 

% A = [1 -2 0 -3 5 3;
%     -1 2 0 3 -1 -1;
%     1 0 2 -1 1 0;
%     -3 2 -4 5 2 2;
%     -3 1 -5 4 1 2];
% 
% P = [1 1 1 1;
%     0 1 1 1;
%     0 0 1 1;
%     0 0 0 1];
% 
% v = [21; -7; 8; -5; -9];

chosenFile = 1;
n= 1; 
%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    A = MatrixOperations.A;
    disp('WARNING: A is overwritten becuase of file read');
    disp('==========================');
end

%% Code 
%{
- **Inputs:**
  1. `A`: The matrix for which an orthonormal basis of the null space is to be found. 
            It is the primary input of the function.
  2. `verbose` (optional): A boolean flag that controls the verbosity of the output.
            If `verbose` is `true` or not provided (defaulting to `true`), the function
            prints detailed information about the process and intermediate results. If 
            `verbose` is `false`, the function suppresses detailed outputs, showing only
            the final orthonormal basis if needed.

- **Output:**
  - `Q`: The orthonormal basis for the null space of matrix `A`. This basis is obtained
            through QR factorization of the null space basis, which is initially determined from the
            Singular Value Decomposition (SVD) of `A`.
%}
[Q] = findOrthoBasis(A, true);

%% Optionally, save results to a .mat file
saveFile = true; % Set to true to save results
outputFileName = 'Quiz8.mat'; % Define output file name
varsToSave = {'Q'}; % Specify variables to save

if saveFile
    % Specify the directory path
    outputDirectory = 'Outputs';  % Assuming "Outputs" directory is inside the main directory

    % Construct the full path to the output file
    outputFilePath = fullfile(outputDirectory, outputFileName);

    % Save specified variables in the Outputs directory
    save(outputFilePath, varsToSave{:});

    disp('==========================');
    disp('Variables Q are saved in the Outputs directory');
end
