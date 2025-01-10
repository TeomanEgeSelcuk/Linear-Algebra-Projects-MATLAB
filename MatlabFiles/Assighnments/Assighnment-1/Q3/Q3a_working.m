clc; clear;

% Load the knight matrix from the file
loadedData = load('Q3a.mat');
knightLoaded = loadedData.knight;

% Generate the knight move matrix for an 8x8 chessboard
knightGenerated = zeros(64, 64);
moveOffsets = [-2 -1; -2 1; -1 -2; -1 2; 1 -2; 1 2; 2 -1; 2 1];

for row = 1:8
    for col = 1:8
        currentIdx = (row - 1) * 8 + col;
        for k = 1:size(moveOffsets, 1)
            newRow = row + moveOffsets(k, 1);
            newCol = col + moveOffsets(k, 2);
            if newRow > 0 && newRow <= 8 && newCol > 0 && newCol <= 8
                newIdx = (newRow - 1) * 8 + newCol;
                knightGenerated(currentIdx, newIdx) = 1;
            end
        end
    end
end

% Check if the generated matrix is equivalent to the loaded matrix
if isequal(knightGenerated, knightLoaded)
    disp('The generated matrix is equivalent to the loaded matrix.');
else
    disp('The generated matrix is NOT equivalent to the loaded matrix.');
end

% Perform the specified tests on the loaded matrix
% Degree Verification
degrees = sum(knightLoaded, 2); % Sum of each row

% Symmetry Check
isSymmetric = isequal(knightLoaded, knightLoaded.');

disp('Knight Matrix: ');
disp(knightLoaded);

% Display results
disp('Degree of each vertex:');
disp(degrees);

disp('Symmetry Check (1 = True, 0 = False):');
disp(isSymmetric);

