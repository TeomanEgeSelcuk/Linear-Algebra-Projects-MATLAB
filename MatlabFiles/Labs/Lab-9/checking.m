% Load the matrix Q from the previous function
Q = [-0.2299   -0.8779    0.1264   -0.4006
   -0.1764    0.3812    0.7613   -0.4939
    0.7592   -0.2658    0.5085    0.3073
   -0.5828   -0.1154    0.3820    0.7079];

% Q = [   -0.1264   -0.4006
%    -0.7613   -0.4939
%    -0.5085    0.3073
%    -0.3820    0.7079];

% Load the matrix A from the previous function
A = [1 1 -4 3
     1 0 -1 1
     -1 0 1 -1
     -1 -1 4 -3];

% Check if Q is orthogonal
isQOrthogonal = isequal(Q'*Q, eye(size(Q,1)));

% Check if the first two columns of Q form a basis for the right null space of A
isNullBasis = all(A * Q(:,1:2) == zeros(size(A,1),2));

% Check the output from the QR factorization
[Q_check, R_check] = qr(Q, 0);
isQRCorrect = isequal(Q, Q_check) && isequal(R_check, triu(R_check)) && isequal(Q*R_check, Q);

% Print the results
fprintf('Is Q orthogonal: %d\n', isQOrthogonal);
fprintf('Do the first two columns of Q form a basis for the right null space of A: %d\n', isNullBasis);
fprintf('Is the output from the QR factorization correct: %d\n', isQRCorrect);
