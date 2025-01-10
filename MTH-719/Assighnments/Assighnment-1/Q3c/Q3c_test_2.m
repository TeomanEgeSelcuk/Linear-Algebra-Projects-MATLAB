clc; clear;

% Main script execution part
disp('Testing reachability from b1:');
knightReachabilityAll('b1');

disp('Testing reachability from all starting positions:');
testAllStartingPositions();

% Function to test reachability from all starting positions
function testAllStartingPositions()
    positions = {'a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1', ...
                 'a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2', ...
                 'a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3', ...
                 'a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4', ...
                 'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5', ...
                 'a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6', ...
                 'a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7', ...
                 'a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8'};
    tourResults = cell(length(positions), 2);

    for i = 1:length(positions)
        [lastIteration, ~, ~] = knightReachabilityAll(positions{i});
        tourResults{i, 1} = positions{i};
        if lastIteration < 64 % If not all positions become reachable
            tourResults{i, 2} = 'Does not complete Tour';
        else
            tourResults{i, 2} = 'Completes Tour';
        end
    end

    % Convert the results to a table for better readability
    tourResultsTable = cell2table(tourResults, 'VariableNames', {'Tour Completion', 'Starting Position'});
    disp(tourResultsTable);
end

% Function to test knight reachability from a given starting position
function [lastIteration, unreachableCounts, unreachablePositionsList] = knightReachabilityAll(startPos)
    positions = {'a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1', ...
                 'a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2', ...
                 'a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3', ...
                 'a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4', ...
                 'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5', ...
                 'a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6', ...
                 'a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7', ...
                 'a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8'};
    N = 8;
    M = zeros(N^2, N^2);
    moves = [-2 -1; -2 1; -1 -2; -1 2; 1 -2; 1 2; 2 -1; 2 1];

    for row = 1:N
        for col = 1:N
            currentIndex = (row-1) * N + col;
            for k = 1:size(moves, 1)
                newRow = row + moves(k, 1);
                newCol = col + moves(k, 2);
                if newRow >= 1 && newRow <= N && newCol >= 1 && newCol <= N
                    newIndex = (newRow-1) * N + newCol;
                    M(currentIndex, newIndex) = 1;
                end
            end
        end
    end

    startPosIndex = find(strcmp(positions, startPos));
    R = M;
    lastIteration = N^2;
    unreachableCounts = zeros(N^2, 1);
    unreachablePositionsList = cell(N^2, 1);

    for i = 1:N^2
        R = R | (R^i > 0);
        R(R > 0) = 1;
        unreachableCounts(i) = sum(~R(startPosIndex, :));
        if strcmp(startPos, 'b1') && i <= 3 % Corrected comparison
            if unreachableCounts(i) > 0
                unreachablePositions = positions(~R(startPosIndex, :));
                unreachablePositionsList{i} = strjoin(unreachablePositions, ', ');
            else
                unreachablePositionsList{i} = '{}'; % No unreachable positions
            end
        elseif unreachableCounts(i) == 0
            lastIteration = i;
            break;
        end
    end

    if strcmp(startPos, 'b1') % Special display case for b1
        T = table((1:lastIteration)', unreachableCounts(1:lastIteration), unreachablePositionsList(1:lastIteration), ...
                  'VariableNames', {'M^i', 'Unreachable Count', 'Unreachable Positions'});
        disp(T);
    else
        % This part is for all starting positions. You can adjust as needed.
    end
end
