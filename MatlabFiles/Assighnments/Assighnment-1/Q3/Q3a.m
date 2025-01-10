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

% Calculate and mark possible moves from "d4" on the chessboard and update the knight matrix
for k = 1:size(moveOffsets, 1)
    newRow = startRow + moveOffsets(k, 1);
    newCol = startCol + moveOffsets(k, 2);
    
    % Check if move is valid (within board)
    if newRow > 0 && newRow <= 8 && newCol > 0 && newCol <= 8
        % Mark possible moves from "d4" with their chess notation
        chessboard{newRow, newCol} = positionToLabel(newRow, newCol);
        % Update knight matrix to indicate a valid move
        knight((startRow-1)*8 + startCol, (newRow-1)*8 + newCol) = 1;
    end
end

% Fill the rest of the chessboard with zeros where there are no moves
for i = 1:8
    for j = 1:8
        if isempty(chessboard{i, j})
            chessboard{i, j} = '0';
        end
    end
end

% Display the chessboard matrix with "d4" for the starting position
disp('Chessboard matrix with moves from "d4":');
for row = 1:8
    for col = 1:8
        fprintf('%7s ', chessboard{row, col});
    end
    fprintf('\n');
end

% Display the directed graph from the knight matrix for "d4" moves only
disp('Directed Graph (Possible Knight Moves from "d4"):');
for j = 1:64
    if knight((startRow-1)*8 + startCol, j) == 1
        toLabel = positionToLabel(ceil(j/8), mod(j-1, 8) + 1);
        fprintf('Move from d4 to %s\n', toLabel);
    end
end

% Display the simplified knight matrix directly
disp('Simplified Knight Matrix (64x64):');
disp(knight);

% After constructing the knight matrix

% Degree Verification
degrees = sum(knight, 2); % Sum of each row

% Symmetry Check
isSymmetric = isequal(knight, knight.');

% Connectivity Check
% For MATLAB, you might use graph theory functions or other methods
% This pseudocode represents a conceptual approach
isConnected = checkConnectivity(knight);

% Display results
disp('Degree of each vertex:');
disp(degrees);

disp('Symmetry Check (1 = True, 0 = False):');
disp(isSymmetric);

disp('Checking for Connectivity:');
disp(isConnected);

% Save only the knight matrix in .mat file
% save('newQ3a.mat', 'knight');

% Function to convert position to chess notation label
function label = positionToLabel(row, col)
    % Convert matrix indices to chess notation (e.g., 1,1 -> a8)
    letters = 'abcdefgh';
    label = [letters(col), num2str(9-row)];
end

function isConnected = checkConnectivity(adjMatrix)
    % Number of vertices
    n = size(adjMatrix, 1);
    % Array to keep track of visited vertices
    visited = false(1, n);
    % Start DFS from the first vertex
    dfs(1, adjMatrix, visited);
    
    % Check if all vertices are visited
    isConnected = all(visited);
end

function dfs(vertex, adjMatrix, visited)
    visited(vertex) = true;
    for neighbor = 1:size(adjMatrix, 1)
        if adjMatrix(vertex, neighbor) == 1 && ~visited(neighbor)
            dfs(neighbor, adjMatrix, visited);
        end
    end
end

