
% Function to check if a matrix is symmetric
function isSymmetric = checkSymmetric(A)
    isSymmetric = isequal(A, A');
end