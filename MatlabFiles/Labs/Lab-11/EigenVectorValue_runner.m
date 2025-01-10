clc; clear; 
chosenFile = 0;

%{
Except for the second eigenvalue, λ = 1, all the other eigenvalues are such
 that |λ| < 1.
We can consider the stochastic process,
X0, X1 = M X0, X2 = M X1 = M 2X0, . . . Xn = M Xn−1 = M nX0, . . .
and wonder about limn→∞ Xn. From the above we see that M is diagonalizable,
 so M n = P DnP −1,
and thus Xn = M nX0 = P DnP^−1X0. From our work in assignment 3 we know that
 limn→∞ Xn = q,
where q is the unique steady-state vector of the process, i.e., M q = q.
Clearly q is an eigenvector corresponding to the eigenvalue, λ = 1. 
In our example here that
would be any multiple of the second row of the matrix P found above.
%}


%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    A = MatrixOperations.A;
    disp('WARNING: A is overwritten becuase of file read');
    disp('==========================');
end

%% Run the code
verbose= true; 
% A = [0.3, 0.6, 0.1; 0.5, 0.2, 0.3; 0.4, 0.1, 0.5];
A = [.8 .1 .1;.2 .4 .4;.4 .3 .3];
[eigenvalues, eigenvectors, normalizationCheck, decompositionCheck] = EigenValueVectorMatrix(A, verbose);

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
