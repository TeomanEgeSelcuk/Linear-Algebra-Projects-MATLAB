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

%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    A = MatrixOperations.A;
    P = MatrixOperations.P;   % invertible matrix derived from A 
    v = MatrixOperations.v;   % v for Ax = v 
    disp('WARNING: A, P and v are overwritten becuase of file read');
    disp('==========================');
end

%% Code 
%{
basis1 is calculated by finding the Reduced Row Echelon Form (RREF) of A and then selecting the corresponding columns from A.
basis2 is calculated by multiplying basis1 with the inverse of P.
alpha1 is found by solving the linear equation basis1 * alpha1 = v.
alpha2 is obtained by multiplying P with alpha1.
%}
[basis1, basis2, alpha1, alpha2] = change_of_basis(A, P, v, true);


%% Optionally, save results to a .mat file
saveFile = false; % Set to true to save results
outputFileName = 'Lab7.mat'; % Define output file name
varsToSave = {'basis1', 'basis2', 'alpha1', 'alpha2'}; % Specify variables to save

if saveFile
    % Specify the directory path
    outputDirectory = 'Outputs';  % Assuming "Outputs" directory is inside the main directory

    % Construct the full path to the output file
    outputFilePath = fullfile(outputDirectory, outputFileName);

    % Save specified variables in the Outputs directory
    save(outputFilePath, varsToSave{:});

    disp('==========================');
    disp('Variables A, P and v are saved in the Outputs directory');
end
