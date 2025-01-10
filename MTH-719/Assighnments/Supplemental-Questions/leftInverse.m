%{
This function uses the formula (A’ * A)^-1 * A’ to calculate the left inverse of A.
Note that this formula is valid only when A’ * A is invertible, which is the case if 
and only if A has full column rank. The function rank(A) returns the rank of A, and
the equality rank(A) == n checks if A has full column rank.

Please note that the function inv(A’*A)*A’ might not be numerically stable for all 
matrices. If you encounter numerical issues, you might want to use the pinv function,
which calculates the Moore-Penrose pseudoinverse of a matrix, which is a generalization
of the concept of inverse to non-square matrices or singular square matrices.

Left Inverse: If A has full column rank, the left inverse B is given by B = (A’ * A)^-1 * A’.
This is because BA = I_n, and hence B = I_n * A^-1 = (A’ * A)^-1 * A’.
%}


function B = leftInverse(A)
    [m, n] = size(A);
    if rank(A) == n && m >= n
        B = inv(A' * A) * A';
    else
        B = [];
    end
end

