clc; clear;

knightReachabilityModified('b1');

function knightReachabilityModified(startPos)
    % Convert chessboard notation to a cell array of strings for easier comparison
    positions = {'a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8', ...
                 'a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7', ...
                 'a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6', ...
                 'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5', ...
                 'a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4', ...
                 'a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3', ...
                 'a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2', ...
                 'a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1'};

    startPosIndex = find(strcmp(positions, startPos));

    % Define the size of the chessboard
    N = 8;

    % Initialize the adjacency matrix for N^2 vertices
    M = zeros(N^2, N^2);

    % Define all possible knight moves
    moves = [-2 -1; -2 1; -1 -2; -1 2; 1 -2; 1 2; 2 -1; 2 1];

    % Fill in the adjacency matrix based on knight moves
    for row = 1:N
        for col = 1:N
            currentIndex = (row-1) * N + col;
            for k = 1:size(moves, 1)
                newRow = row + moves(k, 1);
                newCol = col + moves(k, 2);
                if newRow >= 1 && newRow <= N && newCol >= 1 && newCol <= N
                    newIndex = (newRow-1) * N + newCol;
                    M(currentIndex, newIndex) = 1;
                end
            end
        end
    end

    % Compute the reachability matrix iteratively and track unreachable positions
    R = M;
    unreachableCounts = zeros(N^2, 1);
    unreachablePositionsList = cell(N^2, 1);
    matricesAfterEachIteration = cell(N^2, 1); % To store matrices after each iteration
    
    lastIteration = N^2; % Initialize with max possible iterations
    for i = 1:N^2
        R = R | (R^i > 0); % Update reachability based on matrix powers
        R(R > 0) = 1; % Ensure the matrix is binary
        unreachableCounts(i) = sum(~R(startPosIndex, :));
        unreachablePositions = positions(~R(startPosIndex, :));
        unreachablePositionsList{i} = strjoin(unreachablePositions, ', ');
        
        matricesAfterEachIteration{i} = R; % Store the matrix after the current iteration
        
        if unreachableCounts(i) == 0
            lastIteration = i; % Update the last iteration when no positions are unreachable
            break; % Stop iterating as all positions become reachable
        end
    end

    % Trim the arrays to contain only the relevant entries up to the last iteration
    unreachableCounts = unreachableCounts(1:lastIteration);
    unreachablePositionsList = unreachablePositionsList(1:lastIteration);
    matricesAfterEachIteration = matricesAfterEachIteration(1:lastIteration);

    % Display the results in a table
    T = table((1:lastIteration)', unreachableCounts, unreachablePositionsList, 'VariableNames', {'M^i', 'Unreachable Count', 'Unreachable Positions'});
    disp(T);
    
    % Print the matrices after each iteration
    for i = 1:lastIteration
        fprintf('\nReachability Matrix after M^%d:\n', i);
        disp(matricesAfterEachIteration{i});
    end
end
