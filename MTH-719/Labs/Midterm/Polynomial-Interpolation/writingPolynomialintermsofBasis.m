function resultant_vector = writingPolynomialintermsofBasis(P, coefficients, verbose)
    if nargin < 3
        verbose = true;  % Default verbose value
    end

    % Multiply the Change of Basis Matrix by the Coefficients Vector
    resultant_vector = P * coefficients;

    % Display the complete matrix multiplication if verbose is true
    if verbose
        fprintf('\nComplete matrix multiplication [P * [P(x)]_B]:\n');
        fprintf('P =\n');
        disp(P);
        fprintf('[P(x)]_B =\n');
        disp(coefficients);
        fprintf('Resultant vector [P(x)] after transformation:\n');
        disp(resultant_vector);
    end
end
