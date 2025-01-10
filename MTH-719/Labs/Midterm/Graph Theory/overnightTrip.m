function [reachableCities] = overnightTrip(M, yourPosition, verbose)
    % Calculate M^2
    M_squared = M^2;

    % The cities that require more than one day to get to are the ones where there is a non-zero entry in the yourPosition row of M_squared
    reachableCities = find(M_squared(yourPosition, :) > 0);
    
    % If verbose is true, print the result
    if verbose
        % disp('Cities from which an overnight trip is possible:');
        disp(reachableCities);
    end
end

% Test the function
%{
    M = [0 1 1; 1 0 1; 1 1 0];  % replace with the actual adjacency matrix
    yourPosition = 1;
    verbose = true;
    overnightTrip(M, yourPosition, verbose);
%}
