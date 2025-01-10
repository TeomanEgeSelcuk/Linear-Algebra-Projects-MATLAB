%% C

N = 8;
knightPos = [1, 1];
targetPos = [1, 8];
minSteps = minStepToReachTargetWithVisualization(knightPos, targetPos, N);

function minSteps = minStepToReachTargetWithVisualization(knightPos, targetPos, N)
    % Initialize variables
    dx = [-2, -1, 1, 2, -2, -1, 1, 2];
    dy = [-1, -2, -2, -1, 1, 2, 2, 1];
    q = {};
    visit = false(N, N);
    pred = zeros(N, N, 2); % To store predecessors for backtracking
    stepsMatrix = zeros(N, N); % Matrix to store steps numbers

    % Starting position
    q{end+1} = {knightPos(1), knightPos(2), 0};
    visit(knightPos(1), knightPos(2)) = true;

    % BFS to find minimum steps
    while ~isempty(q)
        t = q{1};
        q(1) = []; % Dequeue

        % If target is reached
        if t{1} == targetPos(1) && t{2} == targetPos(2)
            minSteps = t{3};
            break;
        end

        % Explore all possible moves
        for i = 1:8
            x = t{1} + dx(i);
            y = t{2} + dy(i);

            % Check if new position is inside the board and not visited
            if isInside(x, y, N) && ~visit(x, y)
                visit(x, y) = true;
                pred(x, y, :) = [t{1}, t{2}]; % Store predecessor
                q{end+1} = {x, y, t{3} + 1}; % Enqueue
            end
        end
    end

    % Backtrack to find path and mark steps
    x = targetPos(1);
    y = targetPos(2);
    step = minSteps;
    while step > 0
        stepsMatrix(x, y) = step;
        newX = pred(x, y, 1);
        newY = pred(x, y, 2);
        x = newX;
        y = newY;
        step = step - 1;
    end

    % Visualize the path with steps
    visualizeChessboard(stepsMatrix, knightPos, targetPos, minSteps, N);
    
    % Ensure minSteps is returned
    if ~exist('minSteps', 'var')
        minSteps = NaN; % Return NaN if the path was not found
    end
end

function inside = isInside(x, y, N)
    inside = (x >= 1 && x <= N && y >= 1 && y <= N);
end

function visualizeChessboard(stepsMatrix, knightPos, targetPos, minSteps, N)
    disp('Chessboard Path Visualization:');
    for i = 1:N
        for j = 1:N
            if i == knightPos(1) && j == knightPos(2)
                fprintf('P '); % Knight's position
            elseif i == targetPos(1) && j == targetPos(2)
                fprintf('X '); % Target position
            elseif stepsMatrix(i, j) > 0
                fprintf('%d ', stepsMatrix(i, j)); % Step number
            else
                fprintf('0 '); % Unvisited positions
            end
        end
        fprintf('\n');
    end
    % Display the minimum steps required after the visualization
    fprintf('Minimum number of steps: %d\n', minSteps);
end
