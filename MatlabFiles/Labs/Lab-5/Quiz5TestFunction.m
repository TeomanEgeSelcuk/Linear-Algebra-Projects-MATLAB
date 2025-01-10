% Quiz 5 testing function
clear;
clc;

score = 0;
A = rand(5,7);
A(5,:) = 3*A(4,:) - 7*A(2,:);

try
    [P , Q] = normalForm(A);
catch
    warning('Function not executing correctly')
    return
end

N = [eye(4) zeros(4,3); zeros(1,7)];

try
    [a , b] = size(P);
catch
    warning('Variable P not correct')
    a = 1; b = 2;
end

if a == b && a == 5
    score = score + 1;
end

try
    [a , b] = size(Q);
catch
    warning('Variable Q not correct')
    a = 1; b = 2;
end

if a == b && a == 7
    score = score + 1;
end

try
    l = norm(P*A*Q-N);
catch
    warning('P*A*Q not correct')
    l = 1;
end

if l < 1e-8
    score = score + 2;
end

score