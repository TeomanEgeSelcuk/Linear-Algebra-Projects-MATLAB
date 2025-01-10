function [trivialSolution, nontrivialSolution] = helper_TrivialandNonTrivialSolutions(A)
    % Find the RREF of the augmented matrix A
    [R, pivotCols] = rref(A);
    numRows = size(A, 1);
    numCols = size(A, 2) - 1; % Exclude the last column for solution space

    % Trivial Solution: Always the zero vector for the homogeneous part
    trivialSolution = zeros(numCols, 1);

    % Nontrivial Solution: Initialize as empty; will be computed if possible
    nontrivialSolution = [];

    % Check if there are free variables
    freeVars = setdiff(1:numCols, pivotCols);
    if ~isempty(freeVars)
        % Initialize nontrivial solution as zero vector
        nontrivialSolution = zeros(numCols, 1);
        
        % Set the first free variable to 1 (as an example)
        nontrivialSolution(freeVars(1)) = 1;

        % Compute values for pivot variables based on the free variable
        for i = 1:length(pivotCols)
            row = find(R(:, pivotCols(i)), 1); % Find the row with the pivot
            if ~isempty(row)
                % Subtract the contributions of free variables from the constant term
                nontrivialSolution(pivotCols(i)) = R(row, end) - sum(R(row, freeVars) .* nontrivialSolution(freeVars)');
            end
        end
    end

    % Display Solutions
    disp('');
    disp('');
    disp('Trivial Solution:');
    disp(trivialSolution);

    if ~isempty(nontrivialSolution)
        disp('Nontrivial Solution (example):');
        disp(nontrivialSolution);
    else
        disp('No nontrivial solution found.');
    end
end
