function [eigenvalues, eigenvectors, normalizationCheck, decompositionCheck] = EigenValueVectorMatrix(A, verbose)
    if nargin < 2
        verbose = true; % Default verbose to true
    end
    
    % Calculate eigenvalues and eigenvectors using MATLAB's eig function
    [V, D] = eig(A);
    eigenvalues = diag(D);

    if verbose
        fprintf('\nStep 1: Beginning the process of finding eigenvalues and eigenvectors.\n');
        fprintf('This involves solving the characteristic equation det(A - λI) = 0,\n');
        fprintf('where det() represents the determinant, λ is an eigenvalue, and I is the identity matrix of the same size as A.\n\n');
        fprintf('Given matrix A:\n');
        disp(A);
    end
    
    if verbose
        % Create the identity matrix for demonstration
        I = eye(size(A));
        fprintf('\nCalculation with MATLAB''s eig function:\n');
        fprintf('The eig function abstracts the detailed algebraic computation but operates under the principle that for each eigenvalue λ,\n');
        fprintf('there exists a non-zero vector v (eigenvector) such that (A - λI)v = 0.\n\n');
        
        fprintf('Given matrix A:\n');
        disp(A);
        
        fprintf('Identity matrix I of the same size as A:\n');
        disp(I);
        
        fprintf('For each calculated eigenvalue λ, we conceptually perform:\n');
        for i = 1:length(eigenvalues)
            lambda = eigenvalues(i);
            fprintf('For λ = %f:\n', lambda);
            fprintf('We consider (A - λI):\n');
            disp(A - lambda * I);
            fprintf('And solve (A - λI)v = 0 to find the corresponding eigenvector.\n\n');
        end
        
        fprintf('Calculated eigenvalues (λ):\n');
        disp(eigenvalues);
        fprintf('Corresponding eigenvectors (columns of V):\n');
        disp(V);
    end
    % Explanation for complex number adjustment
    if ~isreal(eigenvalues)
        if verbose
            fprintf('Step 2: Adjustment for complex eigenvalues and eigenvectors\n');
            fprintf('In some cases, the computation may yield complex eigenvalues and eigenvectors due to the numerical methods employed.\n');
            fprintf('When these complex parts are negligible, it''s common to consider only their real components for practical applications.\n\n');
        end
        eigenvalues = real(eigenvalues);
        V = real(V);
    end
    
    normalizationCheck = [];
    decompositionCheck = true; % Assume verification will succeed, check next
    
    % Normalization for stochastic matrices
    if all(abs(sum(A, 2) - 1) < 1e-10) && verbose
        fprintf('Step 3: Normalization for stochastic matrices\n');
        fprintf('Stochastic matrices represent systems where each column sums to 1, implying a probabilistic model.\n');
        fprintf('Normalization ensures the eigenvector corresponding to λ=1 represents a stable state distribution.\n\n');
        
        % Find the eigenvector corresponding to λ=1
        lambdaOneIndex = find(abs(diag(D) - 1) < 1e-10, 1);
        if ~isempty(lambdaOneIndex)
            v = V(:, lambdaOneIndex);
            fprintf('Identified eigenvector before normalization (v):\n');
            disp(v);
            
            % Perform normalization
            normalizedV = v / sum(v);
            fprintf('Normalized eigenvector (v / sum(v)) calculation:\n');
            
            % Showing the detailed calculation
            sumBeforeNormalization = sum(v);
            fprintf('Sum of components before normalization = sum(v) = %.4f\n', sumBeforeNormalization);
            fprintf('Each component of v is divided by this sum to normalize:\n');
            for i = 1:length(v)
                fprintf('v(%d) / sum(v) = %.4f / %.4f = %.4f\n', i, v(i), sumBeforeNormalization, normalizedV(i));
            end
            
            fprintf('Resulting in the normalized eigenvector (v_normalized):\n');
            disp(normalizedV);
            
            % Verification of normalization
            sumAfterNormalization = sum(normalizedV);
            fprintf('Verification of normalization: sum(v_normalized) = %.4f\n\n', sumAfterNormalization);
            
            % Apply the normalization check for the output
            q = normalizedV;
        else
            fprintf('No eigenvector corresponding to λ=1 found for normalization.\n\n');
            q = [];
        end
    else
        fprintf('Matrix A does not represent a stochastic matrix, or no λ=1 found.\nNormalization step skipped.\n\n');
        q = [];
    end

    
    % Verification of eigendecomposition (A = V*D*V^-1)
    reconstructionError = max(max(abs(A - V*D*inv(V))));
    if reconstructionError < 1e-10
        if verbose
            fprintf('Step 4: Verification of eigendecomposition (A = V*D*V^-1)\n');
            fprintf('This step ensures that our computed matrices accurately reconstruct the original matrix A.\n');
            fprintf('It serves as a confirmation of the correctness of the eigenvalues and eigenvectors found.\n\n');
        end
    else
        decompositionCheck = false;
        if verbose
            fprintf('Verification of eigendecomposition encountered an error of %e, suggesting a discrepancy in the results.\n\n', reconstructionError);
        end
    end
    
    eigenvectors = V;
end
