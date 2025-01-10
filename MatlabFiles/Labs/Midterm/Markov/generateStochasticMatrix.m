function M = generateStochasticMatrix(connections, verbose)
    % generateStochasticMatrix Generates the stochastic matrix from room connections.
    % Parameters:
    % connections - A matrix representing the adjacency of the rooms.
    % verbose - A boolean to control the verbosity of the output.
    % Returns:
    % M - The generated stochastic matrix.
    
    n = size(connections, 1); % Number of rooms
    M = zeros(n); % Initialize the stochastic matrix with zeros
    
    if verbose
        fprintf('Generating stochastic matrix from the room connections...\n');
    end
    
    for i = 1:n
        % Calculate the number of connections for room i
        connectionsCount = sum(connections(i, :));
        if verbose
            fprintf('Room %d has %d connections.\n', i, connectionsCount);
        end
        
        % Set the probabilities for staying or moving to an adjacent room
        M(i, i) = 1 / connectionsCount; % Probability of staying in the same room
        for j = 1:n
            if connections(i, j) == 1
                M(j, i) = 1 / connectionsCount; % Probability of moving to a connected room
                if verbose
                    fprintf('Room %d to Room %d: 1/%d\n', i, j, connectionsCount);
                end
            end
        end
    end
    
    if verbose
        disp('Stochastic Matrix M:');
        disp(M);
    end
end

