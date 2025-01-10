function is_subspace = check_subspacewithInnerProduct(m, v, inner_product_rule, verbose)
    % m - dimension of the vector space
    % v - vector defining the subspace condition
    % inner_product_rule - expected inner product value to determine subspace condition
    % verbose - whether to print detailed information or run silently
    
    % Create symbolic variables based on dimension 'm'
    syms x [m, 1]; % 'm' symbolic variables in a column
    alpha_sym = sym('alpha_sym'); % Symbolic scalar variable
    
    % Generate a symbolic vector 'X'
    X = x; % Assign the symbolic variable array to 'X'

    % Calculate the inner product between 'v' and 'X'
    dot_product = dot(v, X);

    % Verbose output to explain the initial condition and subspace properties
    if verbose
        fprintf('============Showing S is a subspace of R^%d==============\n', m);
        fprintf('Vector defining the condition: v = [');
        fprintf('%d ', v);
        fprintf('];\n');
        
        fprintf('Expected inner product rule: <v, X> = %d\n', inner_product_rule);
        
        fprintf('\n(a) Does the vector X meet the condition for a subspace?\n');
        fprintf('<v, X> = %s\n', char(dot_product));
        
        fprintf('\n**Two properties:**\n');
        
        % Addition Property
        fprintf('1. **Addition:**\n');
        fprintf('Let X, Y be in the subset, then <v, X> = %d and <v, Y> = %d\n', inner_product_rule, inner_product_rule);
        fprintf('Is X + Y in the subspace?\n');
        addition_check = dot(v, X + X); % Simulate addition
        addition_value = subs(addition_check, x, zeros(m, 1)); % Corrected substitution
        fprintf('<v, X + Y> = <v, X> + <v, Y> = %d + %d = %d\n', inner_product_rule, inner_product_rule, inner_product_rule*2);
        
        % Scalar Multiplication Property
        fprintf('2. **Scalar Multiplication:**\n');
        fprintf('Is alpha_sym * X in the subspace?\n');
        scalar_check = alpha_sym * dot_product; % Check scalar multiplication with symbolic alpha
        scalar_value = subs(scalar_check, x, zeros(m, 1)); % Corrected substitution
        
        fprintf('<v, alpha * X> = alpha * <v, X> = alpha * %d  = ', inner_product_rule); % Use char to print symbolic values
        disp(alpha_sym *inner_product_rule);
    
    end
    
    % Validate if the inner product meets the expected rule
    substitution_values = zeros(m, 1); % Corrected substitution values
    if double(subs(dot(v, X), x, substitution_values)) ~= inner_product_rule
        is_subspace = false;  % Condition not met
    else
        is_subspace = true;  % Condition met
    end
    
    % Final result output
    if verbose
        if is_subspace
            fprintf('Condition met, likely a subspace.\n');
        else
            fprintf('Condition NOT met, might not be a subspace.\n');
        end
    end
end
