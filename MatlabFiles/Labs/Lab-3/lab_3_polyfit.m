clc; clear;

%% Define your data points
X = [0, 1, 2];
Y = [-1, -2, -3];
desiredDegree = 0;
N = []; % Make it empty, N = [], to skip.
chosenFile = 0; % Choose the file number to upload
findLeastDegreePoly = true; % Set this to true to find the least degree polynomial

%% Loading the .mat files
% This section remains unchanged.

%% Polynomial Fitting with Vandermonde Matrix and polyfit
% Creating Vandermonde matrix for manual fitting
n = length(X);
V = zeros(n, desiredDegree + 1);
for i = 1:n
    for j = 1:desiredDegree + 1
        V(i, j) = X(i)^(j-1);
    end
end

% Display the Vandermonde matrix
disp('Vandermonde Matrix:');
disp(V);

% Solve the linear system using the RREF
augmentedMatrix = [V, Y'];
rrefMatrix = rref(augmentedMatrix);

% Extract coefficients from the RREF matrix
coefficients = rrefMatrix(:,end);

% Display the RREF matrix and coefficients
disp('The row-reduced echelon form (RREF) of the augmented matrix is:');
disp(rrefMatrix);
disp('Coefficients from RREF:');
disp(coefficients);

% Using polyfit for comparison
p = polyfit(X, Y, desiredDegree);

% Display polynomial coefficients from polyfit
fprintf('Polynomial coefficients from polyfit (highest to lowest degree): \n');
disp(p);

%% Displaying polynomial of desired degree
fprintf('Interpolated for desired degree: %d\n', desiredDegree);
disp('Polynomial of the desired degree:');
dispPoly(coefficients, desiredDegree);

%% Least Degree Polynomial Adjustment
if findLeastDegreePoly
    uniqueX = unique(X);
    % Adjust desiredDegree to fit the least degree polynomial necessary for interpolation
    leastDegree = length(uniqueX) - 1;
    p_least = polyfit(X, Y, leastDegree);

    % Displaying the least degree polynomial coefficients
    fprintf('Least degree polynomial coefficients (highest to lowest degree): \n');
    disp(p_least);

    %% Displaying polynomial of the least degree
    fprintf('Interpolated for least degree: %d\n', leastDegree);
    disp('Polynomial of the least degree:');
    dispPoly(flip(p_least), leastDegree);
end

%% Saving 
% This section remains unchanged.

%% Functions
function dispPoly(solution, degree)
    str = "P(x) = ";
    reverseSolution = flip(solution); % Correctly align the solution for display
    for i = 1:length(reverseSolution)
        coef = reverseSolution(i);
        if coef ~= 0
            power = length(reverseSolution) - i;
            if i == 1 % Constant term
                str = [str, sprintf('%.2f', coef)];
            elseif i == 2 % Linear term
                if coef > 0
                    str = [str, sprintf(' + %.2fx', coef)];
                else
                    str = [str, sprintf(' - %.2fx', abs(coef))];
                end
            else % Higher degree terms
                if coef > 0
                    str = [str, sprintf(' + %.2fx^%d', coef, power)];
                else
                    str = [str, sprintf(' - %.2fx^%d', abs(coef), power)];
                end
            end
        end
    end
    disp(str);
end
