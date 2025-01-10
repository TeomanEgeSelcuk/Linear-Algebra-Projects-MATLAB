%{
 function checks if the rank of A is equal to the number of its rows, 
which indicates that A has full row rank and hence a right inverse exists.
 It then calculates the right inverse using the formula (A' * A)^-1 * A'.
 If A doesn’t have a right inverse, the function returns an empty matrix.

Right Inverse: If A has full row rank, the right inverse B is given by B = A’ * (A * A’)^-1. 
This is because AB = I_m, and hence B = A^-1 * I_m = A’ * (A * A’)^-1.
%}

function B = rightInverse(A)
    [m, n] = size(A);
    if m <= n && rank(A) == m
        B = A' * inv(A * A');
    else
        B = [];
    end
end


