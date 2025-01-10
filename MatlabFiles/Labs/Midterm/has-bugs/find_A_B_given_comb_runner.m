clc; clear;

%% Declaring Variables 
% Test Case 1
% x_vectors_a = struct('x2', [-2; 1; 0; 0], 'x4', [-3; 0; 2; 1]);
% dimension_a = [3, 4];
% [A_a, B_a] = find_A_B_given_comb(x_vectors_a, dimension_a, [], true);
% Expected A: [1 2 0 3; 0 0 1 -2; 0 0 0 0]
% Expected B: Not applicable for part (a)

% Test Case 2
x_vectors_b = struct('x2', [-2; 1; 0; 0], 'x4', [-3; 0; 2; 1]);
dimension_b = [3, 4];
X0_b = [1; 0; 1; 0];
[A_b, B_b] = find_A_B_given_comb(x_vectors_b, dimension_b, X0_b, true);
% Expected A: [1 2 0 3; 0 0 1 -2; 0 0 0 0]
% Expected B: [1; 1; 0]


%% Code
% [A, B1] = findA_B_given_comb(x_vectors, dimension, X0, verbose)


%% Optionally, save results to a .mat file
saveFile = true; % Set to true to save results
outputFileName = 'findA_B_given_comb_save.mat'; % Define output file name
varsToSave = {'A_a'}; % Specify variables to save

if saveFile
    % Specify the directory path
    outputDirectory = 'Outputs';  % Assuming "Outputs" directory is inside the main directory

    % Construct the full path to the output file
    outputFilePath = fullfile(outputDirectory, outputFileName);

    % Save specified variables in the Outputs directory
    save(outputFilePath, varsToSave{:});
end
