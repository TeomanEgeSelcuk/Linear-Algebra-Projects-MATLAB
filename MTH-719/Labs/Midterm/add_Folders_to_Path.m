clc;
clear;

% Get the current directory
currentDir = pwd;

% Add the current directory to the MATLAB path
addpath(currentDir);

% List the contents of the current directory
contents = dir(currentDir);

% Iterate over the contents
for i = 1:numel(contents)
    % Check if the content is a directory and not '.' or '..'
    if contents(i).isdir && ~strcmp(contents(i).name, '.') && ~strcmp(contents(i).name, '..')
        % Get the name of the directory
        folderName = contents(i).name;
        
        % Check if the folder is already in the MATLAB path
        if isempty(which(folderName))
            % If not, add the folder to the MATLAB path
            addpath(fullfile(currentDir, folderName));
            disp(['Added folder "', folderName, '" to the MATLAB path.']);
        else
            disp(['Folder "', folderName, '" is already in the MATLAB path.']);
        end
    end
end

% Now continue with the rest of your code
