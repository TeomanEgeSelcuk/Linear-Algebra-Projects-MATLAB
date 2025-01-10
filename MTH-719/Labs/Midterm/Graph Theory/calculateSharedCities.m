function [numWays] = calculateSharedCities(M, yourPosition, friendsPosition, verbose)
    % Default verbose to true if not provided
    if nargin < 4
        verbose = true;
    end
    
    % Calculate M' * M
    M_product = M' * M;
    if verbose 
        disp(' M * M'' :');
        disp(M_product);
    end
    % Extract the (yourPosition, friendsPosition) entry of M_product
    numWays = M_product(yourPosition, friendsPosition);
    
    % Determine the message based on the value of numWays and verbose
    if verbose
        if numWays > 1
            disp(['There are multiple paths through which you could have seen each other yesterday, ' ...
                'as indicated by M * M''(', num2str(yourPosition), ',', num2str(friendsPosition), ') = ', num2str(numWays), '.']);
        else
            disp(['There is only one path through which you could have seen each other yesterday, ' ...
                'as indicated by M * M''(', num2str(yourPosition), ',', num2str(friendsPosition), ') = ', num2str(numWays), '.']);
        end
    end
end


% % Test the function
% M = [0 1 1; 1 0 1; 1 1 0];  % replace with the actual adjacency matrix
% yourPosition = 1;
% friendsPosition = 3;
% calculateSharedCities(M, yourPosition, friendsPosition);
