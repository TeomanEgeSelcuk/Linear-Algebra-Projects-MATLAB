% Define the matrix
matrix = [0 1 0 0 0; 0 0 1 1 1; 0 0 0 0 0; 0 1 1 0 0; 0 1 0 1 0];

% matrix = [0, 1, 1, 0;
%      0, 0, 1, 0;
%      0, 0, 0, 0;
%      1, 0, 0, 0];

% Print the original matrix
disp('Original Matrix:');
disp(matrix);

% Transpose the matrix
transposeMatrix = transpose(matrix);

% Print the transposed matrix
disp('Transposed Matrix:');
disp(transposeMatrix);

% Multiply the matrix by its transpose
resultMatrix = transposeMatrix .* matrix;

% Print the result matrix
disp('Result Matrix (Matrix * Transpose):');
disp(resultMatrix);
