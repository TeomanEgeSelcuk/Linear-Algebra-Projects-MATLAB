function [loadedData, fileInfo] = readMatFile(chosenFile)
    files = dir('*.mat');
    if isempty(files)
        disp('No .mat files found in the current directory. Skipping file loading.');
        return;
    end

    if chosenFile > length(files) || chosenFile < 1
        disp('Invalid file number chosen. Skipping file loading.');
        return;
    end

    chosenFileName = files(chosenFile).name;
    fprintf('Loading data from %s\n', chosenFileName);

    loadedData = load(chosenFileName);
    variableNames = fieldnames(loadedData);
    for i = 1:length(variableNames)
        varData = loadedData.(variableNames{i});
        if isvector(varData) && iscolumn(varData)
            varData = varData.';
        end
        assignin('base', variableNames{i}, varData);
    end

    fileInfo = whos('-file', chosenFileName);
    fprintf('Variables in %s:\n', chosenFileName);
    for i = 1:length(fileInfo)
        fprintf('%d: %s - Size: %s\n', i, fileInfo(i).name, mat2str(fileInfo(i).size));
    end

    for i = 1:length(variableNames)
        fprintf('%s = \n', variableNames{i});
        disp(evalin('base', variableNames{i}));
    end
end
