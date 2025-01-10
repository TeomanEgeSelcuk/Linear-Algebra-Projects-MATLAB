% Test case 1: Square matrix (m = n)
A1 = [1, 2; 3, 4];
[B1, C1] = factorize(A1);
assert(norm(A1 - B1 * C1) < 1e-7, 'Test case 1 failed');
assert(rank(B1) == rank(A1) && rank(C1) == rank(A1), 'Rank condition failed for Test case 1');

% Test case 2: Matrix with more rows than columns (m > n)
A2 = [1; 2];
[B2, C2] = factorize(A2);
assert(norm(A2 - B2 * C2) < 1e-7, 'Test case 2 failed');
assert(rank(B2) == rank(A2) && rank(C2) == rank(A2), 'Rank condition failed for Test case 2');

% Test case 3: Matrix with more columns than rows (m < n)
A3 = [1, 2, 3; 4, 5, 6];
[B3, C3] = factorize(A3);
assert(norm(A3 - B3 * C3) < 1e-7, 'Test case 3 failed');
assert(rank(B3) == rank(A3) && rank(C3) == rank(A3), 'Rank condition failed for Test case 3');

% Display a message if all tests pass
disp('All test cases passed!');
