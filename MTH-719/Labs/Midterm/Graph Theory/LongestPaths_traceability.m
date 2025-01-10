
function maxDistance = LongestPaths_traceability(M, startingPosition, verbose)

    % Number of moves to check (upper bound)
    maxMoves = size(M, 1);

    % Initialize matrices to store reachability and minimum moves
    minMovesFromStart = inf(1, size(M, 1)); % Use Inf to indicate initially unreachable

    % Initialize minimum moves from the starting position
    minMovesFromStart(startingPosition) = 0; 

    for n = 1:maxMoves
        % Compute the nth power of the adjacency matrix
        MN = M^n;

        % Initialize counter for newly reachable squares
        newlyReachableCount = 0;

        % Update reachability from the starting position
        for i = 1:size(M, 1)
            if MN(startingPosition, i) > 0 && isinf(minMovesFromStart(i))
                minMovesFromStart(i) = n; % Update if this square is now reachable
                newlyReachableCount = newlyReachableCount + 1; % Increment count

                % Print the update for this square
                if verbose
                    fprintf('Position %d becomes reachable in %d moves.\n', i, n);
                end
            end
        end

        % Calculate and print the count of positions not reachable after this power iteration
        if verbose
            notReachableCount = size(M, 1) - newlyReachableCount;
            fprintf('Count of positions not reachable after %d moves: %d\n', n, notReachableCount);
        end

    end

    % Identify the maximum distance and corresponding positions
    maxDistance = max(minMovesFromStart);
    farthestPositionsIndices = find(minMovesFromStart == maxDistance);

    % Printing final results
    if verbose
        fprintf('\nMaximum distance from starting position: %d moves.\n', maxDistance);
        fprintf('Positions farthest from the starting position: ');
        disp(farthestPositionsIndices);
    end

end
