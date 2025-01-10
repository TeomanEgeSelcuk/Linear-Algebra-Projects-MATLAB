% Function to check if a matrix is orthonormal
function isOrthonormal = checkOrthonormal(A)
    isOrthonormal = isequal(A'*A, eye(size(A))) && isequal(A*A', eye(size(A)));
end