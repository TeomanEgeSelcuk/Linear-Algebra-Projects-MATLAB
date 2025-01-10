function findIsolatedCities(M, verbose)
    if nargin < 2
        verbose = true;  % default value
    end

    % check rows and columns for all zeros
    isolatedCities = find(all(M == 0, 1) | all(M == 0, 2));

    % print isolated cities if verbose is true
    if verbose && ~isempty(isolatedCities)
        fprintf('Isolated cities: ');
        disp(isolatedCities);
    elseif verbose
        fprintf('There are no isolated cities.\n');
    end
end
