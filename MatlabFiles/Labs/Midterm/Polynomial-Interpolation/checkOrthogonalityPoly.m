function allOrthogonal = checkOrthogonalityPoly(polynomials, a, b, verbose)
% Checks if all given polynomials are mutually orthogonal over the interval [a, b]
% polynomials: an array of symbolic expressions for the polynomials
% a, b: interval boundaries
% verbose: boolean flag to print detailed steps and calculations

if nargin < 4
    verbose = true; % Default value of verbose is true
end

n = length(polynomials);
allOrthogonal = true;

for i = 1:n
    for j = i+1:n
        % Compute the product of polynomials before integration
        product = polynomials(i) * polynomials(j);

        % Compute the inner product as an integral
        innerProduct = int(product, 'x', a, b);

        % Check if the inner product is zero
        isOrtho = isAlways(innerProduct == 0);
        allOrthogonal = allOrthogonal && isOrtho;

        if verbose
            fprintf('\nChecking orthogonality between Polynomial %d and Polynomial %d:\n', i, j);
            fprintf('Polynomial %d: %s\n', i, char(polynomials(i)));
            fprintf('Polynomial %d: %s\n', j, char(polynomials(j)));
            fprintf('Product of their polynomials: %s\n', char(product));
            fprintf('Integral of their product from %d to %d:\n', a, b);
            pretty(innerProduct);
            fprintf('Evaluated integral results in: ');
            disp(vpa(innerProduct));
            if isOrtho
                fprintf('The polynomials are orthogonal since their inner product is zero.\n');
            else
                fprintf('The polynomials are not orthogonal.\n');
            end
        end
    end
end

if allOrthogonal
    fprintf('\nAll polynomials are mutually orthogonal.\n');
else
    fprintf('\nNot all polynomials are mutually orthogonal.\n');
end

end
