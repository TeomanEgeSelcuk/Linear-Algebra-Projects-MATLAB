function movesFromD4 = knightMovesFromD4()
    n = 8; % Chessboard size
    row = 5; % 'd' row
    col = 4; % '4' column
    movesFromD4 = []; % Initialize empty array for moves
    
    % Define knight move offsets
    offsets = [-2, -1; -2, 1; -1, -2; -1, 2; 1, -2; 1, 2; 2, -1; 2, 1];
    
    for k = 1:size(offsets, 1)
        newRow = row + offsets(k, 1);
        newCol = col + offsets(k, 2);
        if newRow >= 1 && newRow <= n && newCol >= 1 && newCol <= n
            % Convert new position to 1D index and add to moves list
            newIdx = (newRow-1)*n + newCol;
            movesFromD4 = [movesFromD4, newIdx];
        end
    end
    
    % Optionally, convert 1D indices back to chess notation for readability
    movesFromD4 = convertToChessNotation(movesFromD4, n);
end

function notation = convertToChessNotation(indices, n)
    notation = cell(1, numel(indices));
    letters = 'abcdefgh';
    for i = 1:numel(indices)
        row = ceil(indices(i) / n);
        col = mod(indices(i) - 1, n) + 1;
        notation{i} = [letters(col), num2str(row)];
    end
end
