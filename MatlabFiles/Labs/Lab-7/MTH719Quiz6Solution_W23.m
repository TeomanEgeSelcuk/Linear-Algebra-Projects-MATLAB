clc; clear;

% Load the matrix A from the provided data file
% load('MTH719Quiz6Data.mat')
chosenFile = 1; 
%% Loading the .mat files
files = dir('*.mat');
if isempty(files)
    disp('No .mat files found in the current directory. Skipping file loading.');
else
    % Proceed only if chosenFile is within the valid range
    if chosenFile > length(files) || chosenFile < 1
        disp('Invalid file number chosen. Skipping file loading.');
    else
        chosenFileName = files(chosenFile).name;
        fprintf('Loading data from %s\n', chosenFileName);

        % Load the chosen .mat file
        loadedData = load(chosenFileName);

        % Dynamically assign loaded data to variables, ensuring vectors are transposed to row vectors
        variableNames = fieldnames(loadedData);
        for i = 1:length(variableNames)
            varData = loadedData.(variableNames{i});
            if isvector(varData) % Check if varData is a vector
                % Transpose column vectors to row vectors
                if iscolumn(varData)
                    varData = varData.';
                end
            end
            assignin('base', variableNames{i}, varData);
        end

        % Print the names and sizes of all variables stored in the chosen .mat file
        fileInfo = whos('-file', chosenFileName);
        fprintf('Variables in %s:\n', chosenFileName);
        for i = 1:length(fileInfo)
            fprintf('%d: %s - Size: %s\n', i, fileInfo(i).name, mat2str(fileInfo(i).size));
        end

        % Optionally, print contents of each loaded variable
        for i = 1:length(variableNames)
            fprintf('%s = \n', variableNames{i});
            disp(evalin('base', variableNames{i}));
        end
    end
end

%% Code 
% Determine the size of matrix A
[m, n] = size(A);
% Calculate the rank of matrix A
r = rank(A);

% Calculate the normal form of A, which helps in finding the bases of the four fundamental subspaces
[P, Q] = normalForm(A);

% Calculate the reduced row echelon form of A and the pivot columns
[Ea, c] = rref(A);

% ColA: Basis for the column space of A
% This is obtained by selecting the columns of A corresponding to the pivot columns in the RREF of A
ColA = A(:,c);

% RowA: Basis for the row space of A
% This is obtained by transposing the first r rows of the RREF of A,
% where r is the rank of A. These rows are linearly independent and span the row space.
RowA = Ea(1:r,:)';

% RnullA: Basis for the null space of A
% This is obtained by taking the columns of matrix Q corresponding to the free variables, i.e., from the (rank+1)th column to the nth column
RnullA = Q(:,r+1:n);

% LnullA: Basis for the left null space of A
% This is obtained by taking the rows of matrix P corresponding to the free variables, i.e., from the (rank+1)th row to the mth row
LnullA = P(r+1:m,:)';

% Save the variables ColA, RowA, RnullA, and LnullA to a file named Quiz6.mat
% These variables represent bases for the column space, row space, null space, and left null space of matrix A, respectively
% save('Quiz6','ColA','RowA','RnullA','LnullA')

%% Saving to a .mat file with redefined variable names and dynamically stating saved variables
saveFile = true;
outputFileName = 'Quiz6.mat';
variablesSaved = {'ColA', 'RowA','RnullA','LnullA'}; % Dynamically list variables here for output
if saveFile
    save(outputFileName, variablesSaved{:});
    disp(['Process completed. Variables ', strjoin(variablesSaved, ', '), ' are saved.']);
end