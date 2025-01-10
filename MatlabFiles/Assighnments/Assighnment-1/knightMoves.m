function possibleMoves = knightMoves(startingSquare)
    x = double(startingSquare(1)) - double('a') + 1;
    y = str2double(startingSquare(2));
    possibleMoves = [];
    
    % Possible knight move offsets
    moveOffsets = [-2, -1; -2, 1; -1, -2; -1, 2; 1, -2; 1, 2; 2, -1; 2, 1];
    
    for i = 1:size(moveOffsets, 1)
        dx = moveOffsets(i, 1);
        dy = moveOffsets(i, 2);
        newX = x + dx;
        newY = y + dy;
        
        if newX >= 1 && newX <= 8 && newY >= 1 && newY <= 8
            possibleMoves = [possibleMoves, char(newX + double('a') - 1), num2str(newY)];
        end
    end
end

