%% Q4c

% Generate a random positive integer for n
n = randi([1, 100]); % Generates a random integer between 1 and 100

X = 1:n; % Example: 1 to n, ensure these are the x-values for which you want to generate D

% Call the dividedDifference function to generate D
D = dividedDifference(X);

% Calculate the rank of D
rankD = rank(D);

% Display the rank
disp(['The value for n is ', num2str(n)]);
disp(['The rank of D is ', num2str(rankD)]);

