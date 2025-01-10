function B = FindingBasis_inRn(A, Rn_value, verbose)
    % Check if the rows of "A" form a basis for \mathbb{R}^n
    [rows, cols] = size(A);
    
    if verbose
        fprintf('Rows = %d, Columns = %d\n', rows, cols);
    end
    
    % Rank and dimension checks
    if rows == Rn_value && rank(A) == Rn_value
        BasisCheck = 'The rows of the given matrix form a basis for \mathbb{R}^n.';
        B = [];
        return;
    end
    
    % Perform Gaussian elimination to get RREF
    B_rref = [A eye(rows)];
    [R, pivots] = rref(B_rref);
    
    if verbose
        disp('Gaussian Elimination (RREF) Result:');
        disp(R);
        % Show pivot information and linear independence
        fprintf('Pivots: %s\n', mat2str(pivots));
    end
    
    % Construct new matrix using only linearly independent columns
    B = B_rref(:, pivots); 
    
    if verbose
        disp('Linearly Independent Columns (Based on Pivots):');
        disp(B);
    end
    
    % Determine if the new matrix forms a basis for \R^n
    [rows_new, cols_new] = size(B);
    
    if cols_new == Rn_value
        disp('The columns of the new matrix form a basis for R^n.')
    else
        disp('The columns of the new matrix do not form a basis for R^n.');
    end
end