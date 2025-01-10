function [ColA, RowA, RnullA, LnullA, changeOfCoordMatrix] = calculateBasisSpaces(A, verbose)
    %{
    Question:
    Given a matrix "A", calculate the basis for the column space, row space, null space, and left null space. 
    Additionally, calculate the change of coordinates matrix from the column space to the row space.

    Inputs:
    - A: The input matrix.
    - verbose: Boolean controlling detailed output (default is true).

    Outputs:
    - ColA: Basis for the column space.
    - RowA: Basis for the row space.
    - RnullA: Basis for the null space.
    - LnullA: Basis for the left null space.
    - changeOfCoordMatrix: Change of coordinates matrix from ColA to RowA.
    %}

    if nargin < 2
        verbose = true; % Default value of verbose is true
    end

    % Determine the size of matrix A
    [m, n] = size(A);
    if verbose
        fprintf('Size of A: [%d, %d]\n', m, n);
    end

    % Calculate the rank of matrix A
    r = rank(A);
    if verbose
        fprintf('Rank of A: %d\n', r);
    end

    % Placeholder for the normalForm function (you need to replace this with your implementation or approximation)
    [P, Q] = deal(rand(m), rand(n)); % Example replacement, adjust with actual computation
    if verbose
        fprintf('P, Q matrices obtained (using placeholders).\n');
    end

    % Calculate the reduced row echelon form of A and the pivot columns
    [Ea, c] = rref(A);
    if verbose
        fprintf('Reduced Row Echelon Form of A calculated.\n');
    end

    % Basis for the column space of A
    ColA = A(:, c);
    if verbose
        fprintf('Basis for the column space (ColA):\n');
        fprintf('ColA = A(:, c) = A(:, [%s]);\n', sprintf('%d ', c));
        disp(ColA);
    end

    % Basis for the row space of A
    RowA = Ea(1:r, :)';
    if verbose
        fprintf('Basis for the row space (RowA):\n');
        fprintf('RowA = Ea(1:%d, :)'';\n', r);
        disp(RowA);
    end

    % Basis for the null space of A
    RnullA = Q(:, r + 1:n);
    if verbose
        fprintf('Basis for the null space (RnullA):\n');
        fprintf('RnullA = Q(:, r + 1:n) = Q(:, [%s]);\n', sprintf('%d ', r + 1, n));
        disp(RnullA);
    end

    % Basis for the left null space of A
    LnullA = P(r + 1:m, :)';
    if verbose
        fprintf('Basis for the left null space (LnullA):\n');
        fprintf('LnullA = P(r + 1:m, :) = P(%d + 1:%d)'';\n', r + 1, m);
        disp(LnullA);
    end
    
    % Calculate the change of coordinates matrix from ColA to RowA
    % Using a basic pseudoinverse method
    try
        changeOfCoordMatrix = pinv(ColA) * RowA;
        if verbose
            fprintf('Change of coordinates matrix from ColA to RowA:\n');
            fprintf('changeOfCoordMatrix = pinv(ColA) * RowA;\n');
            disp(changeOfCoordMatrix);
        end
    catch ME
        changeOfCoordMatrix = [];
        if verbose
            fprintf('Error calculating change of coordinates matrix: %s\n', ME.message);
        end
    end
end





% function [ColA, RowA, RnullA, LnullA] = calculateBasisSpaces(A, verbose)
% 
%     if nargin < 2
%         verbose = true; % Default value of verbose is true
%     end
% 
%     % Determine the size of matrix A
%     [m, n] = size(A);
%     if verbose
%         fprintf('Size of A: [%d, %d]\n', m, n);
%     end
% 
%     % Calculate the rank of matrix A
%     r = rank(A);
%     if verbose
%         fprintf('Rank of A: %d\n', r);
%     end
% 
%     % Placeholder for normalForm function (you need to replace this with your implementation or approximation)
%     [P, Q] = deal(rand(m), rand(n)); % Example replacement, adjust with actual computation
%     if verbose
%         fprintf('P, Q matrices obtained (using placeholders).\n');
%     end
% 
%     % Calculate the reduced row echelon form of A and the pivot columns
%     [Ea, c] = rref(A);
%     if verbose
%         fprintf('Reduced Row Echelon Form of A calculated.\n');
%     end
% 
%     % Basis for the column space of A
%     ColA = A(:,c);
%     if verbose
%         fprintf('Basis for the column space (ColA) determined by selecting columns from A corresponding to pivot positions:\n');
%         fprintf('ColA = A(:,c) = A(:,[%s]);\n', sprintf('%d ', c));
%         disp(ColA);
%     end
% 
%     % Basis for the row space of A
%     RowA = Ea(1:r,:)';
%     if verbose
%         fprintf('Basis for the row space (RowA) by transposing the first r rows of Ea:\n');
%         fprintf('RowA = Ea(1:r,:) = Ea(1:%d,:)'';\n', r);
%         disp(RowA);
%     end
% 
%     % Basis for the null space of A
%     RnullA = Q(:,r+1:n);
%     if verbose
%         fprintf('Basis for the null space (RnullA) from columns of Q for free variables:\n');
%         fprintf('RnullA = Q(:,r+1:n) = Q(:,%d+1:%d);\n', r, n);
%         disp(RnullA);
%     end
% 
%     % Basis for the left null space of A
%     LnullA = P(r+1:m,:)';
%     if verbose
%         fprintf('Basis for the left null space (LnullA) from rows of P for free variables:\n');
%         fprintf('LnullA = P(r+1:m,:) = P(%d+1:%d,:)'';\n', r, m);
%         disp(LnullA);
%     end
% end


% function [ColA, RowA, RnullA, LnullA] = calculateBasisSpaces(A, verbose)
%     %{
%     Question:
%     Given a matrix "A", calculate the basis for the column space, row space, null space, and left null space.
% 
%     Inputs:
%     - A: The input matrix.
%     - verbose: Boolean controlling detailed output (default is true).
% 
%     Outputs:
%     - ColA: Basis for the column space.
%     - RowA: Basis for the row space.
%     - RnullA: Basis for the null space.
%     - LnullA: Basis for the left null space.
%     %}
% 
%     if nargin < 2
%         verbose = true; % Default value of verbose is true
%     end
% 
%     % Determine the size of matrix A
%     [m, n] = size(A);
%     if verbose
%         fprintf('Size of A: [%d, %d]\n', m, n);
%     end
% 
%     % Calculate the rank of matrix A
%     r = rank(A);
%     if verbose
%         fprintf('Rank of A: %d\n', r);
%     end
% 
%     % Calculate the reduced row echelon form of A and get pivot columns
%     try
%         [Ea, c] = rref(A);
%         if verbose
%             fprintf('Reduced Row Echelon Form of A:\n');
%             disp(Ea);
%             fprintf('Pivot columns: %s\n', sprintf('%d ', c));
%         end
%     catch ME
%         error('Failed to calculate RREF of A: %s', ME.message);
%     end
% 
%     % Basis for the column space of A
%     try
%         ColA = A(:, c);
%         if verbose
%             fprintf('Basis for the column space (ColA):\n');
%             fprintf('ColA = A(:, [%s]);\n', sprintf('%d ', c));
%             disp(ColA);
%         end
%     catch ME
%         ColA = [];
%         if verbose
%             fprintf('Error calculating ColA: %s\n', ME.message);
%         end
%     end
% 
%     % Basis for the row space of A
%     try
%         RowA = Ea(1:r, :)';
%         if verbose
%             fprintf('Basis for the row space (RowA):\n');
%             fprintf('RowA = Ea(1:%d, :)'';\n', r);
%             disp(RowA);
%         end
%     catch ME
%         RowA = [];
%         if verbose
%             fprintf('Error calculating RowA: %s\n', ME.message);
%         end
%     end
% 
%     % Basis for the null space of A
%     try
%         [~, ~, Q] = svd(A);  % Singular Value Decomposition
%         RnullA = Q(:, r + 1:n);
%         if verbose
%             fprintf('Basis for the null space (RnullA):\n');
%             fprintf('RnullA = Q(:, r + 1:n) = Q(:, [%s]);\n', sprintf('%d ', r + 1:n));
%             disp(RnullA);
%         end
%     catch ME
%         RnullA = [];
%         if verbose
%             fprintf('Error calculating RnullA: %s\n', ME.message);
%         end
%     end
% 
%     % Basis for the left null space of A
%     try
%         [U, ~, ~] = svd(A);
%         LnullA = U(r + 1:m, :)';
%         if verbose
%             fprintf('Basis for the left null space (LnullA):\n');
%             fprintf('LnullA = U(r + 1:m, :)'';\n', r + 1, m);
%             disp(LnullA);
%         end
%     catch ME
%         LnullA = [];
%         if verbose
%             fprintf('Error calculating LnullA: %s\n', ME.message);
%         end
%     end
% end
