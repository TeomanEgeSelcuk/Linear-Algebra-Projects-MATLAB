function X_0 = calculateInitialDistribution(X_1, M, verbose)
    % Calculate the initial distribution based on the final distribution and a matrix
    % Parameters:
    % X_1 - Final state vector representing the distribution of entities in states
    % M - Stochastic matrix representing probabilities of moving between states
    % verbose - A boolean to control the verbosity of the output (default is true)

    if nargin < 3
        verbose = true;  % Set default verbose to true if not specified
    end

    % Calculate the pseudoinverse of the matrix M
    M_inv = inv(M);

    % Calculate the initial distribution using the pseudoinverse of M
    X_0 = M_inv * X_1;

    % Display the process if verbose is true
    if verbose
        fprintf('\nCalculating the initial distribution from the final distribution...\n');
        fprintf('Stochastic matrix M:\n');
        disp(M);
        fprintf('Inverse of matrix M (M_inv):\n');
        disp(mat2str(M_inv));  % Use mat2str if inline display within text is needed
        fprintf('Final distribution X_1:\n');
        disp(X_1);
        fprintf('Calculated initial distribution X_0 (M_inv * X_1):\n');
        disp(X_0);
    end
end
