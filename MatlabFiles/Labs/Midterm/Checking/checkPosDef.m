% Function to check if a matrix is positive definite
function isPosDef = checkPosDef(A)
    isPosDef = isequal(A, A') && all(eig(A) > 0);
end