clc;    % Clear Command Window
clear;  % Clear workspace

%% Test Cases 
% A = [1 2 3 1; 2 4 6 2; 1 2 3 4]; % No Solutions 
% A = [1 4 7 10; 2 5 8 11; 3 6 9 13]; % No solution
% A = [2, 4, 8, 0; -3, -6, -10, 0; 2, 5, 5, 0]; % Exactly One Solution 
% A = [2 -1 -5; 4 1 -1; -5 2 11]; % Exactly One Solution 
% Infinitely Many Solutions 3 down below 
% A = [2, 4, 8, 0; -3, -6, -10, 0; 2, 4, 5, 0];  
% A = [1 1 1 1; 1 2 4 2] ; 
% A = [2 4 8 -8;-3 -6 -10 8;2 4 5 -2];
% A = [1 4 7 10; 2 5 8 11; 3 6 9 12];

%% Choose the file number to upload 
chosenFile = 2;

%% Code 
% List all .mat files in the current directory
files = dir('*.mat');
if isempty(files)
    error('No .mat files found in the current directory.');
end

% Print the names of all .mat files
fprintf('MAT files available for loading:\n');
for i = 1:length(files)
    fprintf('%d: %s\n', i, files(i).name);
end

% Load the first .mat file found 
load(files(chosenFile).name);

% Assume the matrix A is in the loaded file
if ~exist('A', 'var')
    error('Matrix A not found in the file.');
end

% Display matrix A
fprintf('\nMatrix A:\n');
disp(A);

% Find and display the RREF of the matrix A
[R, jb] = rref(A); % R is the RREF of A, jb contains the indices of the basic columns
fprintf('Reduced Row Echelon Form of A (RREF):\n');
disp(R);

% Identify basic and non-basic columns
basic_cols = jb;
non_basic_cols = setdiff(1:size(A,2), basic_cols);

% Display basic and non-basic columns
fprintf('Basic Columns: %s\n', mat2str(basic_cols));
fprintf('Non-Basic Columns: %s\n', mat2str(non_basic_cols));

% Adding the boolean variable
considerLastColumnAsB = false; % Set to false if the last column of A is not a B vector

% Calculate the number of columns to consider for rank calculation
numColsForRank = size(A, 2);
if not(considerLastColumnAsB)
    numColsForRank = numColsForRank - 1; % Exclude the last column if it's a B vector
end

% Check for infinitely many solutions
rref_A = rref(A);
if considerLastColumnAsB
    fprintf("Considering that the last column as column B in Aug Matrix (A | B) and checking for solutions"); 
    inf_solutions = not(any(all(rref_A(:, 1:end-1) == 0, 2) & rref_A(:, end) ~= 0)) && ...
                    rank(A(:, 1:end-1)) < size(A, 2)-1;
else
    fprintf("Considering that the last column as a column of Matrix A"); 
    inf_solutions =  ~isempty(non_basic_cols);
end
% inf_solutions = not(any(all(rref_A(:, 1:end-1) == 0, 2) & rref_A(:, end) ~= 0)) && ...
%                 rank(A(:, 1:end-1)) < size(A, 2)-1;

% inf_solutions = ~isempty(non_basic_cols); 

% Expressing non-basic columns as linear combinations of basic columns (A1 | A2 | ... | An)
if inf_solutions
    fprintf('\nThe system has infinitely many solutions.\nExpressing non-basic columns as linear combinations of basic columns (A1 | A2 | ... | An):\n\n');

    % Expressing non-basic columns as linear combinations of basic columns
    if ~isempty(non_basic_cols)
        for k = non_basic_cols
            fprintf('A%d = ', k);
            for i = 1:length(basic_cols)
                coeff = R(basic_cols(i), k);  % Complex coefficient
                % Handle complex coefficients
                if isreal(coeff)
                    coeffStr = sprintf('+ %g', coeff);
                elseif imag(coeff) ~= 0 && real(coeff) == 0
                    coeffStr = sprintf('+ %gi', imag(coeff));  % Purely imaginary
                else
                    coeffStr = sprintf('+ (%g%+gi)', real(coeff), imag(coeff));  % Complex
                end
                fprintf('%s*A%d ', coeffStr, basic_cols(i));
            end
            fprintf('\n');
        end
    else
        fprintf('There are no non-basic columns.\n');
    end
else
    fprintf('The system does not have infinitely many solutions.\n');
end

% Variables for saving output
saveFile = false;  % Set this to true or false as needed
outputFileName = 'myOutput.mat';  % Name of the .mat file, change as needed defaults to output.mat if left empty 
varsToSave = {'A', 'basic_cols', 'non_basic_cols'};  % List of variables to save example : {'A', 'basic_cols', 'non_basic_cols'}

% Save outputs to a .mat file if saveFile is true
if saveFile
    if isempty(outputFileName)
        outputFileName = 'output.mat';  % Default file name
    end

    if isempty(varsToSave)
        save(outputFileName);  % Save all variables
    else
        save(outputFileName, varsToSave{:});  % Save specified variables
    end
end
