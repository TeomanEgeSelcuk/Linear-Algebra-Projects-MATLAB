clc; clear;

% Test cases for the dividedDifference function

% Input data
X1 = [1, 2, 3, 4]; % Sample input
X2 = [2, 4, 6, 8]; % Another sample input

% Generate matrices D
D1 = dividedDifference(X1);
D2 = dividedDifference(X2);

% Check if D1 is lower triangular
isLowerTriangular1 = istriu(D1) == 0;

% Check if columns are formed by products of differences of the corresponding elements of X1
colCheck1 = true;
for i = 1:length(X1)
    for j = 1:i
        if j == 1
            val = 1;
        else
            val = D1(i, j-1) * (X1(i) - X1(j-1));
        end
        if abs(D1(i, j) - val) > eps
            colCheck1 = false;
            break;
        end
    end
end

% Check if D2 is lower triangular
isLowerTriangular2 = istriu(D2) == 0;

% Check if columns are formed by products of differences of the corresponding elements of X2
colCheck2 = true;
for i = 1:length(X2)
    for j = 1:i
        if j == 1
            val = 1;
        else
            val = D2(i, j-1) * (X2(i) - X2(j-1));
        end
        if abs(D2(i, j) - val) > eps
            colCheck2 = false;
            break;
        end
    end
end

% Check if D1 and D2 are invertible
isD1Invertible = rcond(D1) > eps;
isD2Invertible = rcond(D2) > eps;

% Check if D1 has a unique solution for D1*A1 = Y1
isD1UniqueSolution = rank(D1) == size(D1, 2);
% Check if D2 has a unique solution for D2*A2 = Y2
isD2UniqueSolution = rank(D2) == size(D2, 2);

% Display results
disp("Test Case 1:");
disp("Is D1 lower triangular? " + isLowerTriangular1);
disp("Columns of D1 are formed by products of differences of X1 elements? " + colCheck1);
disp("Is D1 invertible? " + isD1Invertible);
disp("D1 has a unique solution for D1*A1 = Y1? " + isD1UniqueSolution);

fprintf("\nTest Case 2:");
disp("Is D2 lower triangular? " + isLowerTriangular2);
disp("Columns of D2 are formed by products of differences of X2 elements? " + colCheck2);
disp("Is D2 invertible? " + isD2Invertible);
disp("D2 has a unique solution for D2*A2 = Y2? " + isD2UniqueSolution);
