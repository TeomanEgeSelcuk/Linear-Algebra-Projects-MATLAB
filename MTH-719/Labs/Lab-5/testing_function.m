clc; clear;

saveFile = true;
outputFileName = 'output.mat';
variablesSaved = {'P', 'Q'}; % Dynamically list variables here for output
t_Values = []; % Now t_Values is an array of t values. Make it empty, t_Values = [], to skip.
chosenFile =0; % Choose the file number to upload

%% Loading the .mat files
files = dir('*.mat');
if isempty(files)
    disp('No .mat files found in the current directory. Skipping file loading.');
else
    % Proceed only if chosenFile is within the valid range
    if chosenFile > length(files) || chosenFile < 1
        disp('Invalid file number chosen. Skipping file loading.');
    else
        chosenFileName = files(chosenFile).name;
        fprintf('Loading data from %s\n', chosenFileName);

        % Load the chosen .mat file
        loadedData = load(chosenFileName);

        % Dynamically assign loaded data to variables, ensuring vectors are transposed to row vectors
        variableNames = fieldnames(loadedData);
        for i = 1:length(variableNames)
            varData = loadedData.(variableNames{i});
            if isvector(varData) % Check if varData is a vector
                % Transpose column vectors to row vectors
                if iscolumn(varData)
                    varData = varData.';
                end
            end
            assignin('base', variableNames{i}, varData);
        end

        % Print the names and sizes of all variables stored in the chosen .mat file
        fileInfo = whos('-file', chosenFileName);
        fprintf('Variables in %s:\n', chosenFileName);
        for i = 1:length(fileInfo)
            fprintf('%d: %s - Size: %s\n', i, fileInfo(i).name, mat2str(fileInfo(i).size));
        end

        % Optionally, print contents of each loaded variable
        for i = 1:length(variableNames)
            fprintf('%s = \n', variableNames{i});
            disp(evalin('base', variableNames{i}));
        end
    end
end

%% Tesing function 
try
    [P , Q] = normalForm(A);
catch
    warning('Function not executing correctly, A is not defined')
    return
end

%% Saving to a .mat file with redefined variable names and dynamically stating saved variables
if saveFile
    save(outputFileName, variablesSaved{:});
    disp(['Process completed. Variables ', strjoin(variablesSaved, ', '), ' are saved.']);
end