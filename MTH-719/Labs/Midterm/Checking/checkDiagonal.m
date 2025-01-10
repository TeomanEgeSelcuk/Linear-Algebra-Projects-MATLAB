% Function to check if a matrix is diagonal
function isDiagonal = checkDiagonal(A)
    isDiagonal = isequal(A, diag(diag(A)));
end
