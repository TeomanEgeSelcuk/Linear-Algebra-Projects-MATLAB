function q = findSteadyState(M, verbose)
    % findSteadyState Computes the steady state vector for the matrix M.
    % Parameters:
    % M - Stochastic matrix representing probabilities of moving between states.
    % verbose - A boolean to control the verbosity of the output (default is true).

    % Set default value for verbose if not specified
    if nargin < 2
        verbose = true;
    end

    if verbose
        fprintf('To find the steady state vector q, solve the equation M * q = q.\n');
        fprintf('This is equivalent to finding the null space of (M - I), where I is the identity matrix.\n');
    end

    % Calculate (M - I)
    I = eye(size(M));
    A = M - I;

    if verbose
        fprintf('Subtracting the identity matrix I from M:\n');
        disp(mat2str(A));  % Use mat2str to display matrix within text
    end

    % Find the null space of (M - I), which gives us the steady state vector q
    if verbose
        fprintf('Calculating the null space of (M - I) which gives the steady state vector q:\n');
    end
    q = null(A, 'rational');

    if verbose
        fprintf('Resulting steady state vector (before normalization):\n');
        disp(mat2str(q));  % Using mat2str for better integration in the text
    end

    % Normalize q so that the sum is 1 (100%)
    q = q / sum(q);

    if verbose
        fprintf('Normalized steady state vector q (sums to 1) -> q= q/sum(q):\n');
        disp(mat2str(q));  % Display normalized steady state vector
    end
end
