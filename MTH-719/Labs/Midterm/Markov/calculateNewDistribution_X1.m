function X_1 = calculateNewDistribution_X1(X_0, M, n, verbose)
    % calculateNewDistribution_X1 Calculates the new distribution after n iterations
    % Parameters:
    % X_0 - Initial state vector representing the distribution of entities.
    % M - Stochastic matrix representing probabilities of moving between states.
    % n - The number of iterations (time steps) to apply the matrix M.
    % verbose - A boolean to control the verbosity of the output (default true).
    
    % Set default for verbose if not provided
    if nargin < 4
        verbose = true;  % Default to true if not specified
    end

    % Calculate the new distribution after n iterations
    Mn = M^n;  % Raise the matrix to the nth power
    X_1 = Mn * X_0;  % Compute the new distribution

    % Display detailed results if verbose is true
    if verbose
        fprintf('\nCalculating the new distribution after %d iterations...\n', n);
        fprintf('Stochastic matrix M raised to the power %d:\n', n);
        disp(mat2str(Mn));  % Use mat2str for inline matrix display if needed
        fprintf('Initial distribution X_0:\n');
        disp(X_0);
        fprintf('New distribution X_1 = M^n * X_0:\n');
        disp(X_1);
    end
end
