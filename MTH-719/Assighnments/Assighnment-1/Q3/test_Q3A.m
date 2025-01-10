% Initialize an 8x8 matrix to zeros for the chessboard visualization
chessboard = cell(8, 8); % Use cell array to store strings

% Initialize 64x64 matrix for the knight's moves across the entire board
knight = zeros(64, 64);

% Define the starting position for "d4" in MATLAB indices
startRow = 5; % d row
startCol = 4; % 4 column

% Define knight moves (two steps in one direction, one step in the perpendicular direction)
moveOffsets = [-2 -1; -2 1; -1 -2; -1 2; 1 -2; 1 2; 2 -1; 2 1];

% Mark the starting position with "d4"
chessboard{startRow, startCol} = 'd4';

% Populate the chessboard and knight matrix with possible moves
for k = 1:size(moveOffsets, 1)
    newRow = startRow + moveOffsets(k, 1);
    newCol = startCol + moveOffsets(k, 2);
    
    if newRow > 0 && newRow <= 8 && newCol > 0 && newCol <= 8
        chessboard{newRow, newCol} = positionToLabel(newRow, newCol);
        knight((startRow-1)*8 + startCol, (newRow-1)*8 + newCol) = 1;
    end
end

% Now, calculate the degree of each vertex (each square on the chessboard)
vertexDegrees = sum(knight, 2); % Sum each row to get the degree of each vertex

% Display the degree of the "d4" square specifically
d4Index = (startRow-1)*8 + startCol; % Calculate the index of "d4" in the matrix
fprintf('Degree of "d4": %d\n', vertexDegrees(d4Index));

% Construct graph representation G = (V, E)
V = cell(1, 64); % Vertices
for i = 1:64
    V{i} = positionToLabel(ceil(i/8), mod(i-1, 8) + 1);
end

E = {}; % Edges
for i = 1:64
    for j = 1:64
        if knight(i, j) == 1
            E{end+1} = {V{i}, V{j}};
        end
    end
end

% Print vertices and edges
disp('Vertices V:');
disp(V);

disp('Edges E:');
for i = 1:length(E)
    fprintf('%s to %s\n', E{i}{1}, E{i}{2});
end

isequal(knight, knight')

% Save only the knight matrix in .mat file
save('Q3a.mat', 'knight');

% Place the local function definition at the end
function label = positionToLabel(row, col)
    % Convert matrix indices to chess notation (e.g., 1,1 -> a8)
    letters = 'abcdefgh';
    label = [letters(col), num2str(9-row)];
end
