function writeMatFile(saveFile, outputFileName, varsToSave)
    if ~saveFile
        disp('Skipping saving. saveFile is false.');
        return; % Skip saving if saveFile is false
    end

    if isempty(outputFileName)
        outputFileName = 'output.mat'; % Default file name
    end

    if isempty(varsToSave)
        save(outputFileName); % Save all variables
        disp(['All variables saved to ', outputFileName]);
    else
        save(outputFileName, varsToSave{:}); % Save specified variables
        disp(['Specified variables saved to ', outputFileName]);
    end
end
