function t_values = solveTforGeneralSolution(tX0, X1, conditions, verbose)
    if nargin < 4
        verbose = true;  % Default verbose value
    end
    
    syms t x;  % Define the symbolic variables

    % Ensure the input for X1 is converted to symbolic if it's not already
    X1 = sym(X1);

    % Combine the particular and general solutions
    X = X1 + tX0;

    % If coefficients are given from lowest degree to highest, reverse them
    X = flipud(X);  % This line ensures the highest degree terms are first

    % Convert the solution vector X into a symbolic polynomial in x
    P = poly2sym(X, x);

    if verbose
        % Display the polynomial for verification
        disp('Polynomial P(x) in terms of x and t:');
        pretty(P);
    end

    % Prepare to collect equations from conditions
    eqns = [];
    for i = 1:size(conditions, 1)
        n = conditions{i, 1};  % Order of derivative
        x_val = conditions{i, 2};  % Point of evaluation
        y_val = conditions{i, 3};  % Expected value

        % Compute the nth derivative
        dP = diff(P, x, n);

        if verbose
            fprintf('Computing the %d-th derivative of P at x = %d:\n', n, x_val);
            pretty(dP);
        end

        % Create an equation based on the condition
        eqn = subs(dP, x, x_val) == y_val;
        if verbose
            fprintf('Evaluating derivative at x = %d results in:\n', x_val);
            disp(eqn);
        end
        eqns = [eqns, eqn];
    end

    % Solve the system of equations for t
    [t_values, sol_params, sol_cond] = solve(eqns, t, 'ReturnConditions', true);

    if verbose
        % Display results
        disp('Values of t that satisfy the conditions:');
        disp(t_values);
    end
end
