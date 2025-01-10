function [is_basis, change_of_basis] = check_basisPoly(B, B_prime, degree, verbose)
    if nargin < 4
        verbose = false;  % Default verbose value
    end
    if nargin < 3 || isempty(degree)
        degree = length(B);  % If degree is not provided, use the length of B
    else
        degree = degree + 1;  % If degree is provided, increment it by one
    end

    % Set floating point output preference for symbolic calculations
    sympref('FloatingPointOutput', true);

    % Convert strings to symbolic expressions
    B = str2sym(B);
    B_prime = str2sym(B_prime);

    % Set the length of the basis according to degree
    basis_length = degree;  % Use the adjusted degree as basis_length

    % Generate symbolic variables dynamically
    syms x;
    syms_coeff = sym('a', [1 basis_length]); % Changed from 'coeffs' to avoid conflict

    % Initialize an empty array for the equations
    eqns = sym(zeros(1, basis_length));

    all_solutions = sym(zeros(length(B), length(syms_coeff)));

    % Create the symbolic system of equations
    for i = 1:basis_length
        eqns(i) = sum(syms_coeff .* B_prime) - B(i);

        % Expand the polynomial to simplify it
        poly = expand(eqns(i));

        if verbose
            fprintf('Polynomial equation for basis row %d: %s = 0\n', i, char(poly));
        end

        % Collect terms of polynomial as coefficients of powers of x
        c = coeffs(poly, x, 'All');

        % Coefficients expected to be zero or given values
        target_coeffs = zeros(1, basis_length);

        % Generate equations from the coefficients
        equations = [];
        n = length(target_coeffs);
        if length(c) < n
            c = [sym(zeros(1, n-length(c))), c];  % Pad with zeros if fewer coefficients than expected
        end

        for j = 1:n
            equations = [equations, c(j) == target_coeffs(j)];
            if verbose
                fprintf('Equation for coefficient of cell %d: %s = %d\n', n-j, char(c(j)), target_coeffs(j));
            end
        end

        % Solve the equations for symbolic coefficients
        sol = solve(equations, syms_coeff);

        % Store the solution in the array
        all_solutions(i, :) = struct2array(sol);  % Convert structure to array if 'solve' returns structure

        if verbose
            fprintf('Solutions for polynomial row %d (a1, a2, ..., an): ', i);
            disp(all_solutions(i, :));
        end
    end
    
    is_basis = double(all_solutions); % Convert symbolic solutions to double

    % Compute the transpose
    transposed = is_basis.';

    % Compute the inverse of the transposed matrix
    change_of_basis = inv(transposed);

    if verbose
        disp('All solutions matrix:');
        disp(is_basis);
        disp('Change of Basis Matrix (from B to B_prime):');
        disp(change_of_basis);
        fprintf('Since you can write every polynomial of degree %d or less using B and you can write B as a linear combination of B_prime, B_prime is also a basis.\n', degree-1);
    end

    % Return both the solutions matrix and the change of basis matrix
    return;
end
