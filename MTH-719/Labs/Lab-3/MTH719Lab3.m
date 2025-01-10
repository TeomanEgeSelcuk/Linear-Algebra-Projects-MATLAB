X = 1:4

Y = [3 1 2 1]'

V = fliplr(vander(X))

A = V\Y

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = 1:4

V = fliplr(vander(X))

V = V(1:3,:)

Y = [1 1 7]';

R = rref([V Y])
