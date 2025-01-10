
% Test case 1
X1 = [1, 2, 3, 4];
D1 = dividedDifference(X1);
D2 = dividedDifference_2(X1);
assert(isequal(D1, D2), 'Test case 1 failed: The outputs of dividedDifference and dividedDifference_2 do not match.');

% Test case 2
X2 = [0, 1, 4, 6];
D1 = dividedDifference(X2);
D2 = dividedDifference_2(X2);
assert(isequal(D1, D2), 'Test case 2 failed: The outputs of dividedDifference and dividedDifference_2 do not match.');

% Test case 3
X3 = [5, 3, 1, -1];
D1 = dividedDifference(X3);
D2 = dividedDifference_2(X3);
assert(isequal(D1, D2), 'Test case 3 failed: The outputs of dividedDifference and dividedDifference_2 do not match.');

disp('All test cases passed successfully.');


