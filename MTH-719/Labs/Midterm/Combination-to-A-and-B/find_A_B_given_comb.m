function [A, B] = find_A_B_given_comb(x_vectors, dimensions, X0, shouldPrint)
    % Determine the maximum vector length from x_vectors
    maxVectorLength = max(structfun(@(v) numel(v), x_vectors));
    
    % Adjust the number of rows in A to accommodate the longest vector
    if maxVectorLength > dimensions(1)
        dimensions(1) = maxVectorLength;
    end
    
    % Initialize A with adjusted dimensions
    A = zeros(dimensions);
    
    % Extracting vectors and placing them into the matrix A
    vectorFields = fieldnames(x_vectors);
    for i = 1:length(vectorFields)
        vector = x_vectors.(vectorFields{i});
        colIndex = str2double(extractAfter(vectorFields{i}, 'x'));
        if numel(vector) <= dimensions(1)
            A(1:numel(vector), colIndex) = vector;
        else
            error('Vector length exceeds the number of rows in A.');
        end
    end
    
    % Dynamically identify basic columns if not covered by x_vectors
    % This part is simplified for demonstration and might need adjustment for complex scenarios
    % Assuming non-covered columns should form part of an identity matrix for basic columns
    nonCoveredCols = setdiff(1:dimensions(2), str2double(extractAfter(vectorFields, 'x')));
    for i = nonCoveredCols
        if i <= dimensions(1)
            A(i,i) = 1;  % Setting identity matrix elements for basic columns
        end
    end

    % Compute B based on X0 if provided, otherwise initialize as zeros
    if exist('X0', 'var') && ~isempty(X0)
        B = A * X0;
    else
        B = zeros(dimensions(1), 1);
    end

    % Optionally print A and B
    if exist('shouldPrint', 'var') && shouldPrint
        disp('Matrix A:');
        disp(A);
        disp('Matrix B:');
        disp(B);
    end
end
