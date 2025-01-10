%% Q4b

function P = divDiffPoly(X, Y)
    D = dividedDifference(X); % Innvertible upper triangle matrix 
    Y_column = reshape(Y, length(Y), 1); % Reshape Y to be a column vector
    P = D\Y_column; % Solve system of equations to get the coefficients
end
