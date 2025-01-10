function checkNoSolutionCondition(P, verbose)
    if nargin < 2
        verbose = true;
    end

    % Dimensions of P to determine size of B
    [rows, ~] = size(P);

    % Dynamically create symbolic variables for B based on the size of P
    B = sym('b', [rows, 1], 'real');

    % Extract the last row of P (P2) to define the condition
    P2 = P(end, :);

    % Compute the condition P2 * B
    condition = P2 * B;

    if verbose
        fprintf('===Conditions on b_1, b_2, b_3 ... b_n which guarantee that AX=B is a consistent system of equations===\n');
        fprintf('Equation: (A | B) ~ (E_A | P*B) = [U, P1*B; 0, P2*B]\n');
        fprintf('Given matrix P:\n');
        disp(P);
        fprintf('Given P2 (row):\n');
        disp(P2);
        fprintf('For a consistent system, the following must be satisfied:\n');
        fprintf('P2*B = %s * [b1;b2;...;bn] = %s = 0\n', mat2str(P2), char(condition));

    end
end
