function x = basisTest(A, B)
tol = 1e-10;

if size(A) == size(B)
    if rank([B A],tol) == rank(B)
        if rank(B) == rank(A)
            x = 1;
        else
            x = 0;
        end
    else
        x = 0;
    end
else
    x = 0;
end