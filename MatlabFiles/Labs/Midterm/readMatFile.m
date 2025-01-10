function [loadedData, fileInfo] = readMatFile(chosenFile, varargin)
    % Set default directory path
    directory = 'Inputs'; % Default directory
    
    % Check if a directory argument is provided and update if necessary
    if ~isempty(varargin)
        directory = varargin{1};
    end

    % Check if the specified directory exists
    if ~isfolder(directory)
        disp(['Directory "' directory '" does not exist. Skipping file loading.']);
        return;
    end

    % List all .mat files in the specified directory
    files = dir(fullfile(directory, '*.mat'));
    if isempty(files)
        disp(['No .mat files found in the "' directory '" directory. Skipping file loading.']);
        return;
    end

    if chosenFile > length(files) || chosenFile < 1
        disp('Invalid file number chosen. Skipping file loading.');
        return;
    end

    chosenFileName = files(chosenFile).name;
    chosenFilePath = fullfile(directory, chosenFileName);
    fprintf('Loading data from %s\n', chosenFileName);

    % Load data from the specified .mat file
    loadedData = load(chosenFilePath);
    variableNames = fieldnames(loadedData);
    for i = 1:length(variableNames)
        varData = loadedData.(variableNames{i});
        if isvector(varData) && iscolumn(varData)
            varData = varData.';
        end
        assignin('base', variableNames{i}, varData);
    end

    fileInfo = whos('-file', chosenFilePath);
    fprintf('Variables in %s:\n', chosenFileName);
    for i = 1:length(fileInfo)
        fprintf('%d: %s - Size: %s\n', i, fileInfo(i).name, mat2str(fileInfo(i).size));
    end

    for i = 1:length(variableNames)
        fprintf('%s = \n', variableNames{i});
        disp(evalin('base', variableNames{i}));
    end
end
