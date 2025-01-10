clc; clear; 

% Define the adjacency matrix M representing bus connections between cities
% M = [0 1 0 1 0 0 0 0 0 0 0 0;
%      1 0 1 0 1 0 0 0 0 0 0 0;
%      0 1 0 0 0 1 0 0 0 0 0 0;
%      1 0 0 0 0 0 1 0 0 0 0 0;
%      0 1 0 0 0 0 0 1 0 0 0 0;
%      0 0 1 0 0 0 0 0 1 0 0 0;
%      0 0 0 1 0 0 0 0 0 1 0 0;
%      0 0 0 0 1 0 0 0 0 0 1 0;
%      0 0 0 0 0 1 0 0 0 0 0 1;
%      0 0 0 0 0 0 1 0 0 0 1 0;
%      0 0 0 0 0 0 0 1 0 1 0 1;
%      0 0 0 0 0 0 0 0 1 0 1 0];

chosenFile = 1;


%% Attempt to load data from a .mat file if a valid file number is given
if chosenFile > 0
    % Function to read .mat file should be implemented here
    [MatrixOperations, isSuccess] = readMatFile(chosenFile);
    M = MatrixOperations.M; 
    disp('WARNING: M is Overwritten becuase of file read');
    disp('==========================');
end

%% Code 

% Set verbose to true or false
verbose = false;
if verbose
    disp('Adjacecy Matrix (M):');
    disp(M);
end

% 1) Calculate the number of buses arriving in each city per day
A = sum(M);
verbose = false;
if verbose
    disp('Number of buses arriving at each city per day:');
    disp(A);
end

% 2) Calculate the number of buses departing in each city per day
P = sum(M, 2)';
verbose = false;
if verbose
    disp('Number of buses departing from each city per day:');
    disp(P);
    P + A; 
end
% 3) Calculate the total number of buses (both incoming and outgoing)
total_buses = sum(A) + sum(P);
verbose = false;
if verbose
    disp('Total number of buses (both incoming and outgoing):');
    disp(total_buses);
end

% 4) Calculate the number of meetup cities 
numSteps = 1;
yourPosition = 1;
FriendsPosition = 3;
verbose = false;
numMeetingCities = calculateMeetupCities(M, yourPosition, FriendsPosition, numSteps, verbose);
if verbose
    disp('Number of meetup cities:');
    disp(numMeetingCities);
end

% 5) Total number of ways "I think I saw you yesterday" can be applicable
yourPosition = 1;
friendsPosition = 11;
verbose = false;
waysYesterday = calculateSharedCities(M, yourPosition, friendsPosition, verbose);
if verbose
    disp('Total number of ways "I think I saw you yesterday" can be applicable:');
    disp(waysYesterday);
end

% 6) Cities from which an overnight trip is possible
verbose = false;
overnightCities = overnightTrip(M, yourPosition, verbose);
if verbose
    disp('Cities from which an overnight trip is possible:');
    disp(overnightCities);
end

% 7) Calculate the shortest path between every pair of cities
startingPos = [2,2];
endingPos = [2,4];
verbose = false;
minMoves = findMinMovesDetailed(startingPos, endingPos, M, verbose);
if verbose
    disp('Shortest paths between every pair of cities:');
    disp(minMoves);
end

% 8) Longest possible trip
verbose = false;
longestTripInfo = findOverallLongestPath(M, verbose);
if verbose
    disp('Longest possible trip:');
    disp(longestTripInfo);
end

% 9) Find impossible cities (isolated cities)
verbose = false;
findIsolatedCities(M, verbose);
if verbose
    disp('Calculating for Isolated cities:');
    disp(isolatedCities);
end

% 10) Calculate the longest possible trip from a given city
verbose = true;
startingPosition=4;
longestPathFromCity = LongestPaths_traceability(M, startingPosition, verbose);
if verbose
    disp('If you leave city, which city takes the longest to get to?');
    disp(longestPathFromCity);
end

% 11) Finding for the Power rank and order [For tournament Matrices only]
verbose = false;
[powerRank, order] = powerRank_and_Order(M, verbose);
if verbose
    disp('Finding for the Power rank and order [For tournament Matrices only]');
    disp(['Power Rank: ', num2str(powerRank)]);
    disp('Order:');
    disp(order);
end


%% Optionally, save results to a .mat file
saveFile = true; % Set to true to save results
outputFileName = 'GraphTheory_save.mat'; % Define output file name
varsToSave = {'minMoves'}; % Specify variables to save

if saveFile
    % Specify the directory path
    outputDirectory = 'Outputs';  % Assuming "Outputs" directory is inside the main directory

    % Construct the full path to the output file
    outputFilePath = fullfile(outputDirectory, outputFileName);

    % Save specified variables in the Outputs directory
    save(outputFilePath, varsToSave{:});
end
