function basis = calculateOrthonormalBasisPoly(polynomialArray, verbose)
% Calculates the orthonormal basis for a set of given polynomials on the interval [-1, 1]
% polynomialArray: an array of symbolic expressions representing polynomials
% verbose: boolean flag to print detailed steps and calculations (default true if not specified)

if nargin < 2
    verbose = true; % Default to verbose if not specified
end

syms x;
n = length(polynomialArray);
basis = sym(zeros(1, n));  % Pre-allocate a symbolic array for the basis

% Calculate the norm and normalize each polynomial
for i = 1:n
    p = polynomialArray(i);
    normP = sqrt(int(p^2, x, -1, 1));  % Compute the norm of the polynomial

    if verbose
        fprintf('Calculating norm of Polynomial %d: %s\n', i, char(p));
        fprintf('Integral calculation: sqrt(int(%s^2, x, -1, 1))\n', char(p));
        fprintf('Evaluated Integral: %f\n', double(normP));
    end
    
    normalizedP = simplify(p / normP);  % Normalize the polynomial using simplify for better output
    
    if verbose
        fprintf('Normalized Polynomial %d: %s / %f = %s\n', i, char(p), double(normP), char(normalizedP));
        fprintf('Simplified Form: %s\n', char(simplify(normalizedP)));  % Print simplified form
    end
    
    basis(i) = normalizedP;  % Store normalized polynomial
end

if verbose
    fprintf('Final Orthonormal Basis:\n');
    for i = 1:n
        fprintf('Basis %d: %s\n', i, char(simplify(basis(i))));  % Print simplified form for each basis
    end
end

end
