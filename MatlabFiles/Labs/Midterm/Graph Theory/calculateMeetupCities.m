function numMeetingCities = calculateMeetupCities(M, yourPosition, FriendsPosition, numSteps, verbose)
    % Define the maximum number of steps that people can take in a day
    max_steps = numSteps;  % Adjust as needed

    % Initialize a matrix that will hold the sum of all powers of M up to max_steps
    M_sum = M;

    % Calculate M + M^2 + M^3 + ... + M^max_steps
    for n = 2:max_steps
        M_sum = M_sum + M^n;
    end
    
    % The cities where you can go are the ones where there is a non-zero entry in the yourPosition row of M_sum
    reachableFromYourPosition = find(M_sum(yourPosition, :) > 0);

    % The cities where your friend can go are the ones where there is a non-zero entry in the FriendsPosition row of M_sum
    reachableFromFriendsPosition = find(M_sum(FriendsPosition, :) > 0);

    % The cities where they can meet are the ones that are reachable from both yourPosition and FriendsPosition
    meetingCities = intersect(reachableFromYourPosition, reachableFromFriendsPosition);
    % disp(meetingCities)
    % The number of different cities you can meet up in is then
    numMeetingCities = length(meetingCities);

    % Display the number of meetup cities if verbose is true
    if verbose
        fprintf('Number of meetup cities: %d\n', numMeetingCities);
        disp('Sum of all powers of M up to max_steps:');
        disp(M_sum);
    end
end
