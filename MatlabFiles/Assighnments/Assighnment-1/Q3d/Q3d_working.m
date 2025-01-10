function mainScript()
    clc; clear;

    % Load the knight matrix from Q3a.mat
    load('Q3a.mat', 'knight');

    % Define the chessboard positions mapping
    positions = {'a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1', ...
                 'a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2', ...
                 'a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3', ...
                 'a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4', ...
                 'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5', ...
                 'a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6', ...
                 'a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7', ...
                 'a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8'};

    % Number of moves to check (upper bound)
    maxMoves = 6;

    % Initialize matrices to store reachability and minimum moves
    reachability = zeros(size(knight)); % Not used in this adjusted example
    minMovesFromB1 = inf(1, 64); % Use Inf to indicate initially unreachable

    % Print the knight adjacency matrix in condensed form
    fprintf('Knight adjacency matrix:\n');
    printCondensedMatrix(knight, 'knight');

    for n = 1:maxMoves
        % Compute the nth power of the adjacency matrix
        knightN = knight^n;

        % Print the current power matrix in condensed form
        fprintf('Knight matrix to the power of %d:\n', n);
        printCondensedMatrix(knightN, sprintf('knight^%d', n));

        % Initialize counter for newly reachable squares
        newlyReachableCount = 0;

        % Update reachability from "b1" (2nd row of knight matrix)
        for i = 1:64
            if knightN(2, i) > 0 && isinf(minMovesFromB1(i))
                minMovesFromB1(i) = n; % Update if this square is now reachable
                newlyReachableCount = newlyReachableCount + 1; % Increment count
                % Print the update for this square
                fprintf('Square %s becomes reachable in %d moves.\n', positions{i}, n);
            end
        end

        % Calculate and print the count of squares not reachable after this power iteration
        notReachableCount = 64 - newlyReachableCount;
        fprintf('Count of squares not reachable after %d moves: %d\n', n, notReachableCount);

    end

    % Identify the maximum distance and corresponding squares
    maxDistance = max(minMovesFromB1);
    farthestSquaresIndices = find(minMovesFromB1 == maxDistance);

    % Printing final results
    fprintf('\nMaximum distance from b1: %d moves.\n', maxDistance);
    fprintf('Squares farthest from b1: ');
    for index = farthestSquaresIndices
        fprintf('%s ', positions{index});
    end
    fprintf('\n');

    % Print the minMovesFromB1 matrix in condensed form for detailed analysis
    fprintf('Minimum moves from b1 to each square:\n');
    printCondensedMatrix(reshape(minMovesFromB1, 8, 8), 'minMovesFromB1');
end

function printCondensedMatrix(M, name)
    fprintf('%s =\n', name);
    [rows, cols] = size(M);
    if rows > 4 && cols > 4
        for i = 1:min(4,rows)
            for j = 1:min(4,cols)
                fprintf('%g ', M(i,j));
            end
            if cols > 4
                fprintf('... ');
            end
            if i <= 4
                fprintf('%g ', M(i,end));
            end
            fprintf('\n');
        end
        fprintf('... \n');
        for j = 1:min(4,cols)
            fprintf('%g ', M(end,j));
        end
        if cols > 4
            fprintf('... ');
        end
        fprintf('%g\n', M(end,end));
    else
        disp(M);
    end
end
