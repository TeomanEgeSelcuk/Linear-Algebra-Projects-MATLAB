function [Nr, P, Q] = normalForm(A)
% A = [1 0 1/4; 1 0 -1/4; 1 1 3/4; 1 1 5/4]
% Calculations 
[m, n] = size(A);
w = rref([A eye(m)]);
Nr = w(:, 1:n);
P = w(:,n+1:m+n);
w = rref([Nr' eye(n)]);
Q = w(:,m+1:m+n)';

