function DimensionRankofaNullSpace(V)

    % Get size of V
    [rows, columns] = size(V);
    
    % Calculate rank of V
    rankV = rank(V);
    
    fprintf('The rows of B are %d and the columns are %d.\n',rows, rows - rankV);

    % Check relationship between rows and columns
    if rows > columns
        m = 4;  % Greater value
        possible_ranks = rankV:m+3;
        fprintf('rank of (V) <= min(rows, columns) so B cant be less than rank\n');
        fprintf('so the dimensions is columns = rank, rank+1 , rank+2 ....\n rows is max[rows, columns] ');
    elseif rows < columns
        m = rankV:rows+3;
        fprintf('so the dimensions is columns = rank, rank+1 , rank+2 .... ')
        fprintf('columns is max[rows, columns]')
        fprintf('so the dimensions is rows = rank, rank+1 , rank+2 .... ')
    else
        disp('Rows and columns are equal. it will be the dim(Input)');
    end
    
end
