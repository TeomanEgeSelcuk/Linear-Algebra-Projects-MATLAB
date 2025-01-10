clc; clear;

% Load the knight matrix from Q3a.mat
load('Q3a.mat', 'knight');

% Assuming knight is the adjacency matrix defined above
% Number of moves to check (upper bound)
maxMoves = 6;

% Initialize matrices to store reachability and minimum moves
reachability = zeros(size(knight));
minMovesFromB1 = inf(1, 64); % Use Inf to indicate initially unreachable

for n = 1:maxMoves
    % Compute the nth power of the adjacency matrix
    knightN = knight^n;
    
    % Update reachability from "b1" (2nd row of knight matrix)
    for i = 1:64
        if knightN(2, i) > 0 && isinf(minMovesFromB1(i))
            minMovesFromB1(i) = n; % Update if this square is now reachable
        end
    end
end

% Identify the maximum distance and corresponding squares
maxDistance = max(minMovesFromB1);
farthestSquaresIndices = find(minMovesFromB1 == maxDistance);

% Define the chessboard positions mapping
positions = {'a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1', ...
             'a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2', ...
             'a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3', ...
             'a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4', ...
             'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5', ...
             'a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6', ...
             'a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7', ...
             'a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8'};


% Printing results
fprintf('Maximum distance from b1: %d moves.\n', maxDistance ); % -1 if counting moves from b1
fprintf('Squares farthest from b1: ');
for index = farthestSquaresIndices
    fprintf('%s ', positions{index});
end
fprintf('\n');


