%% Context
%{
Matrix P: This is an invertible matrix that, when multiplied by A, transforms A into its 
Reduced Row Echelon Form (RREF), EA. Transforming A into RREF using P makes it 
easier to see the solutions to the system of equations represented by A. It simplifies 
the rows of A, helping to identify solutions more clearly, including both trivial and 
nontrivial solutions for homogeneous systems.

Matrix Q: After A has been row-simplified by P into RREF, matrix Q is used to further 
simplify the columns of A. The operation PAQ transforms A into the rank-normal form, 
which clarifies the structure of A and the solutions to the system. This process 
assists in identifying solutions more efficiently by organizing A into a more 
interpretable form, making it straightforward to solve for both trivial and nontrivial 
cases, especially in the context of homogeneous systems AX = 0.

Trivial Solution: This usually refers to the most basic or simple solution to a system of equations, 
which often involves the solution being all zeros. For a homogeneous system of linear equations (where all 
the outcomes are set to zero, i.e., AX=0), the trivial solution is X=0, meaning each variable in the vector
 X is zero. This solution is always possible for homogeneous systems.

Nontrivial Solution: This refers to any solution to the system of equations that is not the trivial solution. 
In other words, at least one of the variables in X is not zero. Nontrivial solutions exist when the system has
more than one solution, typically occurring in underdetermined systems (systems where there are fewer equations
than unknowns) or in systems where the equations are not linearly independent.
%}

%% Set the Variables 
clear; clc;
saveFile = true;
outputFileName = 'MTH719Quiz4(Monday).mat';
variablesSaved = {'P', 'Q', 'B'}; % Dynamically list variables here for output
t_Values = []; % Now t_Values is an array of t values. Make it empty, t_Values = [], to skip.
chosenFile =2; % Choose the file number to upload
B = [2; 4; -9; -1];



%% Loading the .mat files
files = dir('*.mat');
if isempty(files)
    disp('No .mat files found in the current directory. Skipping file loading.');
else
    if chosenFile > length(files) || chosenFile < 1
        disp('Invalid file number chosen. Skipping file loading.');
    else
        chosenFileName = files(chosenFile).name;
        fprintf('Loading data from %s\n', chosenFileName);
        loadedData = load(chosenFileName);
        variableNames = fieldnames(loadedData);
        for i = 1:length(variableNames)
            varData = loadedData.(variableNames{i});
            if isvector(varData)
                if iscolumn(varData)
                    varData = varData.';
                end
            end
            assignin('base', variableNames{i}, varData);
        end
        fileInfo = whos('-file', chosenFileName);
        fprintf('Variables in %s:\n', chosenFileName);
        for i = 1:length(fileInfo)
            fprintf('%d: %s - Size: %s\n', i, fileInfo(i).name, mat2str(fileInfo(i).size));
        end
        for i = 1:length(variableNames)
            fprintf('%s = \n', variableNames{i});
            disp(evalin('base', variableNames{i}));
        end
    end
end

% Assuming A is defined in the loaded data or earlier in the script
%% Change 

%% Non-Trivial Solution to the Homogeneous Equation AX=0
X = null(A, 'r'); % 'r' option gives a rational basis if possible
X = X(:,1);
disp('Finding a Non-Trivial Solution to the Homogeneous Equation AX=0');
disp('Where X =');
disp(B);

% Check if X is a zero vector
if all(A*X == 0)
    disp('The solution X is a zero vector.');
else
    disp('The solution X is not a zero vector.');
end




%% Step 1: Calculating RREF of A and Finding Matrix P
augmentedMatrix = [A eye(size(A,1))];
[rrefMatrix, pivotCols] = rref(augmentedMatrix);
E_A = rrefMatrix(:, 1:size(A,2)); % Extract E_A
P = rrefMatrix(:, size(A,2)+1:end); % Extract P
disp('E_A =');
disp(E_A);
disp('P =');
disp(P);

%% Step 3: Dynamically Finding Matrix Q for Rank-Normal Form
EA_T = E_A';
augmentedMatrix_EAT = [EA_T eye(size(EA_T,1))];
[rrefMatrix_EAT, pivotCols_EAT] = rref(augmentedMatrix_EAT);
Q = rrefMatrix_EAT(:, size(EA_T,2)+1:end)'; % Extract Q and transpose
N = rrefMatrix_EAT(:, 1:size(EA_T,2))'; % Transpose back for N
disp('Q =');
disp(Q);
disp('N =');
disp(N);

% Check P * A * Q - N
disp('Checking P * A * Q - N (result should equal a zero matrix):');
check_PAQ = P * A * Q - N;
disp(check_PAQ);
if all(check_PAQ(:) == 0)
    disp('The result is a zero matrix.');
else
    disp('The result is not a zero matrix.');
end

% %% Step 4: Solving AX = B Dynamically (Adjustment needed)
rankA = rank(A);
numColumnsA = size(A,2);
numV = numColumnsA - rankA; % Determine the number of V vectors based on nullity

% Assuming we calculate or initialize V here after Q has been defined
% For demonstration, let's assume V is being extracted directly from Q as an example:
if numV > 0
    V = Q(:, end-numV+1:end); % Adjust based on your specific method to extract V
end

PB = P * B;

% Now, check if PB needs padding, after V is guaranteed to be initialized
PB_length = size(PB, 1);
V_length = size(V, 1);

if PB_length < V_length
    PB_padded = [PB; zeros(V_length - PB_length, 1)];
else
    PB_padded = PB; % No padding needed
end

% Displaying General Solution
disp('General solution is of the form: X = X1 + t1*V1 + ... + tn*Vn');

% Display X1 = PB_padded
disp('X1 =');
disp(PB_padded);

% Then display V values if V is not empty
if ~isempty(V)
    for i = 1:size(V, 2)
        fprintf('V%d =\n', i);
        disp(V(:,i));
    end
end

%% Saving to a .mat file with redefined variable names and dynamically stating saved variables
if saveFile
    save(outputFileName, variablesSaved{:});
    disp(['Process completed. Variables ', strjoin(variablesSaved, ', '), ' are saved.']);
end
