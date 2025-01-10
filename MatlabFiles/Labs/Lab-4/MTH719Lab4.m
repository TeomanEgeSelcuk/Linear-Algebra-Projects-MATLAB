clear
clc

load('MTH719Lab4Example')

w = rref([A eye(4)]);

EA = w(:,1:5)

P = w(:,6:9)

w = rref([EA' eye(5)])

N = w(:,1:4)'

Q = w(:,5:9)'

B = [2 4 9 -1]'

X = [P*B;0]

V1 = Q(:,4)

V2 = Q(:,5)