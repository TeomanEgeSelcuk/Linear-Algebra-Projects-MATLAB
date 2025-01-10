clc; clear;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              clear; clc;
% X = [10:10:80];
% Y = [25, 70, 380, 550, 610, 1220, 830, 1450]';
% X = [-1 0 1 2];
% Y = [4 1 0 -5]';
% X = [1 2 3 4];
% Y = [1 0 1 -2]';
% loadedData.X = X;
% loadedData.Y = Y;
% degree = 4; 
chosenFile = 0;

%% Least degree is the smallest degree before it becomes undefined 

%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    X = MatrixOperations.X;
    Y = MatrixOperations.Y;
    loadedData.X = X;
    loadedData.Y = Y;
    disp('WARNING: X and Y are overwritten becuase of file read');
    disp('==========================');
end


%{
Question:
1) Given a set of data points, determine the least degree polynomial that fits these points.
If the fitting fails, calculate a polynomial using an alternative method.
Additionally, determine the derivative constraints and compute the general solution.

Inputs:
- X, Y: The x and y coordinates of the data points.
- degree: The degree of the polynomial to fit.
- derivatives: The derivative constraints for the polynomial.

Outputs:
- P: The polynomial fit using the bestLeastSquaresFit function.
- error: The error from the bestLeastSquaresFit function.
- solution_vector: The solution from the PolynomialFit function.
- general_solution: The general solution obtained from PolynomialFit.
- t_values: Solution for t given the derivatives 
%}

% Define data points
X = [1, 2, 3, 4]; % x-coordinates
Y = [1, 4, 9, 16]; % y-coordinates
loadedData.X = X;
loadedData.Y = Y;
degree = 4; 
N = [1,2]; 
% degree , x value, y value 
derivatives = {
    3, 0, 54;  % d^3P/dx^3 at x = 0 should be 54
    % 2, 3, 12   % d^2P/dx^2 at x = 3 should be 12
};

% Set verbose to true for detailed outputs
polynomialFit_verbose = true;
polynomialFit_run = false;  % Control function execution

% Only run the function if polynomialFit_run is true
if polynomialFit_run
    if polynomialFit_verbose
        disp('============ Polynomial Fitting with Least Degree =============');
    end
    
    try
        % Fit the polynomial using bestLeastSquaresFit
        [P, error] = bestLeastSquaresFit(X, Y, degree, polynomialFit_verbose, printFit);
    catch
        % Fallback to PolynomialFit if bestLeastSquaresFit fails
        [solution_vector, general_solution, augmentedMatrix] = PolynomialFit(loadedData, degree, ...
            N, polynomialFit_verbose);
        
        if polynomialFit_verbose
            disp("Fallback to PolynomialFit due to error in bestLeastSquaresFit.");
        end
        
        % Compute the general solution with derivative constraints
        t_values = solveTforGeneralSolution(general_solution, solution_vector, derivatives, polynomialFit_verbose);
    end
    
    % Calculate the least degree for polynomial interpolation
    leastDegree = helper_LeastDegreePoly(loadedData);
end


%{
Question:
2) Calculate the change of basis matrices between two bases of the vector space of 
all third-degree or less polynomials. Determine the matrix to convert from the 
standard polynomial basis to a modified polynomial basis and vice versa.

Inputs:
- B: Standard polynomial basis {'1', 'x', 'x^2', 'x^3'}.
- B_prime: Modified polynomial basis {'1', 'x-1', '(x-1)(x-2)', '(x-1)(x-2)(x-3)'}.
- degree: The maximum degree of the polynomials in the basis, which is 3.

Outputs:
- is_basis1: A matrix indicating if the original basis can be expressed as a linear 
  combination of the new basis.
- change_of_basis_BprimetoB: Change of basis matrix from B_prime to B.
- is_basis2: A matrix indicating if the new basis can be expressed as a linear 
  combination of the original basis.
- change_of_basis_BtoBprime: Change of basis matrix from B to B_prime.
%}

% Define the standard and modified polynomial bases
B = {'1', 'x', 'x^2', 'x^3'};
B_prime = {'1', 'x-1', '(x-1)*(x-2)', '(x-1)*(x-2)*(x-3)'};
degree = 3;

% Set verbose to true for detailed outputs
checkBasis_verbose = false;
checkBasis_run = false;  % Control function execution

% Only run the function if checkBasis_run is true
if checkBasis_run
    if checkBasis_verbose
        disp('============ Calculating Change of Basis for Polynomial Vector Spaces ============');
    end
    
    % Calculate the change of basis from B to B_prime and vice versa
    [is_basis1, change_of_basis_BtoBprime] = check_basisPoly(B, B_prime, degree, checkBasis_verbose);
    [is_basis2, change_of_basis_BprimetoB] = check_basisPoly(B_prime, B, degree, checkBasis_verbose);
end


%{
Question:
3) Convert a polynomial expressed in one basis to another basis using a given change of basis matrix.
Calculate the coefficients of the polynomial $P(x)=10-15x+7x^2-x^3$ in a new basis.

Inputs:
- P: Change of basis matrix, defining how each vector from the original basis can be expressed in the new basis.
- coefficients: Coefficients of the polynomial in the original basis.

Outputs:
- newPoly_vector: Coefficients of the polynomial expressed in the new basis.
%}

% Define the change of basis matrix from basis B1 to B2 (frok the above function)

% Define the coefficients of the polynomial P(x) = 10 - 15x + 7x^2 - x^3 in basis B1
Poly_coefficients = [10; -15; 7; -1];

% Set the verbose flag to control the output
verbose_changeOfBasis = false;

% Control function execution
writingPolynomialintermsofBasis_run = false;

if writingPolynomialintermsofBasis_run
    if verbose_changeOfBasis
        disp('============ Change of Basis Calculation for Polynomial ============');
    end

    % Execute the change of basis operation
    newPoly_vector = writingPolynomialintermsofBasis(change_of_basis_BtoBprime, Poly_coefficients, verbose_changeOfBasis);
end


%{
Question:
4) Let the vector space W be all real-valued polynomials of degree 2 or less on the interval [-1, 1].
We define an inner product on this space by the integral from -1 to 1 of the product of two polynomials.
This function checks if the given polynomials are orthogonal and finds an orthonormal basis for W.

Inputs:
- polynomials: An array of symbolic expressions for polynomials.
- a, b: The interval endpoints for the inner product integral.
- verbose: Boolean flag to enable detailed output of the computations.

Outputs:
- OrthogonalCheck: Boolean indicating if all given polynomials are mutually orthogonal.
- orthonormal_basis: An array of polynomials that forms an orthonormal basis for W.
%}

% Define the polynomials in the vector space W
syms x;
polynomials = [1, x, 3*x^2 - 1]; % Basis polynomials P0, P1, P2
a = -1; % Start of the interval
b = 1;  % End of the interval

% Set verbose to control detailed outputs
verbose_orthonormality = false;

% Control the execution of the function
checkOrthogonalityPoly_run = false;
if checkOrthogonalityPoly_run
    if verbose_orthonormality
        disp('============ Orthogonality and Orthonormal Basis Calculation ============');
    end
    
    % Check orthogonality of the given polynomials
    OrthogonalCheck = checkOrthogonalityPoly(polynomials, a, b, verbose_orthonormality);
end


%{
Question:
5) Calculate an orthonormal basis for the vector space of real-valued polynomials of degree n or
 less defined on the interval [-1, 1], using the inner product defined by the integral 
from -1 to 1 of the product of two polynomials.

Inputs:
- polynomialArray: Array of symbolic expressions representing the polynomials for which an orthonormal basis is to be found.
- verbose: A boolean flag to control the display of detailed step-by-step calculations.

Outputs:
- OrthonormalBasis: The orthonormal basis for the vector space of real-valued polynomials of degree 2 or less on the interval [-1, 1].
%}

% Define the polynomial array
syms x;
polynomialArray = [1, x, 3*x^2 - 1];

% Set verbose flag for detailed output
calculateOrthonormalBasisPoly_verbose = true;

% Control function execution
calculateOrthonormalBasisPoly_run = false;  % Execution flag

if calculateOrthonormalBasisPoly_run
    if calculateOrthonormalBasisPoly_verbose
        disp('============ Orthonormal Basis Calculation for Polynomial Vector Space ============');
    end

    % Execute the function to calculate the orthonormal basis
    orthonormalBasis = calculateOrthonormalBasisPoly(polynomialArray, calculateOrthonormalBasisPoly_verbose);
end


%{
Question:
6) Determine whether a subset of a vector space is a subspace,
and find a basis for a given subset.

Inputs:
- propertyFcnArray: A cell array defining point properties in the format 
  {{x1, y1}, {x2, y2}, ...}.
- polynomials: A list of polynomials as symbolic expressions or strings.
- n: An integer representing the degree to which polynomials are evaluated.
- verbose: A flag to determine if detailed output is printed.

Outputs:
    - None
%}

% Define the symbolic variable
syms x;

% Define property functions and polynomials
propertyFcnArray = {
    {2, 0},  % {x1, y1}
    % Additional points can be uncommented or added
    % {3, 4},  % {x2, y2}
    % {5, 6},  % {x3, y3}
    % {7, 8},  % {x4, y4}
};

polynomials = {
    x^0, 
    x, 
    x^2, 
    x^3, 
    x - 1, 
    (x - 1) * (x - 2), 
    (x - 1) * (x - 2) * (x - 3)
};

n = 3; 
% Define verbose flag and execution flag
verbose_checkSubspace = true;
writeSubspaceofVectors_run = false;  % Control function execution

% Conditional execution controlled by 'writeSubspaceofVectors_run'
if writeSubspaceofVectors_run
    if verbose_checkSubspace
        disp('============ Subspace Verification and Basis Calculation ============');
    end

    % Call the function to evaluate polynomials and find a basis
    writeSubspaceofVectors(polynomials, propertyFcnArray, n, verbose_checkSubspace);
end



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
