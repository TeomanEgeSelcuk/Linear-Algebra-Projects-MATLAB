clc; clear; 

%% Define your data points
% X = [0, 1, 2, 4];
% Y = [1, 0, 7, 93];
% X = [-2, -1, 0, 1, 2, 3];
% Y = [49, 6, -1, -2, -3, 14];
loadedData.X = [ 0, 1, 2];
loadedData.Y = [-1, -2, -3];
desiredDegree = 1 ;
N = []; % Now N is an array of t values. Make it empty, N = [], to skip.
chosenFile = 0; % Choose the file number to upload
findLeastDegreePoly = true; % Set this to true to find the least degree polynomial

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
        loadedData = load(chosenFileName)
        
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
% Number of data points
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

n = length(X);

% Create the Vandermonde-like matrix
V = zeros(n, desiredDegree + 1);
for i = 1:n
    for j = 1:desiredDegree + 1
        V(i, j) = X(i)^(j-1);
    end
end

% Form the augmented matrix [V|Y]
augmentedMatrix = [V, Y'];

% Display the original augmented matrix
disp('The original augmented matrix [V|Y] is:');
disp(augmentedMatrix);

% Find the RREF of the augmented matrix
rrefMatrix = rref(augmentedMatrix);

% Display the RREF matrix
disp('The row-reduced echelon form (RREF) of the augmented matrix is:');
disp(rrefMatrix);

% Determine if the system is underdetermined
if desiredDegree >= n
    disp('The system is underdetermined.');
else
    disp('The system is not underdetermined.');
end

% Identify non-basic columns (those that do not contain a leading one)
basicColumns = sum(rrefMatrix(:,1:end-1) ~= 0) == 1; % Logical array for columns with leading ones
nonBasicColumnsExist = sum(basicColumns) < size(V, 2);

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
    if ~isempty(N)
        for k = N
            % Generate example solution for each t = k
            example_solution = solution_vector + k * null_space;
            disp(['Example solution for t = ', num2str(k), ':']);
            disp(example_solution);
    
            % Extract the Y vector from the augmentedMatrix for comparison
            Y_vector = augmentedMatrix(:, end);
    
            % Validate solution
            V_matrix = augmentedMatrix(:, 1:end-1);
            if all(abs(V_matrix * example_solution - Y_vector) < 1e-6)
                disp('This is a valid solution.');
            else
                disp('This is not a valid solution.');
            end
    
            % Display the polynomial equation for the example solution
            disp(['The polynomial P(x) for t = ', num2str(k), ' is:']);
            dispPoly(example_solution, desiredDegree);
        end
    end
else
    disp('Exactly one solution.');
    % Display the linear combination
    coefficients = rrefMatrix(1:end, end);
    disp('X =');
    disp(coefficients);

    % Display the polynomial equation for the example solution
    disp(['The polynomial P(x) is:']);
    dispPoly(coefficients, desiredDegree);
end

%% Least Degree Polynomial 

% Adjust desiredDegree if findLeastDegreePoly is true
if findLeastDegreePoly
    % Ensure X is available and unique for interpolation
    if exist('X', 'var')
        uniqueX = unique(X);
        desiredDegree = length(uniqueX) - 1; % Least degree polynomial
        fprintf('The least degree polynomial that interpolates the data: %d\n', desiredDegree);
    else
        disp('X is not defined. Cannot find least degree polynomial.');
    end
end

%% Saving 
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

%% Functions 
% Function to display polynomial
function dispPoly(solution, degree)
    str = "P(x) = ";
    for i = 1:length(solution)
        coef = solution(i);
        if coef ~= 0
            if i == 1
                str = [str, sprintf('%.2f', coef)];
            elseif i == 2
                str = [str, sprintf(' - %.2fx', abs(coef))];
            else
                if coef > 0
                    str = [str, sprintf(' + %.2fx^%d', coef, i-1)];
                else
                    str = [str, sprintf(' - %.2fx^%d', abs(coef), i-1)];
                end
            end
        end
    end
    disp(str);
end

