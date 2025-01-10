B = rand(10);
A = B*B';
lambda = eig(A);
[V D] = eig(A);

A =[3  -3  5;-1 4  -4;-1 2  -2];

[P, D] = eig(A);
imag(D);
D = real(D);
P = real(P);

a = 1/3; b = 1/4; c = 1/5;

M = [a a 0 a 0 0 0 0 0;
     b b b 0 b 0 0 0 0
     0 a a 0 0 a 0 0 0
     b 0 0 b b 0 b 0 0
     0 c 0 c c c 0 c 0
     0 0 b 0 b b 0 0 b
     0 0 0 a 0 0 a a 0
     0 0 0 0 b 0 b b b
     0 0 0 0 0 a 0 a a]';

[P D] = eig(M);
sigma = diag(D)';
q = P(:,2);
q = q/sum(q);
M*q - q;