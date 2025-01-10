function [loadedData, fileInfo] = readMatFile(chosenFile)
    % List all .mat files in the current directory
    files = dir('*.mat');

    % Check if there are no .mat files
    if isempty(files)
        disp('No .mat files found in the current directory. Skipping file loading.');
        return;
    end

    % Check if the chosen file number is valid
    if chosenFile > length(files) || chosenFile < 1
        disp('Invalid file number chosen. Skipping file loading.');
        return;
    end

    % Get the name of the chosen .mat file
    chosenFileName = files(chosenFile).name;
    fprintf('Loading data from %s\n', chosenFileName);

    % Load data from the chosen .mat file
    loadedData = load(chosenFileName);

    % Get the variable names in the loaded data
    variableNames = fieldnames(loadedData);

    % Get information about the variables stored in the .mat file
    fileInfo = whos('-file', chosenFileName);
    fprintf('Variables in %s:\n', chosenFileName);
    for i = 1:length(fileInfo)
        fprintf('%d: %s - Size: %s\n', i, fileInfo(i).name, mat2str(fileInfo(i).size));
    end

    % Display the value of each variable
    for i = 1:length(variableNames)
        fprintf('%s = \n', variableNames{i});
        disp(evalin('base', variableNames{i}));
    end
end
