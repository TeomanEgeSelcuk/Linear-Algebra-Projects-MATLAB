function [P, Q] = normalForm(A)
% Calculations 
[m, n] = size(A);
w = rref([A eye(m)]);
EA = w(:, 1:n);
P = w(:,n+1:m+n);
w = rref([EA' eye(n)]);
Q = w(:,m+1:m+n)';