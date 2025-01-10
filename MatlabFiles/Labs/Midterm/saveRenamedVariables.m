function saveRenamedVariables(chosenFile, varsToRename)
    % Load data from the specified .mat file in 'Outputs' directory
    [loadedData, ~] = readMatFile(chosenFile, 'Outputs');
    
    % Check if loadedData is empty, indicating file was not loaded
    if isempty(loadedData)
        disp('No data loaded. Exiting function.');
        return;
    end
    
    % Prepare variables for saving with new names
    renamedVars = struct(); % Initialize empty struct for renamed variables
    for oldVarName = fieldnames(varsToRename)'
        oldVarName = oldVarName{1}; % Extract the string from the cell
        if isfield(loadedData, oldVarName)
            newVarName = varsToRename.(oldVarName);
            renamedVars.(newVarName) = loadedData.(oldVarName);
        else
            disp(['Variable ' oldVarName ' not found in loaded data. Skipping.']);
        end
    end
    
    % Specify the output directory and file name
    outputDirectory = 'Outputs';
    outputFileName = 'new_save.mat';
    outputFilePath = fullfile(outputDirectory, outputFileName);

    % Save the renamed variables to a new .mat file
    save(outputFilePath, '-struct', 'renamedVars');
end

% Example of using the function with readMatFile included
%{
varsToRename = struct('augmentedMatrix', 'aug', 'general_solution', 'solution');
saveRenamedVariables(3, varsToRename);
%}

