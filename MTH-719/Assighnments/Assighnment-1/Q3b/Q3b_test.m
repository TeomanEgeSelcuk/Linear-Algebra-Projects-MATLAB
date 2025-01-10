knightPos = [8, 2];
targetPos = [8, 3];
minMoves = findMinKnightMovesDetailed(knightPos, targetPos);

function minMoves = findMinKnightMovesDetailed(startPos, endPos)
    % Define the size of the chessboard
    N = 8;

    fprintf('1. Constructing the adjacency matrix M for the 8x8 chessboard...\n\n');

    % Convert the 2D board positions to single indices
    startPosIndex = (startPos(1)-1) * N + startPos(2);
    endPosIndex = (endPos(1)-1) * N + endPos(2);

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
                    M(currentIndex, newIndex) = 1; % Mark legal move
                end
            end
        end
    end

    fprintf('The adjacency matrix M represents all possible one-move knight paths.\n\n');
    disp(M); % Display the initial adjacency matrix M

    % Searching for the minimum number of moves using matrix powers
    minMoves = 0;
    M_power = M; % Initialize M_power as M to start with M^1
    fprintf('2. Computing successive powers of M to find the minimum number of moves...\n\n');
    
    while minMoves <= N^2
        % Check if a path exists in the current power of M
        if M_power(startPosIndex, endPosIndex) > 0
            fprintf('At M^%d, entry (%d, %d) > 0 indicates a path exists using %d moves.\n', minMoves + 1, startPosIndex, endPosIndex, minMoves + 1);
            fprintf('Found a path using %d moves.\n', minMoves + 1);
            fprintf('This means there exists at least one path from the start position to the target position using exactly %d moves.\n\n', minMoves + 1);
            break;
        end
        minMoves = minMoves + 1;
        M_power = M_power * M; % Compute the next power of M
        
        % Optionally, print the current power of M to show the paths
        if minMoves <= 3 % Limit printing to first few powers for brevity
            fprintf('Matrix M^%d (paths of %d moves):\n', minMoves + 1, minMoves + 1);
            disp(M_power);
        end
    end

    if minMoves > N^2
        minMoves = -1; % Indicate no path found if we exceed N^2 iterations
        fprintf('No path found within the limit. The positions might be unreachable.\n');
    else
        fprintf('Minimum number of moves required from (%d, %d) to (%d, %d): %d\n', startPos(1), startPos(2), endPos(1), endPos(2), minMoves + 1);
    end
end
