function checkInvertibility(A)
    % Check if matrix A is square
    [rows, cols] = size(A);
    if rows ~= cols
        disp('The matrix is not invertible because it is not a square matrix.')
        return
    end

    % Check if the determinant of A is non-zero
    detA = det(A);
    if detA == 0
        disp('The matrix is not invertible because its determinant is zero.')
    else
        disp('The matrix is invertible.')
    end
end
