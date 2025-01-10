clc; clear;

%% Testing Values 
% Example data points (uncomment to use)
% loadedData.X = [0, 1, 2, 4];
% loadedData.Y = [1, 0, 7, 93];
% loadedData.X = [-2, -1, 0, 1, 2, 3];
% loadedData.Y = [49, 6, -1, -2, -3, 14];
% loadedData.X = [-2, -1, 0, 1, 2, 3];
% loadedData.Y = [49, 6, -1, -2, -3, 14];
% loadedData.X = [1, 2, 3];
% loadedData.Y = [1, 1, 7];

%% Define variables 
% loadedData.X = [ 0, 1, 2];
% loadedData.Y = [-1, -2, -3];
loadedData.X = [1 2 3 4];
loadedData.Y = [10 5 3 2];
desiredDegree = 3; % Desired degree for polynomial fitting
N = [1]; % Optional: specific values for evaluating general solutions if system is underdetermined
chosenFile = 0 ; % Optional: specify a file number for loading data
findLeastDegreePoly = true; % Flag to find the least degree polynomial that fits the data
% For formula Generate X and Y Usecase (skips if any of startingPoint, stepSize , equation = []) 
startingPoint = 1;
stepSize = 1;
endPoint= 5;
equation = []; 
% equation = @(x) sum((2*(1:x)-1).^2); % Summation Notation
% equation = @(x)(2*x-1)^2; % Normal equation 

% Check if any of the parameters are empty
if isempty(startingPoint) || isempty(stepSize) || isempty(equation)
    % Identify which parameters are empty
    emptyParams = '';
    if isempty(startingPoint)
        emptyParams = [emptyParams ' startingPoint'];
    end
    if isempty(stepSize)
        emptyParams = [emptyParams ' stepSize'];
    end
    if isempty(equation)
        emptyParams = [emptyParams ' equation'];
    end
    % Remove leading space
    emptyParams = strtrim(emptyParams);
    
    % Print empty parameter names
    disp([emptyParams ' are empty.']);
else
    % Check if endPoint is defined
    if isempty(endPoint)
        % Generate X values using desiredDegree
        X = startingPoint:stepSize:desiredDegree;
    else
        % Generate X values using endPoint
        X = startingPoint:stepSize:endPoint;
    end
    
    % Initialize Y values
    Y = zeros(size(X));
    
    % Evaluate the equation for each X value to generate Y values
    for i = 1:length(X)
        Y(i) = equation(X(i));
    end
    
    % Store X and Y values in LoadedData structure
    loadedData.X = X;
    loadedData.Y = Y;
    disp('WARNING: X and Y are Overwritten becuase of file read');
    disp('==========================');
end


%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [loadedData, isSuccess] = readMatFile(chosenFile);
end

%% Running the code 
if findLeastDegreePoly
    leastDegree = helper_LeastDegreePoly(loadedData);
end

% Call the polynomial fitting function
[solution_vector, general_solution, augmentedMatrix] = PolynomialFit(loadedData, desiredDegree, N, true);
disp("The Least Degree to Interpolate a Polynomial is: ");
disp(leastDegree);

%% Optionally, save results to a .mat file
saveFile = false; % Set to true to save results
outputFileName = 'Polyfit.mat'; % Define output file name
varsToSave = {'general_solution', 'leastDegree', 'augmentedMatrix'}; % Specify variables to save
if saveFile
    % Specify the directory path
    outputDirectory = 'Outputs';  % Assuming "Outputs" directory is inside the main directory

    % Construct the full path to the output file
    outputFilePath = fullfile(outputDirectory, outputFileName);

    % Save specified variables in the Outputs directory
    save(outputFilePath, varsToSave{:});
end
