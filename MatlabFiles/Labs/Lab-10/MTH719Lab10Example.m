% Define the x values as a sequence from 10 to 80 with a step of 10
x = 10:10:80;
% Define the y values corresponding to each x value
y = [25 70 380 550 610 1220 830 1450];
% Generate the Vandermonde matrix for x values
V = vander(x);
% Select the last two columns of V, corresponding to a linear fit
V = V(:,7:8);
% Ensure y is a column vector for matrix operations
Y = y';

% Calculate the polynomial coefficients by explicitly solving the normal equations
% This approach minimizes the sum of squared differences between observed and estimated y values
P1 = (V'*V)\V'*Y; % P1 contains the coefficients for the best fit line

% Calculate the polynomial coefficients using MATLAB's backslash operator
% This is a more straightforward method to achieve the same result as P1
P2 = V\Y; % P2 contains the same coefficients as P1, showing the backslash operator's efficiency

% Perform QR factorization on V, an alternative method for solving linear least squares problems
% QR factorization decomposes V into an orthogonal matrix Q and an upper triangular matrix R
[q, r] = qr(V,0);
% Solve for polynomial coefficients using the R matrix and the transformed Y values (q'*Y)
% This method provides numerical stability advantages
P = r\(q'*Y); % P contains the same coefficients, emphasizing QR factorization's reliability

% Calculate the first form of error as the Euclidean norm (magnitude) of the residuals (difference between observed and fitted Y values)
error1 = norm(Y-V*P); 

% Calculate the second form of error by directly comparing the squared norms of Y and V*P
% This error represents the same value as error1 but is computed differently for validation
error2 = sqrt(norm(Y)^2 - norm(V*P)^2);

% Calculate the third form of error, utilizing the QR decomposition's properties
% This calculates error based on the difference in norms of Y and the projection of Y onto the space spanned by V
error3 = sqrt(norm(Y)^2 - norm(q'*Y)^2);

% Prepare data for plotting
X = 10:.01:80; % Define a finer grid for x values for plotting
% Calculate the fitted Y values across the grid using the polynomial coefficients
Y = P(1)*X+P(2);
% Plot the original data points as circles and the best fit line
plot(x,y,'o',X,Y), grid on
