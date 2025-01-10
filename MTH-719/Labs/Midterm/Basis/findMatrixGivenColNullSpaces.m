function [result, rank_A] = findMatrixGivenColNullSpaces(col_space, null_space, verbose)
    % Set default value for verbose if not provided
    if nargin < 3
        verbose = true;
    end

    % Calculate the rank of the column space
    rank_col_space = rank(col_space);

    % Calculate the size of the matrices
    n = size(col_space, 1);  % Number of rows in col_space
    r = rank_col_space;  % Rank of column space

    % Construct matrix P
    P = [col_space, flipud(eye(n,n - r))];  % Construct P with correct dimensions

    % Construct matrix Q
    Q = [eye(n,n - r), null_space];  % Construct Q with correct dimensions

    % Compute the inverse of Q
    Q_inv = inv(Q);  % Inverse of matrix Q

    % Compute the matrices Nr, A, and A_tilde
    Nr = [eye(n,n - r), zeros(n,n - r)];  % Matrix multiplication logic
    A_tilde = Nr * Q_inv;  % Calculate A_tilde
    A = P * A_tilde;  % Final result for A

    % Verify the rank of A
    rank_A = rank(A);  % Calculate the rank of matrix A

    % Verify that A[N(A)] = 0
    null_A = null(A);  % Get null space of matrix A
    result = A * null_A;  % Compute A multiplied by null_A

    % Check if the result is small enough to round to zero
    if max(abs(result(:))) < 10^-7
        result = zeros(size(result));  % Round to zero if values are very small
    end

    % Provide verbose output with detailed formulas
    if verbose
        fprintf('Calculating matrix P with rank r = %d and size n = %d:\n', r, n);
        fprintf('General formula for P: P = [col_space, flipud(eye(n - r))]\n');
        fprintf('Substituting values, it becomes P = [col_space, flipud(eye(%d - %d))]\n', n, r);
        fprintf('P = [');
        disp(P);

        fprintf('Constructing matrix Q:\n');
        fprintf('General formula for Q: Q = [eye(n - r), null_space]\n');
        fprintf('Substituting values, it becomes Q = [eye(%d - %d), null_space]\n', n, r);
        disp(Q);

        fprintf('Inverse of matrix Q:\n');
        fprintf('Q_inv = inv(Q)\n');
        disp(Q_inv);

        fprintf('Construction of Nr:\n');
        fprintf('General formula for Nr: Nr = [eye(n - r), zeros(n - r)]\n');
        fprintf('Substituting values, it becomes Nr = [eye(%d - %d), zeros(%d - %d)]\n', n, r, n, r);
        disp(Nr);

        fprintf('Construction of A_tilde:\n');
        fprintf('General formula for A_tilde: Nr * Q_inv\n');
        disp(A_tilde);

        fprintf('Final construction of A:\n');
        fprintf('General formula for A: P * A_tilde\n');
        disp(A);

        fprintf('Rank of matrix A: %d\n', rank_A);

        fprintf('Verifying that A multiplied by null(A) is approximately zero:\n');
        disp(result);
    end

end
