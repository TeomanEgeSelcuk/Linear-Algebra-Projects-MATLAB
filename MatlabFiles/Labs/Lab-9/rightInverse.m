%{
 function checks if the rank of A is equal to the number of its rows, 
which indicates that A has full row rank and hence a right inverse exists.
 It then calculates the right inverse using the formula (A' * A)^-1 * A'.
 If A doesn’t have a right inverse, the function returns an empty matrix.
%}

function B = rightInverse(A)
    % check if A has a right inverse
    if rank(A) == size(A, 1)
        % if it does, calculate the right inverse
        B = inv(A' * A) * A';
    else
        % if it doesn't, return an empty matrix
        B = [];
    end
end

