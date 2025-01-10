function [overallMaxDistance, positionWithMaxDistance] = findOverallLongestPath(M, verbose)
    AllPositions = 1:1:(length(M));
    overallMaxDistance = -inf;
    positionWithMaxDistance = -1;

    for startingPosition = AllPositions
        maxDistance = LongestPaths_traceability(M, startingPosition, true);
        if maxDistance > overallMaxDistance
            overallMaxDistance = maxDistance;
            positionWithMaxDistance = startingPosition;
        end
    end

    if verbose
        fprintf('\nThe overall maximum distance is %d moves.\n', overallMaxDistance);
        fprintf('The position with the overall longest path is: %d\n', positionWithMaxDistance);
    end
end
