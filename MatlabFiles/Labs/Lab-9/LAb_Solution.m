clc; clear;


chosenFile = 1;

%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    A = MatrixOperations.A;
    disp('WARNING: A is overwritten becuase of file read');
    disp('==========================');
end

% A = [1 0 -1 -2;0 1 1 -3;-4 0 4 8;0 3 3 -9];
% V = [1 -1 1 0;2 3 0 1]';

%% Code 
V = null(A, "rational");

[Q, R] = qr(V,0)  % The "reduced" QR factorization

A*Q  % Q is a basis for the null space

Q'*Q  % The columns of Q are orthonormal

Q*R

[q, r] = qr(V);  % The "full" QR factorization

q*q'  % q is an orthogonal matrix

q

%% Optionally, save results to a .mat file
saveFile = false; % Set to true to save results
outputFileName = 'Lab8.mat'; % Define output file name
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