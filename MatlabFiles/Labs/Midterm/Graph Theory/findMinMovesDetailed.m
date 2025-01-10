function minMoves = findMinMovesDetailed(startPos, endPos, M, verbose)
    % Set verbose to true if not provided
    if nargin < 4
        verbose = true;
    end
    
    % Calculate the length of the columns of M
    N = size(M, 2);
    
    % Display initial message if verbose is true
    if verbose
        fprintf('The adjacency matrix M represents all possible one-move.\n\n');
    end

    % Searching for the minimum number of moves using matrix powers
    minMoves = 0;
    M_power = M; % Initialize M_power as M to start with M^1
    if verbose
        fprintf('2. Computing successive powers of M to find the minimum number of moves...\n\n');
    end
    
    while minMoves <= N
        % Check if a path exists in the current power of M
        if M_power(startPos(1), startPos(2)) > 0
            if verbose
                fprintf('At M^%d, entry (%d, %d) > 0 indicates a path exists using %d moves.\n', minMoves + 1, startPos(1), startPos(2), minMoves + 1);
                fprintf('Found a path using %d moves.\n', minMoves + 1);
                fprintf('This means there exists at least one path from the start position to the target position using exactly %d moves.\n\n', minMoves + 1);
            end
            break;
        end
        minMoves = minMoves + 1;
        M_power = M_power * M; % Compute the next power of M
        
        % Optionally, print the current power of M to show the paths
        if verbose && minMoves <= 3 % Limit printing to first few powers for brevity
            fprintf('Matrix M^%d (paths of %d moves):\n', minMoves + 1, minMoves + 1);
            % disp(M_power);
        end
    end

    if minMoves > N
        minMoves = -1; % Indicate no path found if we exceed N^2 iterations
        if verbose
            fprintf('No path found within the limit. The positions might be unreachable.\n');
        end
    else
        if verbose
            fprintf('Minimum number of moves required from (%d, %d) to (%d, %d): %d\n', startPos(1), startPos(2), endPos(1), endPos(2), minMoves + 1);
        end
    end
end
