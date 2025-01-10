clc; clear;

% Test case 1: Square matrix (m = n)
A1 = [1, 2; 3, 4];
B1 = rightInverse(A1);
assert(norm(A1 * B1 - eye(2)) < 1e-7, 'Test case 1 failed');

% Test case 2: Matrix with more columns than rows (m < n)
A2 = [1, 2, 3];
B2 = rightInverse(A2);
% Since A2 is 1x3, A2*B2 should result in a 1x1 identity matrix if B2 is correctly computed
assert(norm(A2 * B2 - eye(1)) < 1e-7, 'Test case 2 failed');


% Test case 3: Matrix with more rows than columns (m > n)
A3 = [1; 2];
B3 = rightInverse(A3);
assert(isempty(B3), 'Test case 3 failed: Should return empty for m < n without full row rank');

% Display a message if all tests pass
disp('All test cases passed!');