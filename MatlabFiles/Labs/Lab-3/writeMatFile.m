function writeMatFile(saveFile, outputFileName, varsToSave)
    if ~saveFile
        return; % Skip saving if saveFile is false
    end

    if isempty(outputFileName)
        outputFileName = 'output.mat'; % Default file name
    end

    if isempty(varsToSave)
        save(outputFileName); % Save all variables
    else
        save(outputFileName, varsToSave{:}); % Save specified variables
    end
end
