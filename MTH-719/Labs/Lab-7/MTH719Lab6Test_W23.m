clear
clc

Total = [0 0 0 0];

load('Quiz6')

load('MTH719Quiz6Data.mat')
[m, n] = size(A);
r = rank(A);
[Ea, p] = rref(A);
P = rref([A eye(m)]);
P = P(:,n+1:n+m);
Q = rref([Ea' eye(n)]);
Q = Q(:,m+1:n+m)';

% Testing the Column Space
B = A(:,p);

varname = exist('ColA','var');
if varname
    Total(1) = basisTest(ColA,B);
end

% Testing the Row Space
B = Ea(1:r,:)';

varname = exist('RowA','var');
if varname
    Total(2) = basisTest(RowA,B);
end

% Testing the Null Space
B = Q(:,r+1:n);

varname = exist('RnullA','var');
if varname
    Total(3) = basisTest(RnullA,B);
end
% Testing the left Null Space
B = double.empty(6,0); % The left null space is empty

varname = exist('LnullA','var');
if varname
    Total(4) = basisTest(LnullA,B);
end
Total