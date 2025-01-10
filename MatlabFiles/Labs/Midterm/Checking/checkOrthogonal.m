% Function to check if a matrix is orthogonal
function isOrthogonal = checkOrthogonal(A)
    isOrthogonal = isequal(A'*A, eye(size(A)));
end