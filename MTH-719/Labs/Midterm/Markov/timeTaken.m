function [timeToTargetState, stateDistribution] = timeTaken(transitionMatrix, initialState, targetIndex, verbose)
    % Calculate the time to reach a specified state in a stochastic system
    % Parameters:
    % transitionMatrix - Transition matrix representing probabilities of moving between states
    % initialState - Initial state vector representing the distribution of entities across states
    % targetIndex - The state index to check for entities
    % verbose - Flag to control output verbosity (default true)

    if nargin < 4
        verbose = true;  % Default to verbose if not specified
    end

    % Ensure initialState is a column vector
    if size(initialState, 2) > 1
        initialState = initialState';  % Convert to column if it's a row vector
    end

    % Validate dimensions
    if size(transitionMatrix, 1) ~= size(transitionMatrix, 2)
        error('Dimension mismatch: Transition matrix must be square.');
    end

    if size(transitionMatrix, 1) ~= length(initialState)
        error('Dimension mismatch: The number of rows in the transition matrix must match the length of the initial state vector.');
    end

    % Display the initial state if verbose
    if verbose
        fprintf('Initial state distribution:\n');
        disp(initialState');
    end

    % Initialize time counter
    timeIntervals = 0;
    currentState = initialState;

    % Loop until entities reach the target state
    while true
        % Increase time counter
        timeIntervals = timeIntervals + 1;
        
        % Calculate distribution after the current number of time intervals
        currentState = transitionMatrix * currentState;
        
        % Displaying the detailed calculation if verbose
        if verbose
            fprintf(['Calculating distribution after %d time interval(s):\n'], timeIntervals);
            fprintf('Current distribution:\n');
            disp(currentState);
        end
        
        % Check if the target state has entities in it
        if currentState(targetIndex) > 0
            timeToTargetState = timeIntervals * 15; % Convert intervals to minutes
            stateDistribution = currentState;
            
            if verbose
                fprintf('Entities have reached state %d after %d time interval(s) (%d minutes).\n', targetIndex, timeIntervals, timeToTargetState);
                fprintf('The distribution of entities across the states is:\n');
                disp(stateDistribution');
            end
            
            break;
        end
    end
end
