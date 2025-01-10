                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              clear; clc;

chosenFile = 0;

%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    M = MatrixOperations.M;
    X_0 = MatrixOperations.X_0;
    disp('WARNING: X and Y are overwritten becuase of file read');
    disp('==========================');
end

%% Run the code
% Generate the stochastic matrix with verbosity
% verbose = true;
% M = generateStochasticMatrix(connections, verbose);
% 


%{
Question:
Calculate the new distribution of people across rooms after n iterations, using a stochastic matrix and an initial distribution vector.

Inputs:
- X_0: Initial state vector representing the distribution of people in rooms.
- M: Stochastic matrix representing probabilities of moving between rooms.
- n: Number of iterations to apply the matrix transformation.
- verbose: A flag to determine if detailed output is printed.

Outputs:
- X_1: New distribution of people after n iterations.
%}

M = [0.6 0.05;0.4 0.95];
M_2 = [0.9 0.01;0.1 0.99];
verbose = true 
X_0 = [0; 1];
n= 27;
% Calculate new distribution with verbosity
% The first distribution is X0 and X1
X_1 = calculateNewDistribution_X1(X_0, M, n, verbose);

% Calculate the initial distribution with the given verbosity
% X_0 = calculateInitialDistribution(X_1, M, verbose);



% Find the steady state vector
% q = findSteadyState(M, verbose);



%{
Question:
Given a symbolic matrix with a variable `x`, an initial vector, and an expected
result vector, find the value of `x` where the second component of the matrix
raised to a high power has the maximum value.

Inputs:
- initial_vector: A vector representing the initial state.
- expected_vector: A vector representing the expected outcome.
- A_sym: A symbolic matrix with a variable `x`.
- x_range: A range of possible `x` values.

Outputs:
- max_value: The maximum value found in the evaluation.
- x_at_max: The corresponding `x` value where the maximum is observed.
%}

% Define the given inputs
initial_vector = [1; 0];
expected_vector = [0.5; 0.5];
syms x
A_sym = sym([0.9 0.01; (1-x) x]);
x_range = [0, 1];

% Set verbose to true for detailed outputs
findForUnknowninVarStochasticMatrix_verbose = true;
findForUnknowninVarStochasticMatrix_run = false; % Control function execution

if findForUnknowninVarStochasticMatrix_run
    % Run the function with defined inputs
   if findForUnknowninVarStochasticMatrix_verbose
        disp('============ Finding Maximum Value in Symbolic Matrix ============');
    end
    
    % Call the function and capture the outputs
    [max_value, x_at_max] = findForUnknowninVarStochasticMatrix(initial_vector, ...
        expected_vector, A_sym, x_range, ...
        findForUnknowninVarStochasticMatrix_verbose);
end




%% Optionally, save results to a .mat file
saveFile = false; % Set to true to save results
outputFileName = 'Quiz10.mat'; % Define output file name
varsToSave = {'X_0'}; % Specify variables to save

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
