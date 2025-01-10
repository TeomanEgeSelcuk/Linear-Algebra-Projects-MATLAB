
function [basis1, basis2, alpha1, alpha2] = change_of_basis(A, P, v, verbose)
    if nargin < 4
        verbose = true; % Default value of verbose is true
    end

    if verbose
        disp('Step 1: Calculating the basis for the column space of A...');
        disp('Operation: Perform RREF on A to find the column indices that form the basis.');
    end
    % Calculate the basis for the column space of A
    [R, C] = rref(A);
    basis1 = A(:, C);
    if verbose
        fprintf('General Form: If RREF(A) = R, then basis1 = A(:, C), where C are column indices from R.\n');
        fprintf('In this case, C = [');
        fprintf('%g ', C);
        fprintf('], so basis1 = A(:, [');
        fprintf('%g ', C);
        fprintf(']).\nResult:\n');
        disp(basis1);
    end

    if verbose
        disp('Step 2: Calculating the basis for the column space of A using P (inversion of P)...');
        disp('Operation: Multiply basis1 by the inverse of P to get basis2.');
    end
    % Calculate the basis for the column space of A using P
    basis2 = basis1 * inv(P);
    if verbose
        disp('General Form: basis2 = basis1 * inv(P).');
        disp('With basis1 and P given, the calculation is as follows:');
        disp('basis2 =');
        disp(basis2);
    end

    if verbose
        disp('Step 3: Finding the coordinates of v in basis1...');
        disp('Operation: Solve the equation basis1 * alpha1 = v for alpha1.');
    end
    % Find the coordinates of v in basis1
    alpha1 = basis1 \ v;
    if verbose
        disp('General Form: alpha1 = basis1 \\ v.');
        disp('Using the calculated basis1 and given v, alpha1 is solved as:');
        disp('alpha1 =');
        disp(alpha1);
    end

    if verbose
        disp('Step 4: Finding the coordinates of v in basis2...');
        disp('Operation: Calculate alpha2 by multiplying P with alpha1.');
    end
    % Find the coordinates of v in basis2
    alpha2 = P * alpha1;
    if verbose
        disp('General Form: alpha2 = P * alpha1.');
        disp('With the calculated alpha1 and given P, alpha2 is:');
        disp('alpha2 =');
        disp(alpha2);
    end
end
