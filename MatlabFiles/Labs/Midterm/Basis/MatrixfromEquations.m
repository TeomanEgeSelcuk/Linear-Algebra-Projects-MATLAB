function  [L , M1, M2] = MatrixfromEquations(eq, m, coeffs, verbose)
    % This function handles equations with terms involving 'L' and 'I'
    % and constructs matrices based on the extracted terms.
    
    % Create the identity matrix of size 'm x m'
    I = eye(m);

    % Parse the expression to identify terms with 'L' and 'I'
    terms = regexp(eq, '(-?\s*\d*\.?\d*)\s*\*\s*(L\^?(\d*))?', 'tokens');

    % Initialize the result matrix
    result = zeros(m);

    % Process each parsed term
    for i = 1:length(terms)
        term = terms{i};
        coeff_str = strtrim(term{1}); % Extract the coefficient
        coeff = str2double(coeff_str);
        if isnan(coeff)
            coeff = 1; % Default coefficient is 1 if not specified
        end
        
        % Determine the power of 'L'
        power_str = term{3};
        if isempty(power_str)
            power = 1; % Default power if not specified
        else
            power = str2double(power_str);
        end
        
        % Determine the operation sign
        sign_op = 1; % Default is addition
        if contains(coeff_str, '-')
            sign_op = -1; % If negative, use subtraction
        end
        
        % Compute the corresponding power of 'L'
        L_power = eye(m) ^ power;
        
        % Adjust the result based on the parsed terms and their signs
        if strcmp(term{2}, 'I')
            % Formula: Coeff * I * L^power
            intermediate_formula = sprintf('%f * I * L^%d', coeff, power);
            intermediate_value = sign_op * coeff * I * L_power;
            result = result + intermediate_value;
        else
            % Formula: Coeff * L^power
            intermediate_formula = sprintf('%f * L^%d', coeff, power);
            intermediate_value = sign_op * coeff * L_power;
            result = result + intermediate_value;
        end
        
        % If 'verbose', print intermediate steps and explanations
        if verbose
            fprintf('Intermediate formula: %s\n', intermediate_formula);
            fprintf('Intermediate value: \n');
            disp(intermediate_value);
        end
    end
    
    % Generate a random-filled matrix 'P' of size 'm x m'
    P = randi([1, 20]) * ones(m);
    P = P + I; % Ensure invertibility
    
    if verbose
        fprintf('P = %d * ones(%d) + I = \n', randi([1, 20]), m);
        disp(P);
    end

    % Calculate the inverse of 'P'
    P_inv = inv(P);
    
    if verbose
        fprintf('P_inv = inv(P) = \n');
        disp(P_inv);
    end
    
    % Compute the diagonal matrix 'D' using the real roots from coefficients
    roots_val = roots(coeffs);

    if verbose
        fprintf('roots_val = roots(coeffs) = roots([');
        fprintf('%d ', coeffs);
        fprintf(']) = \n');
        disp(roots_val);
    end


    % Ensure roots are real and avoid zero entries
    roots_nonzero = roots_val(roots_val ~= 0 & isreal(roots_val));
    if isempty(roots_nonzero)
        error('No non-zero, real roots found.');
    end
    
    % Create the diagonal matrix 'D'
    D = diag(roots_nonzero(1:min(m, length(roots_val))));

    if verbose
        fprintf('D = diag(roots_nonzero(1:min(%d, %d))) = diag([', m, length(roots_val));
        fprintf('%f ', roots_nonzero(1:min(m, length(roots_val))));
        fprintf(']) = \n');
        disp(D);
    end
    
    % Form the 'L' matrix using 'P', 'D', and 'P_inv'
    L = P * D * P_inv;

    if verbose
        fprintf('L = P * D * P_inv = \n');
        fprintf('L = %s * %s * %s\n', mat2str(P), mat2str(D), mat2str(P_inv));
        disp(L);
    end

    % If 'verbose', print detailed output and intermediate steps
    if verbose
        fprintf('Parsed terms from the equation: %s\n', eq);
        fprintf('Matrix P:\n');
        disp(P);
        
        fprintf('Inverse of P:\n');
        disp(P_inv);
        
        fprintf('Diagonal matrix D:\n');
        disp(D);
        
        fprintf('Matrix L:\n');
        disp(L);
    end

    % Perform QR factorization on P
    [Q, R] = qr(P);
    
    if verbose
        fprintf('Performing QR factorization on P...\n');
        fprintf('QR factorization: P = Q * R\n');
        fprintf('where Q is an orthogonal matrix and R is an upper triangular matrix\n');
    end

    % Calculate the matrices M1 and M2
    M1 = Q * D * Q';
    M2 = R * D * R';
    if verbose
        fprintf('M1 = %s * %s * %s\n', mat2str(Q), mat2str(D), mat2str(Q'));
        fprintf('M1 = \n');
        disp(M1);
        fprintf('M2 = %s * %s * %s\n', mat2str(R), mat2str(D), mat2str(R'));
        fprintf('M2 = \n');
        disp(M2);

        if isequal(M1, M1') && all(eig(M1) > 0)
            disp('M1 is symmetric and positive definite.');
        else
            disp('M1 is not symmetric and positive definite.');
        end
        
        if isequal(M2, M2') && all(eig(M2) > 0)
            disp('M2 is symmetric and positive definite.');
        else
            disp('M2 is not symmetric and positive definite.');
        end
    end 
end
