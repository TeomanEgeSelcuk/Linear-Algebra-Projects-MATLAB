function [Q, q] = QRNullSpaceAnalysis(A, verbose)
    if nargin < 2
        verbose = true;
    end
    
    % Compute the null space of A
    V = null(A, "rational");
    if verbose
        fprintf("Step 1: Compute Null Space of A\n");
        fprintf("Calculating V = null(A, 'rational'), where A is the given matrix.\n");
        fprintf("Null space basis V of A (using rational numbers):\n");
        disp(V);
    end

    % Reduced QR factorization
    [Q, R] = qr(V, 0);
    if verbose
        fprintf("Step 2: Reduced QR Factorization [Q, R] = qr(V, 0)\n");
        fprintf("Performing reduced QR factorization on V, yields Q and R.\n");
        fprintf("Q (orthonormal basis) =\n");
        disp(Q);
        fprintf("R (upper triangular matrix) =\n");
        disp(R);
    end

    % Check if Q is a basis for the null space
    AQ = A*Q;
    if verbose
        fprintf("Step 3: Verify A*Q ≈ 0 (Q is a basis for the null space)\n");
        fprintf("Calculating A*Q to verify if the result approximates the zero matrix.\n");
        fprintf("A*Q =\n");
        disp(AQ);
    end

    % Check if the columns of Q are orthonormal
    QTQ = Q'*Q;
    if verbose
        fprintf("Step 4: Verify Q'*Q = I (Columns of Q are orthonormal)\n");
        fprintf("Calculating Q'*Q to verify if it equals the identity matrix I.\n");
        fprintf("Q'*Q =\n");
        disp(QTQ);
    end

    % Check that Q*R reconstructs V
    QR = Q*R;
    if verbose
        fprintf("Step 5: Verify Q*R reconstructs V\n");
        fprintf("Calculating Q*R to verify if it reconstructs the matrix V.\n");
        fprintf("Q*R =\n");
        disp(QR);
    end

    % Full QR factorization
    [q, r] = qr(V);
    if verbose
        fprintf("Step 6: Full QR Factorization [q, r] = qr(V)\n");
        fprintf("Performing full QR factorization on V, yields q and r.\n");
        fprintf("q (orthogonal matrix) =\n");
        disp(q);
        fprintf("r (upper triangular matrix, extended) =\n");
        disp(r);
    end

    % Verify that q is an orthogonal matrix
    qqT = q*q';
    if verbose
        fprintf("Step 7: Verify q*q' = I (q is an orthogonal matrix)\n");
        fprintf("Calculating q*q' to verify if it equals the identity matrix I.\n");
        fprintf("q*q' =\n");
        disp(qqT);
    end
end
