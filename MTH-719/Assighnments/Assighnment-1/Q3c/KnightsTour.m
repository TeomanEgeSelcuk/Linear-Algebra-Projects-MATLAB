%% C

%% Output 

%{
>> KnightsTour
Complete tour found:
    30    59    42    47    28    15     6    63
    43    48    29    60     7    62    27    14
    58    31    44    41    46    25    16     5
    49    34    39    24    61     8    13    26
    38    57    32    45    40    21     4    17
    33    50    35    54    23    18     9    12
    56    37    52     1    20    11    22     3
    51     0    55    36    53     2    19    10
%}

%% Code

startKnightTour(8, 2);

function knightTour = knightTourAll(chessboard, currentPos, moveNum)
% Recursive function to attempt to visit all spots on an 8x8 chessboard

% Define knight's possible moves
moves = [2 1; 1 2; -1 2; -2 1; -2 -1; -1 -2; 1 -2; 2 -1];

% Base case: All spots are visited
if moveNum == 64
    knightTour = chessboard;
    return;
end

% Try all next moves
for i = 1:size(moves, 1)
    newPos = currentPos + moves(i, :);
    if isValid(newPos, chessboard)
        % Mark the new position
        chessboard(newPos(1), newPos(2)) = moveNum;
        % Recurse to the next move
        knightTour = knightTourAll(chessboard, newPos, moveNum + 1);
        if ~isempty(knightTour) % If successful, return the tour
            return;
        end
        % Backtrack if not successful
        chessboard(newPos(1), newPos(2)) = -1;
    end
end

% If no move is possible, return an empty array
knightTour = [];
end

function valid = isValid(pos, chessboard)
% Check if a position is valid (within board and not visited)
valid = pos(1) >= 1 && pos(1) <= 8 && pos(2) >= 1 && pos(2) <= 8 && chessboard(pos(1), pos(2)) == -1;
end

% Main function to start the tour from a given position
function tour = startKnightTour(x, y)
chessboard = -ones(8,8); % Initialize the chessboard
chessboard(x, y) = 0; % Mark the starting position
tour = knightTourAll(chessboard, [x y], 1); % Start the recursive tour
if isempty(tour)
    disp('No complete tour found.');
else
    disp('Complete tour found:');
    disp(tour);
end
end

