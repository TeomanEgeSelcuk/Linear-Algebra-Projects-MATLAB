clc; clear; 

% Test case 1: Square matrix (m = n)
A1 = [1, 2; 3, 4];
B1 = leftInverse(A1);
assert(norm(B1 * A1 - eye(2)) < 1e-7, 'Test case 1 failed');

% Test case 2: Matrix with more rows than columns (m > n)
A2 = [1; 2];
B2 = leftInverse(A2);
assert(norm(B2 * A2 - eye(1)) < 1e-7, 'Test case 2 failed')

% Test case 3: Matrix with more columns than rows (m < n)
A3 = [1, 2, 3; 4, 5, 6];
B3 = leftInverse(A3);
assert(isempty(B3), 'Test case 2 failed: Should return empty for m > n without full column rank');

% Display a message if all tests pass
disp('All test cases passed!');