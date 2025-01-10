function X = steadystateGabe(p,q)
M = [p 1-q ; 1-p q];
[P D] = eig(M);
X=P * D^10000 * inv(P) * [1 0]'
end