clc; clear; 

% A = [1 -2 0 -3 5 3;
%     -1 2 0 3 -1 -1;
%     1 0 2 -1 1 0;
%     -3 2 -4 5 2 2;
%     -3 1 -5 4 1 2];

A = [1 1; 1 1; 1 -1; -1 1];

P = [1 0 0 0; 0 0 0 0; 0 0 0 1; 0 0 0 0];

v = [21; -7; 8; -5; -9];

chosenFile = 0;

%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    A = MatrixOperations.A;
    P = MatrixOperations.P;   % invertible matrix derived from A 
    v = MatrixOperations.v;   % v for Ax = v 
    disp('WARNING: A, P and v are overwritten becuase of file read');
    disp('==========================');
end

%% Code 
%{
basis1 is calculated by finding the Reduced Row Echelon Form (RREF) of A and then selecting the corresponding columns from A.
basis2 is calculated by multiplying basis1 with the inverse of P.
alpha1 is found by solving the linear equation basis1 * alpha1 = v.
alpha2 is obtained by multiplying P with alpha1.
%}
% verbose_changeOfBasis = false; 
% if verbose_changeOfBasis disp('=============Change of Basis============='); end
% [basis1, basis2, alpha1, alpha2] = change_of_basis(A, P, v, verbose_changeOfBasis);

%{
Question:
1) Given a matrix "A", determine the dimensions of the four fundamental 
subspaces

Inputs:
- A: Matrix to find the fundamental subspaces for.

Outputs:
- ColA: Basis for the column space of matrix A.
- RowA: Basis for the row space of matrix A.
- RnullA: Basis for the null space of matrix A.
- LnullA: Basis for the left null space of matrix A.
%}

% Define the matrix
A = [1 3 2 4; 2 1 -1 3; -1 2 3 1; 1 1 0 2];

% Set verbose to true for detailed outputs
verbose_calculateBasisSpaces = true;
calculateBasisSpaces_run = true; % Control function execution

if calculateBasisSpaces_run
    if verbose_calculateBasisSpaces
        disp('============Basis Spaces Calculation==============');
    end
    % Calculate the basis for the fundamental subspaces
    [ColA, RowA, RnullA, LnullA, changeOfCoordMatrix] = calculateBasisSpaces(A, verbose_calculateBasisSpaces);
end



%{
2) Question:
Given a matrix "A" and a dimension value "Rn_value", 
make a new matrix from "A" that forms a basis for R^n.

Inputs:
- A: Input matrix.
- Rn_value: The value of "n" for R^n.
- verbose: Controls detailed output (default is true).

Outputs:
- B: Matrix with linearly independent rows after 
Gaussian elimination that is in R^n
%}

% Input matrix
% A = [27 10 -7 -8 -33; 
%      10 4 -2 -3 -12; 
%      -6 -2 2 2 8; 
%      3 1 -1 -1 -4];

% Desired dimension
Rn_value = 4;

% Control verbosity and function execution
verbose_FindingBasis_inRn = false;
FindingBasis_inRn_run = false;

% Execute function if the control variable is set to true
if FindingBasis_inRn_run
    % Optional detailed outputs
    if verbose_FindingBasis_inRn
        disp('=========== Finding Basis in R^n ===========');
    end
    
    % Run the function with verbose control
    B = FindingBasis_inRn(ColA, Rn_value, ...
        verbose_FindingBasis_inRn);
end

%{
3) Question:
Analyze the null space of a given matrix using reduced and full QR factorization.
Determine if the basis for the null space is orthonormal, and if the null space 
can reconstruct the original matrix through the QR decomposition.

Inputs:
- A: The matrix to analyze.
- verbose: If true, detailed explanations are provided.

Outputs:
- Q: Orthonormal basis for the null space of matrix A (reduced QR).
- q: Orthogonal matrix from the full QR factorization of the null space basis.
%}

% Define matrix A
A = [1 1; 1 1; 1 -1; -1 1]; % Example 4x2 matrix

% Set verbose to true for detailed outputs
QRNullSpaceAnalysis_verbose = false; % Change to true for detailed explanations
QRNullSpaceAnalysis_run = false;  % Control function execution

% Run the function only if QRNullSpaceAnalysis_run is true
if QRNullSpaceAnalysis_run
    if QRNullSpaceAnalysis_verbose
        disp('============ QR Null Space Analysis ============');
    end
    
    % Run the QRNullSpaceAnalysis function with verbose control
    [Q, q] = QRNullSpaceAnalysis(A, QRNullSpaceAnalysis_verbose);
end

%{
Question:
4) Given a vector defining a subspace condition in R^m, determine if a subset of 
vectors forms a subspace with respect to this condition.

Inputs:
- m: The dimension of the vector space.
- v: A vector defining the subspace condition.
- inner_product_rule: Expected inner product value for the subspace condition.

Outputs:
- is_subspace: A boolean indicating whether the subset of vectors forms a subspace.
%}

% Define the dimension of the vector space
Rn_value = 4; % Example dimension
% Define the vector v
v = [1; 1; 1; -1]; % Example vector
% Define the expected inner product rule
inner_product_rule = 0; % Expected inner product value

% Set verbose to true for detailed outputs
check_subspacewithInnerProduct_verbose = true;
check_subspacewithInnerProduct_run = true;  % Control function execution

% Run the function only if check_subspacewithInnerProduct_run is true
if check_subspacewithInnerProduct_run
    if check_subspacewithInnerProduct_verbose
        disp('============ Subspace Analysis with Inner Product ============');
    end
    
    % Run the check_subspacewithInnerProduct function with verbose control
    is_subspace = check_subspacewithInnerProduct(Rn_value, v, inner_product_rule, check_subspacewithInnerProduct_verbose);
end

%{
5) Question:
Given a vector defining a subspace condition in R^m, calculate the dimension 
of the subspace using the rank-nullity theorem. Justify your answer.

Inputs:
- m: The dimension of the vector space.
- v: A vector defining the subspace condition.
- inner_product_rule: Expected inner product value to determine the subspace condition.

Outputs:
- dimension: The dimension of the subspace derived from the rank-nullity theorem.
- rank: The rank of the matrix formed by the vector defining the subspace condition.
%}

% Define the dimension of the vector space
Rn_value = 4; % Example dimension

% Define the vector v
v = [1; 1; 1; -1]; % Example vector defining the subspace condition

% Define the expected inner product rule
inner_product_rule = 0; % Expected inner product value

% Set verbose to true for detailed outputs
calculateSubspaceDimension_verbose = true;
calculateSubspaceDimension_run = true;  % Control function execution

% Only run the function if calculateSubspaceDimension_run is true
if calculateSubspaceDimension_run
    if calculateSubspaceDimension_verbose
        disp('============ Calculating the Dimension of the Subspace ============');
    end
    
    % Run the function with verbose control
    [dimension, rank] = calculate_subspace_dimension(Rn_value, v, inner_product_rule, calculateSubspaceDimension_verbose);
end

%{
Question:
6) Given a vector defining a constraint in R^n, find a basis of R^n that includes an 
orthonormal basis for the subspace defined by the constraint. Justify the construction 
of this basis.

Inputs:
- V: A vector defining the constraint in the subspace.
- verbose: Boolean flag to control the output of detailed steps.

Outputs:
- Q5: An orthonormal basis for R^n that includes the subspace defined by V.
%}

% Define the constraint vector
V = [1; 1; 1; -1]; % Example vector for R^4

% Set verbose to true to see detailed outputs
calculateOrthonormalBasis_verbose = true;
calculateOrthonormalBasis_run = true;  % Control function execution

% Only run the function if calculateOrthonormalBasis_run is true
if calculateOrthonormalBasis_run
    if calculateOrthonormalBasis_verbose
        disp('============ Calculating Orthonormal Basis for the Given Subspace ============');
    end

    % Run the calculateOrthonormalBasis function with verbose control
    Q5 = calculateOrthonormalBasis(V, calculateOrthonormalBasis_verbose);
end



%{
Question:
7) Given vectors that represent a column space and a null space, find a matrix "A"
 that satisfies these constraints.

Inputs:
- col_space: A matrix representing the column space.
- null_space: A matrix representing the null space.

Outputs:
- matrixA: Result of multiplying matrix "A" with its null space.
%}

% Define the column space vectors
column_vectors = [1, 5; 2, 6; 3, 7; 4, 8];
% Define the null space vectors
null_vectors = [9, 13; 10, 14; 11, 15; 12, 16];

% Set verbose to true to see detailed outputs
findMatrixGivenColNullSpaces_verbose = true;
findMatrixGivenColNullSpaces_run = false;  % Control function execution

if findMatrixGivenColNullSpaces_run
    % Run the solveMatrix function with the defined inputs
    if verbose_calculateSubspaceDimension
        disp('============Find A Matrix Given Column Space and Null Space==============');
    end
    MatrixA = findMatrixGivenColNullSpaces(column_vectors, ...
        null_vectors, findMatrixGivenColNullSpaces_verbose);
end


%{
Question:
8) Given a symbolic expression like L^2 + L- 6I involving matrix operations with terms 
that include the identity matrix, calculate specific results and matrices based on 
extracted coefficients and additional manipulations.

Inputs:
- eq: A symbolic expression involving matrix operations.
- m: The size of the identity matrix.
- coeffs: Coefficients for calculation.
- verbose: A flag indicating whether to print detailed outputs.

Outputs:
- Ln: The computed matrix using various operations.
- M1: A derived matrix from QR factorization, symmetric and positive definite
- M2: A derived matrix from QR factorization, symmetric and positive definite.
%}

% Example inputs
m = 2;  % Dimension for the identity matrix
eq = 'L^2 + L - 6I';  % Equation involving matrix 'L' and 'I'
coeffs = [1, 1, -6]; % Corresponding to eq 

% Set verbose to true to see detailed outputs
modularMatrixOperation_verbose = true;  % Print detailed outputs
modularMatrixOperation_run = false;  % Control function execution

% Execute the function if the run flag is true
if modularMatrixOperation_run

    % Run the modular_matrix_operation function with the given inputs
    if modularMatrixOperation_verbose
        disp('============ Modular Matrix Operation ==============');
    end

    % Create a new version of the modular_matrix_operation function to handle dynamic operations
    [Ln , M1, M2] = MatrixfromEquations(eq, m, coeffs, modularMatrixOperation_verbose);
end



%% Optionally, save results to a .mat file
saveFile = false; % Set to true to save results
outputFileName = 'Lab7.mat'; % Define output file name
varsToSave = {'basis1', 'basis2', 'alpha1', 'alpha2'}; % Specify variables to save

if saveFile
    % Specify the directory path
    outputDirectory = 'Outputs';  % Assuming "Outputs" directory is inside the main directory

    % Construct the full path to the output file
    outputFilePath = fullfile(outputDirectory, outputFileName);

    % Save specified variables in the Outputs directory
    save(outputFilePath, varsToSave{:});

    disp('==========================');
    disp('Variables A, P and v are saved in the Outputs directory');
end
