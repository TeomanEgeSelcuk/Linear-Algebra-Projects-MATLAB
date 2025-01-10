function check_diagonalizable(A)
    % Get eigenvalues and eigenvectors
    [V,D] = eig(A);

    % Check if the matrix of eigenvectors is invertible
    if det(V) ~= 0
        fprintf('The matrix is diagonalizable.\n');
    else
        fprintf('The matrix is not diagonalizable.\n');
    end
end
