                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              clear; clc;
X = [10:10:80];
Y = [25, 70, 380, 550, 610, 1220, 830, 1450];
degree = 3; % For a quadratic fit
chosenFile = 0;

%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    X = MatrixOperations.X;
    Y = MatrixOperations.Y;
    disp('WARNING: X and Y are overwritten becuase of file read');
    disp('==========================');
end

%% Run the code
%{
P - The polynomial coefficients that best fit the data in a least squares sense, ordered from the highest degree term to the constant term.
error - The Euclidean norm of the residuals, quantifying the error of the fit.
%}
verbose_bestLeastSquaresFit = true; 
if verbose_bestLeastSquaresFit disp('============Best Least Squares Fit Analysis=============='); end
[P, error] = bestLeastSquaresFit(X, Y, degree, verbose_bestLeastSquaresFit, printFit); 


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
