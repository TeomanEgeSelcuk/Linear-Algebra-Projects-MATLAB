function Rs = findAnotherP(A, P, NumberOfUniqueP, verbose)

    if NumberOfUniqueP == 0
        fprintf('Skipping findAnotherP as NumberOfUniqueP is 0.\n');
        Rs = {};
        return;
    end
    fprintf('===========Finding Another Invertible and Unique Matrix R(s) just like matrix P===========\n');
    if nargin < 4
        verbose = true;
    end

    % Calculate E_A = P*A to find the RREF form
    E_A = rref(P*A);
    
    % Identify zero rows in E_A
    zeroRows = find(all(E_A == 0, 2));
    if isempty(zeroRows)
        fprintf('There are no zero-rows found in E_A, so there is not another unique invertible matrix like P\n');
        Rs = {};
        return;
    elseif verbose
        fprintf('Zero rows in E_A: %s\n', mat2str(zeroRows));
    end
    
    % Print identity matrix if verbose is true
    if verbose
        fprintf('Identity Matrix used for scaling:\n');
        disp(eye(size(A, 1)));
    end

    Rs = {}; % Initialize the list of unique Rs
    uniqueScaleFactors = [];
    attempts = 0;
    while length(Rs) < NumberOfUniqueP && attempts < 100
        attempts = attempts + 1;
        scaleFactor = 2 + randi([1, 100]); % Ensure the scale factor is unique
        while any(abs(uniqueScaleFactors - scaleFactor) < 1e-6)
            scaleFactor = 2 + randi([1, 100]);
        end
        uniqueScaleFactors(end+1) = scaleFactor;
        
        E1 = eye(size(A, 1));
        E1(zeroRows, zeroRows) = scaleFactor; % Scale zero rows
        
        R_candidate = E1 * P; % Calculate a new candidate R
        
        % Check if R_candidate is invertible, not equivalent to P or previous Rs, and can transform back to A
        if rcond(R_candidate) > 1e-15
            A_recovered = inv(R_candidate) * (R_candidate * A); % Attempt to recover A
            isDifferent = all(cellfun(@(x) norm(x - R_candidate, 'fro') > 1e-10, Rs)) && norm(P - R_candidate, 'fro') > 1e-10;
            if isDifferent && norm(A - A_recovered, 'fro') < 1e-10 % Check if A is accurately recovered
                Rs{end+1} = R_candidate; % Add R_candidate to the list
                if verbose
                    fprintf('Found a new unique R matrix using scaling factor: %f\n', scaleFactor);
                    fprintf('New Identity Matrix(I_n): I(%f, %f) = %f\n',zeroRows, zeroRows, scaleFactor);
                    fprintf('Equation: I_n * P * A = E_A\n');
                    fprintf('New unique R matrix:\n');
                    disp(R_candidate);                    
                end
            end
        end
    end

    if verbose || isempty(Rs)
        fprintf('Total unique Rs found: %d\n', length(Rs));
    end
end
