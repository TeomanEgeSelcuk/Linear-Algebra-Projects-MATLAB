clc; clear; 

%% Define your data points
% X = [0, 1, 2, 4];
% Y = [1, 0, 7, 93];
% X = [-2, -1, 0, 1, 2, 3];
% Y = [49, 6, -1, -2, -3, 14];
% Initialize loadedData as a structure
clear; clc;
loadedData.X = [ 0, 1, 2];
loadedData.Y = [-1, -2, -3];
desiredDegree = 0 ;
N = []; % Now N is an array of t values. Make it empty, N = [], to skip.
chosenFile = 0; % Choose the file number to upload
findLeastDegreePoly = true; % Set this to true to find the least degree polynomial

%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    [loadedData, isSuccess] = readMatFile(chosenFile);
end

PolynomialFit(loadedData, desiredDegree, N, findLeastDegreePoly);

%% Saving results to a .mat file if desired
% saveFile = false; % Update as needed
% outputFileName = 'myOutput.mat'; % Update as needed
% varsToSave = {'X', 'Y', 'desiredDegree'}; % Update as needed
% if saveFile
%     writeMatFile(outputFileName, varsToSave);
% end

% try
%     % Call the function PolynomialFit with the provided arguments
%     PolynomialFit(X, Y, desiredDegree, N, chosenFile, findLeastDegreePoly);
% catch
%     warning('Function not executing correctly')
% end