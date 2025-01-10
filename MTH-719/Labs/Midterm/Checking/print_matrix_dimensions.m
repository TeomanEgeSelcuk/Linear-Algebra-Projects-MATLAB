function print_matrix_dimensions(A)
    [m, n] = size(A);
    fprintf('The matrix has %d rows and %d columns.\n', m, n);
end