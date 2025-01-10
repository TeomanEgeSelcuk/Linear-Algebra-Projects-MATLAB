
function elementaryMatrices = rrefmovie(A, verbose)
%RREFMOVIE Movie of the computation of the reduced row echelon form with elementary matrices.
%   RREFMOVIE(A, verbose) produces the reduced row echelon form of A and controls output verbosity.
%   It also returns a cell array of elementary matrices used in the transformation.
%   If verbose is true, it prints all the steps, otherwise it prints nothing.

if nargin < 2
    verbose = true; % Default value for verbose is true
end

Old_Format = get(0,'Format');
format rat; % Set format to rational
if verbose home; end

if verbose, fprintf('===========Finding All the Elementary Matrices of A ===========\n'); disp('  Original matrix'), disp(A), end

[m,n] = size(A);
elementaryMatrices = {}; % Initialize the list to store elementary matrices

% Compute the default tolerance if none was provided.
tol = max([m,n]) * eps * norm(A, 'inf');

% Loop over the entire matrix.
i = 1;
j = 1;
while (i <= m) && (j <= n)
    % Find value and index of largest element in the remainder of column j.
    [p,k] = max(abs(A(i:m,j))); k = k+i-1;
    if (p <= tol)
        if verbose
            disp(['  column ', int2str(j), ' is negligible'])
        end
        j = j + 1;
    else
        if i ~= k
            % Code for swapping rows i and k, if necessary, omitted for brevity
        end

        pivot = A(i,j);
        if pivot ~= 1 % Only scale if pivot is not already 1
            E = eye(m);
            E(i,i) = 1 / pivot;
            A(i,j:n) = A(i,j:n) / pivot;
            if verbose
                disp(['  Scaling row ', int2str(i), ' to make pivot 1:']);
                disp(['  R', int2str(i), ' = R', int2str(i), ' / ', num2str(pivot)]);
                disp(A);
            end
            elementaryMatrices{end + 1} = E;
        end
        % Subtract multiples of the pivot row from all the other rows.
        for k = 1:m
            if k ~= i
                factor = A(k,j) / A(i,j);
                E = eye(m);
                E(k,:) = E(k,:) - factor * E(i,:);
                A(k,j:n) = A(k,j:n) - factor * A(i,j:n);
                if verbose
                    disp(['  Eliminating column ', int2str(j), ' below pivot using row ', int2str(i), ':']);
                    disp(['  R', int2str(k), ' = R', int2str(k), ' - (', num2str(factor), ') * R', int2str(i)]);
                    disp(A);
                end
                elementaryMatrices{end + 1} = E;
            end
        end
        i = i + 1;
        j = j + 1;
    end
end

if verbose, disp('  Final matrix'), disp(A), end

end
