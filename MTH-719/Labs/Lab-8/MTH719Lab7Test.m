clear
clc

% Sample input data
A = [1 -2 0 -3 5 3; -1 2 0 3 -1 -1; 1 0 2 -1 1 0; -3 2 -4 5 2 2; -3 1 -5 4 1 2];
P = [1 1 1 1; 0 1 1 1; 0 0 1 1; 0 0 0 1];
v = [21; -7; 8; -5; -9];

% Expected values provided
A1 = [5; 1; 3; 1];
A2 = [10; 5; 4; 1];
B1 = [1, -2, 5, 3;
     -1, 2, -1, -1;
      1, 0, 1, 0;
     -3, 2, 2, 2;
     -3, 1, 1, 2];
B2 = [1, -3, 7, -2;
     -1, 3, -3, 0;
      1, -1, 1, -1;
     -3, 5, 0, 0;
     -3, 4, 0, 1];

% Execute the function with sample data
[basis1, basis2, alpha1, alpha2] = change_of_basis(A, P, v, false);

tol = 1e-7;
Total =[0 0 0 0];

varname = exist('basis1','var');
if varname
    if size(basis1) == size(B1)
        if norm(basis1-B1) < tol
            Total(1) = 1;
        end
    end
end

varname = exist('basis2','var');
if varname
    if size(basis2) == size(B2)
        if norm(basis2-B2) < tol
            Total(2) = 1;
        end
    end
end

varname = exist('alpha1','var');
if varname
    if size(alpha1) == size(A1)
        if norm(alpha1-A1) < tol
            Total(3) = 1;
        end
    end
end

varname = exist('alpha2','var');
if varname
    if size(alpha2) == size(A2)
        if norm(alpha2-A2) < tol
            Total(4) = 1;
        end
    end
end

Total