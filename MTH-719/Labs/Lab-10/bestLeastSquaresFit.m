function [P, error] = bestLeastSquaresFit(X, Y, degree, verbose, printFit)
    if nargin < 4  % Check if verbose argument is provided
        verbose = true;  % Default value of verbose is true
    end

    if nargin < 5
        printFit = false; % Default value of printFit is false
    end

    % Ensure X and Y are column vectors
    X = X(:);
    Y = Y(:);
    
    % Validate input dimensions
    if length(X) ~= length(Y)
        error('X and Y vectors must be of the same length.');
    elseif verbose
        fprintf('Validation complete: X and Y vectors are of the same length.\n');
    end
    
    % Prepare the Vandermonde matrix for the given degree
    V = vander(X);
    V = V(:, end-degree:end);
    if verbose
        fprintf('Vandermonde matrix V prepared for the given degree:\n');
        disp(V);
    end
    
    % Solve for polynomial coefficients using MATLAB's backslash operator
    P_backslash = V \ Y;
    if verbose
        fprintf('\nSolving for polynomial coefficients P using the backslash operator (V\\Y):\n');
        fprintf('V\\Y = (%s)\\(%s) = %s\n', mat2str(V, 3), mat2str(Y', 3), mat2str(P_backslash', 3));
    end

    % Using Normal Equations
    P_normal = (V'*V)\(V'*Y);
    if verbose
        fprintf('\nSolving for polynomial coefficients P using the Normal Equations ((V''*V)\\(V''*Y)):\n');
        fprintf('(V''*V)\\(V''*Y) = (%s)\\(%s) = %s\n', mat2str(V'*V, 3), mat2str(V'*Y, 3), mat2str(P_normal', 3));
    end

    % Using QR Factorization
    [Q, R] = qr(V,0);
    P_qr = R \ (Q'*Y);
    if verbose
        fprintf('\nSolving for polynomial coefficients P using QR Factorization (R \\ (Q''*Y)):\n');
        fprintf('R \\ (Q''*Y) = (%s)\\(%s) = %s\n', mat2str(R, 3), mat2str(Q'*Y, 3), mat2str(P_qr', 3));
    end
    
    % Choose P from one of the methods for error calculation
    P = P_backslash; % Choosing backslash results for further calculations
    
    % Calculate the error of the fit
    Y_fit = V * P;
    error_norm = norm(Y - Y_fit); % Euclidean norm of residuals
    if verbose
        fprintf('Calculating the error of the fit using norm(Y - V*P):\n');
        fprintf('norm(Y - V*P) = norm(%s - %s*%s) = %s\n', mat2str(Y', 3), mat2str(V, 3), mat2str(P', 3), num2str(error_norm));
    end

    % Alternative error calculations for demonstration
    error_direct = sqrt(norm(Y)^2 - norm(V*P)^2);
    error_qr = sqrt(norm(Y)^2 - norm(Q'*Y)^2);
    if verbose
        fprintf('Alternative error calculation (direct): sqrt(norm(Y)^2 - norm(V*P)^2) = sqrt(%s^2 - %s^2) = %s\n', num2str(norm(Y)), num2str(norm(V*P)), num2str(error_direct));
        fprintf('Alternative error calculation (using QR): sqrt(norm(Y)^2 - norm(Q''*Y)^2) = sqrt(%s^2 - %s^2) = %s\n', num2str(norm(Y)), num2str(norm(Q'*Y)), num2str(error_qr));
    end

    % Final chosen error for output
    error = error_norm;

    % Display the polynomial coefficients and chosen error if verbose is true
    if verbose
        fprintf('Final Polynomial Coefficients (from highest to lowest degree):\n');
        disp(P');
        fprintf('Chosen Error of the fit: %s\n', num2str(error));
        % Display the polynomial nicely
        helper_dispPoly(flipud(P), degree); % Ensure to flip the coefficients for correct order
    end

    % Check if printFit is true and plot the line of best fit
    if printFit
        % Prepare data for plotting
        X_plot = linspace(min(X), max(X), 400); % Define a finer grid for x values for plotting
        Y_plot = polyval(P, X_plot); % Calculate the fitted Y values across the grid using the polynomial coefficients
 
        % Plot the original data points as circles and the best fit line
        figure; % Open a new figure window
        plot(X, Y, 'o', X_plot, Y_plot, '-'), grid on
        title('Best Fit Line');
        xlabel('X');
        ylabel('Y');
        legend('Original Data Points', 'Best Fit Line', 'Location', 'best');
    end
end