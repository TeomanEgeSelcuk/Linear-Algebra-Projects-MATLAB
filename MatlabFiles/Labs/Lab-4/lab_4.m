clear; clc;
t_Values = []; % Now t_Values is an array of t values. Make it empty, t_Values = [], to skip.
chosenFile = 2; % Choose the file number to upload
B = [2 4 9 -1]';
disp('B =');
disp(B);

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
disp('E_A =');
disp(E_A);
disp('P =');
disp(P);

%% Step 2: Checking the Result
% This step is conceptual and ensures PA = E_A.

%% Step 3: Finding Matrix Q for Rank-Normal Form
EA_T = E_A';
augmentedMatrix_EAT = [EA_T eye(size(EA_T,1))];
[rrefMatrix_EAT, pivotCols_EAT] = rref(augmentedMatrix_EAT);
N = rrefMatrix_EAT(:, 1:size(EA_T,2))'; % Transpose back for N
Q = rrefMatrix_EAT(:, size(EA_T,2)+1:end)'; % Extract Q and transpose
disp('Q =');
disp(Q);
disp('N =');
disp(N);

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
disp('PB =');
disp(PB);
disp('X =');
disp(X_particular);

% Revised code snippet to include matrix V reference fix
% Identify non-basic columns (those that do not contain a leading one)
basicColumns = sum(rrefMatrix(:,1:end-1) ~= 0) == 1; % Logical array for columns with leading ones
nonBasicColumnsExist = sum(basicColumns) < size(E_A, 2);

% Check for solutions
if any(all(rrefMatrix(:, 1:end-1) == 0, 2) & rrefMatrix(:, end) ~= 0)
    disp('No solutions.');
% Infinitely many solutions
elseif nonBasicColumnsExist
    disp('Infinitely many solutions.');
    % Display general solution in terms of t
    disp('General solution is of the form:');
    
    null_space = null(augmentedMatrix(:, 1:end-1), 'r');
    
    % Initialize solution vector
    solution_vector = zeros(size(augmentedMatrix, 2)-1, 1);

    % Solve for variables based on RREF
    for i = 1:size(rrefMatrix, 1)
        if any(rrefMatrix(i, 1:end-1))
            leading_var_index = find(rrefMatrix(i, 1:end-1), 1, 'first');
            solution_vector(leading_var_index) = rrefMatrix(i, end);
        end
    end

    general_solution = null_space * sym('t');
    disp('X = X1 + tX0');
    disp('X1 =');
    disp(solution_vector); % Display corrected particular solution
    disp('tX0 =');
    disp(general_solution);
    % After solving for variables based on RREF and finding the general solution
    if ~isempty(t_Values)
        for k = t_Values
            % Generate example solution for each t = k
            example_solution = solution_vector + k .* null_space;
            disp(['Example solution for t = ', num2str(k), ':']);
            disp(example_solution);
    
            % Extract the Y vector from the augmentedMatrix for comparison
            Y_vector = augmentedMatrix(:, end);
        end
    end
else
    disp('Exactly one solution.');
    % Display the linear combination
    coefficients = rrefMatrix(1:end, end);
    disp('X =');
    disp(coefficients);
end

%% Finding non-trivial solution to AX=0
nullSpace = null(A,'r');
if isempty(nullSpace)
    disp('The solution is trivial.');
else
    disp('The solution is nontrivial.');
    X = nullSpace(:,1); % Taking the first column as an example of a non-trivial solution
end

%% Saving to a .mat file with redefined variable names
saveFile = true;
outputFileName = 'output.mat'; % Updated file name as per your instruction
if saveFile
    X = X_particular; % Renaming X_particular to X for saving
    save(outputFileName, 'P', 'Q', 'X');
end

disp('Process completed. Variables P, Q, and X are saved.');
