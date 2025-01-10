function isOrthogonal = isMatrixOrthogonal(A)
    % Check if the input matrix is square
    [rows, cols] = size(A);
    if rows ~= cols
        error('Input matrix must be square to check for orthogonality.');
    end

    % Calculate the transpose and the inverse of the matrix
    A_transpose = A';
    A_inverse = inv(A);

    % Check if the transpose is equal to the inverse
    isOrthogonal = isequal(A_transpose, A_inverse);

    % Display a message based on the result
    if isOrthogonal
        disp('Matrix is orthogonal.');
    else
        disp('Matrix is not orthogonal.');
    end
end
