clear; clc;

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

%% Step 1: Finding RREF and Invertible Matrix P
augmentedMatrix = [A eye(size(A,1))];
[rrefMatrix, pivotCols] = rref(augmentedMatrix);
E_A = rrefMatrix(:, 1:size(A,2)); % Extract E_A
P = rrefMatrix(:, size(A,2)+1:end); % Extract P

%% Step 2: Checking the Result
% No additional MATLAB code required for this step; it's conceptual.

%% Step 3: Finding Matrix Q for Rank-Normal Form
% This step requires transposing E_A, then finding its RREF
EA_T = E_A';
augmentedMatrix_EAT = [EA_T eye(size(EA_T,1))];
[rrefMatrix_EAT, pivotCols_EAT] = rref(augmentedMatrix_EAT);
N = rrefMatrix_EAT(:, 1:size(EA_T,2))'; % Transpose back for N
Q = rrefMatrix_EAT(:, size(EA_T,2)+1:end)'; % Extract Q and transpose

%% Step 4: Solving AX = B
% Determine if the system AX = B has solutions
if any(rrefMatrix(:,end) == 0 & all(rrefMatrix(:,1:end-1) == 0, 2))
    disp('The system has no solution.');
elseif rank(A) < size(A,2)
    disp('The system has infinitely many solutions.');
else
    disp('The system has a unique solution.');
end

% Solve (PA)X = PB for X to find a particular solution
PB = P * B;
X_particular = E_A \ PB;

%% Distinguishing between No solution, Infinitely many solutions, and one solution
% Revised code snippet to include matrix V reference fix
basicColumns = sum(E_A ~= 0, 1) == 1; % Logical array for columns with leading ones in E_A
nonBasicColumnsExist = sum(basicColumns) < size(A, 2);

% Check for solutions
if any(all(rrefMatrix(:, 1:end-1) == 0, 2) & rrefMatrix(:, end) ~= 0)
    disp('No solutions.');
elseif nonBasicColumnsExist || rank(A) < size(A,1)
    disp('Infinitely many solutions.');
    disp('General solution involves parameters for free variables.');
else
    disp('Exactly one solution.');
    X_solution = P * B; % Solve using P since P*A = E_A
    disp('Solution X =');
    disp(X_solution);
end

%% Saving to a .mat file
saveFile = true; % Change to false if you do not wish to save
outputFileName = 'solutionResults.mat'; % Change the file name as needed
if saveFile
    save(outputFileName, 'A', 'B', 'E_A', 'P', 'Q', 'X_particular');
end

disp('Process completed.');
