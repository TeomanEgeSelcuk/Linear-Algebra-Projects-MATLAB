clc; clear;
knightsTravelChessboard();

function knightsTravelChessboard()
    % Define the chessboard size
    n = 8; % 8x8 chessboard
    fprintf('Generating the adjacency matrix for the knight moves on an 8x8 chessboard...\n');

    % Generate the adjacency matrix for the chessboard
    A = generateAdjacencyMatrix(n);
    
    % Calculate minimum moves to reach each square from b1
    [maxMoves, farthestIndices] = calculateMoves(A, n);
    
    % Output results
    fprintf('\nMaximum distance from b1: %d moves.\n', maxMoves);
    fprintf('Squares farthest from b1: ');
    printFarthestSquares(farthestIndices, n);
end

function A = generateAdjacencyMatrix(n)
    % Initialize the adjacency matrix
    A = zeros(n^2, n^2);
    % Generate moves
    for row = 1:n
        for col = 1:n
            index = (row - 1) * n + col;
            moves = knightMoves(row, col, n);
            for move = moves'
                targetIndex = (move(1) - 1) * n + move(2);
                A(index, targetIndex) = 1;
            end
        end
    end
end

function moves = knightMoves(row, col, n)
    % Knight move offsets
    offsets = [-2 -1; -2 1; -1 -2; -1 2; 1 -2; 1 2; 2 -1; 2 1];
    moves = [];
    % Generate all valid moves
    for i = 1:size(offsets, 1)
        newRow = row + offsets(i, 1);
        newCol = col + offsets(i, 2);
        if newRow >= 1 && newRow <= n && newCol >= 1 && newCol <= n
            moves = [moves; newRow, newCol];
        end
    end
end

function [maxMoves, farthestIndices] = calculateMoves(A, n)
    distances = inf(n^2, 1); % Initialize distances with infinity
    distances((2-1)*n+1) = 0; % Distance from b1 to itself is 0
    queue = [(2-1)*n+1]; % Start with b1
    while ~isempty(queue)
        current = queue(1);
        queue(1) = []; % Dequeue
        for next = find(A(current, :))
            if distances(next) == inf
                distances(next) = distances(current) + 1;
                queue(end+1) = next; % Enqueue
            end
        end
    end
    maxMoves = max(distances); % Maximum distance from b1
    farthestIndices = find(distances == maxMoves); % Indices of farthest squares
end

function printFarthestSquares(farthestIndices, n)
    positions = {'a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1', ...
                 'a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2', ...
                 'a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3', ...
                 'a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4', ...
                 'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5', ...
                 'a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6', ...
                 'a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7', ...
                 'a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8'};
    if isempty(farthestIndices)
        fprintf('No squares are the farthest.\n');
    else
        for i = farthestIndices'
            [row, col] = ind2sub([n, n], i);
            fprintf('%s ', positions{(row-1)*n + col}); % Corrected to use the accurate index for positions mapping
        end
        fprintf('\n');
    end
end
