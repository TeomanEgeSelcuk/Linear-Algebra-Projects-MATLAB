% function [isSubspace, filteredPolynomials] = isSubspacePoly(polynomials, properties, verbose)
%     if nargin < 3
%         verbose = true; % Default to verbose if not specified
%     end
% 
%     syms x; % Define the symbolic variable
%     polynomialVals = cellfun(@str2sym, polynomials, 'UniformOutput', false);
%     filteredPolynomials = {};
% 
%     if verbose
%         fprintf('Step 1: Check each polynomial against the given properties.\n');
%     end
% 
%     % Check each polynomial for the given properties
%     for i = 1:length(polynomialVals)
%         allPropsSatisfied = true;
%         if verbose
%             fprintf('Checking Polynomial P%d(x) = %s:\n', i, char(polynomialVals{i}));
%         end
% 
%         for j = 1:length(properties)
%             if ~properties{j}(polynomialVals{i})
%                 allPropsSatisfied = false;
%                 if verbose
%                     fprintf('\tFails on property %d.\n', j);
%                 end
%                 break;
%             elseif verbose
%                 fprintf('\tSatisfies property %d.\n', j);
%             end
%         end
% 
%         if allPropsSatisfied
%             filteredPolynomials{end+1} = polynomialVals{i};
%             if verbose
%                 fprintf('Polynomial P%d(x) is included for subspace tests.\n', i);
%             end
%         else
%             if verbose
%                 fprintf('Polynomial P%d(x) is excluded from subspace tests.\n', i);
%             end
%         end
%     end
% 
%     % Subspace tests if filtered set is non-empty
%     if isempty(filteredPolynomials)
%         isSubspace = false;
%         if verbose
%             fprintf('No polynomials satisfy all properties. Therefore, not a subspace.\n');
%         end
%         return;
%     end
% 
%     isSubspace = true; % Assume true until proven otherwise
%     if verbose
%         fprintf('Step 2: Verify closure under addition and scalar multiplication for filtered polynomials.\n');
%     end
% 
%     % Closure under addition
%     for i = 1:length(filteredPolynomials)
%         for j = i:length(filteredPolynomials)
%             if ~properties{1}(filteredPolynomials{i} + filteredPolynomials{j})
%                 isSubspace = false;
%                 if verbose
%                     fprintf('Closure under addition failed between P%d(x) and P%d(x).\n', i, j);
%                 end
%                 return;
%             end
%         end
%     end
% 
%     % Closure under scalar multiplication
%     testScalars = [-10, -1, 0, 1, 10]; % Some test scalars
%     for i = 1:length(filteredPolynomials)
%         for k = testScalars
%             if ~properties{1}(k * filteredPolynomials{i})
%                 isSubspace = false;
%                 if verbose
%                     fprintf('Closure under scalar multiplication failed for P%d(x) with scalar %d.\n', i, k);
%                 end
%                 return;
%             end
%         end
%     end
% 
%     if isSubspace && verbose
%         fprintf('========================\n');
%         fprintf('The set of polynomials is a subspace of the vector space of all polynomials.\n');
%         fprintf('1. Closed under addition:\n');
%         fprintf('    If P(x) and Q(x) are in S, then they satisfy the given properties.\n');
%         fprintf('    Then for the sum of P(x) and Q(x), we have (P+Q) still satisfies the properties.\n');
%         fprintf('    So, the sum of P(x) and Q(x) is also in S, which means S is closed under addition.\n\n');
%         fprintf('2. Closed under scalar multiplication:\n');
%         fprintf('    Given P(x) in S, it satisfies the given properties.\n');
%         fprintf('    Then for any scalar k, we have (kP) still satisfies the properties.\n');
%         fprintf('    So, the scalar multiple of P(x) is also in S, which means S is closed under scalar multiplication.\n');
%     end
% end

% function [isSubspace, filteredPolynomials] = isSubspacePoly(polynomials, properties, propertyFcnArray, verbose)
%     % Default to verbose if not specified
%     if nargin < 4
%         verbose = true;
%     end
% 
%     % Validate propertyFcnArray structure
%     if size(propertyFcnArray, 2) ~= 2
%         error('Invalid property function array. Each row must contain 2 elements.');
%     end
% 
%     % Define symbolic variable
%     syms x; % Symbolic variable for mathematical operations
%     % Convert input polynomials to symbolic expressions
%     polynomialVals = cellfun(@str2sym, polynomials, 'UniformOutput', false);
%     filteredPolynomials = {}; % List of polynomials that satisfy the given properties
% 
%     if verbose
%         disp('Step 1: Filtering polynomials based on given properties.');
%     end
% 
%     % Check each polynomial for the given properties
%     for i = 1:length(polynomialVals)
%         allPropsSatisfied = true;
% 
%         % Evaluate each property function for the current polynomial
%         for j = 1:size(propertyFcnArray, 1) % Use size to get the number of rows
%             x_val = propertyFcnArray(j, 1); % Extract x-value
%             expected_val = propertyFcnArray(j, 2); % Extract expected result
% 
%             % Check if the polynomial satisfies the expected condition at x_val
%             if subs(polynomialVals{i}, x, x_val) ~= expected_val 
%                 allPropsSatisfied = false;
%                 break;
%             end
%         end
% 
%         % If the polynomial satisfies all properties, add it to filteredPolynomials
%         if allPropsSatisfied
%             filteredPolynomials{end + 1} = polynomialVals{i}; % Add to the list
%         end
%     end
% 
%     % If no polynomials satisfy the given properties, it's not a subspace
%     if isempty(filteredPolynomials)
%         isSubspace = false;
%         if verbose
%             disp('No polynomials satisfy all given properties. Not a subspace.');
%         end
%         return;
%     end
% 
%     % Display all valid polynomials
%     if verbose
%         disp('Valid polynomials:');
%         for i = 1:length(filteredPolynomials)
%             disp(char(filteredPolynomials{i}));
%         end
%     end
% 
%     % Test closure under addition and scalar multiplication
%     isSubspace = true;
% 
%     if verbose
%         disp('========================');
%         disp('The set of polynomials is a subspace of the vector space of all polynomials.');
% 
%         % Generate explanation for closure under addition and scalar multiplication
%         explanation = 'Let S be the set of all polynomials P(x) in V such that ';
% 
%         % Closure under addition
%         explanation = [explanation, sprintf('\n\n1. Closed under addition:\n\nIf P(x) and Q(x) are in S, then they should meet expected values.')];
% 
%         % Using propertyFcnArray to generate explanation
%         for j = 1:size(propertyFcnArray, 1) % Loop through each property
%             x_val = propertyFcnArray(j, 1); % Extract x-value
%             expected_val = propertyFcnArray(j, 2); % Extract expected value
% 
%             explanation = [explanation, sprintf('P(%g) = %g and Q(%g) = %g. ', x_val, expected_val, x_val, expected_val)];
%             explanation = [explanation, sprintf('Therefore, (P + Q)(%g) should meet these expected conditions.')];
%         end
% 
%         % Closure under scalar multiplication
%         explanation = [explanation, sprintf('\n\n2. Closed under scalar multiplication:\n\nGiven P(x) in S, scalar multiplication should also meet these expected conditions.\n\n')];
% 
%         explanation = [explanation, 'Therefore, S is a subspace of V.'];
% 
%         disp(explanation); % Display the explanation
%     end
% end
% 

%{
    if isSubspace && verbose
        disp('========================');
        disp('The set of polynomials is a subspace of the vector space of all polynomials.');
        
        % Generate dynamic explanation for closure under addition and scalar multiplication
        explanation = '';
        for i = 1:length(properties)
            explanation = [explanation, sprintf('Let S be the set of all polynomials P(x) in V such that ')];
            for j = 1:i-1
                explanation = [explanation, sprintf('%s, ', 'property description')];
            end
            explanation = [explanation, sprintf('%s.', 'property description')];
            explanation = [explanation, sprintf('\n\n1. Closed under addition:\n\nIf P(x) and Q(x) are in S, then ')];
            for j = 1:i
                explanation = [explanation, sprintf('P(%d) = 0 and Q(%d) = 0. ', 2, 2)];
            end
            explanation = [explanation, sprintf('\nThen for the sum of P(x) and Q(x), we have (P+Q)(%d) = P(%d) + Q(%d) = 0 + 0 = 0.', 2, 2, 2)];
            explanation = [explanation, sprintf('\nSo, the sum of P(x) and Q(x) is also in S, which means S is closed under addition.\n\n')];
            
            explanation = [explanation, sprintf('2. Closed under scalar multiplication:\n\nGiven P(x) in S, we have ')];
            for j = 1:i
                explanation = [explanation, sprintf('P(%d) = 0 and ', 2)];
            end
            explanation = [explanation, sprintf('\nThen for any scalar k, we have (kP)(%d) = kP(%d) = k*0 = 0.', 2, 2)];
            explanation = [explanation, sprintf('\nSo, the scalar multiple of P(x) is also in S, which means S is closed under scalar multiplication.\n\n')];
            
            explanation = [explanation, 'Therefore, S is a subspace of V.'];
        end
        disp(explanation);
    end
%}


% function writeSubspaceofVectors(polynomials, points, n, verbose)
%     % This function checks which polynomials, when evaluated with the
%     % x-values from the given points, produce the expected y-values.
%     % It also checks the sum rule and scalar multiplication rule for the points.
% 
%     % Symbolic variable for evaluating polynomials and scalar multiplication
%     x = sym('x');
%     k = sym('k');  % Scalar for scalar multiplication check
% 
%     % List to store the polynomials that meet the criteria
%     matchingPolynomials = {};
% 
%     % Iterate through each polynomial to check against all points
%     for i = 1:length(polynomials)
%         % Assume the polynomial meets all point criteria
%         all_points_match = true;
% 
%         for j = 1:length(points)
%             % Extract x and y values from the point
%             x_val = points{j}{1};
%             y_val = points{j}{2};
% 
%             % Evaluate the polynomial with the given x value
%             poly_result = double(subs(polynomials{i}, x, x_val));
% 
%             % If the result doesn't match the expected y value, it fails
%             if poly_result ~= y_val
%                 all_points_match = false;  % The polynomial doesn't meet all criteria
%                 break;  % Exit checks if it fails
%             end
%         end
% 
%         % If it meets all point criteria, add it to matchingPolynomials
%         if all_points_match
%             matchingPolynomials{end + 1} = char(polynomials{i});  % Store the matching polynomial
%         end
%     end
% 
%     % Check the sum rule
%     if verbose && ~isempty(matchingPolynomials)
%         fprintf('Subspace Verification:\nChecking the sum rule:');
%         for i = 1:length(points)
%             x_val = points{i}{1};
%             y_val = points{i}{2};
% 
%             % Check if the sum of y values matches expected output
%             sum_y = sum(cellfun(@(pt) pt{2}, points));  % Sum of all y values
% 
%             if 2 * y_val ~= sum_y
%                 fprintf('(P+Q)(x) not equal P(x) + Q(x) = y + y = 2 * y\n');
%                 fprintf('Sum rule failed at point (%d, %d)\n', x_val, y_val);
%             else
%                 fprintf('(P+Q)(x) = P(x) + Q(x) = y + y = 2 * y\n');
%                 fprintf('Sum rule passed at point (%d, %d)\n', x_val, y_val);
%             end
%         end
%     end
% 
%     % Check scalar multiplication
%     if verbose && ~isempty(matchingPolynomials)
%         disp('Checking scalar multiplication:');
%         scalar_result_matches = true;
% 
%         for i = 1:length(points)
%             x_val = points{i}{1};
%             y_val = points{i}{2};
% 
%             % Scalar multiplication with symbolic scalar `k`
%             scalar_result = k * y_val;
% 
%             % If k * y does not match expected y, it fails
%             if scalar_result ~= y_val
%                 scalar_result_matches = false;
%                 fprintf('P(x) in S -> P(x) = y, for scalar k we have\n');
%                 fprintf('(kP)(x) not equal k * P(x) = k * y = y\n');
%                 fprintf('Scalar multiplication failed at point (%d, %d)\n', x_val, y_val);
%                 break;
%             end
%         end
% 
%         if scalar_result_matches
%             fprintf('P(x) in S -> P(x) = y, for scalar k we have\n');
%             fprintf('(kP)(x) = k * P(x) = k * y = y\n');
%             fprintf('Scalar multiplication passed for all points.\n');
%         end
%     end
% 
%     % If verbose, print the polynomials that meet all point criteria
%     if verbose && ~isempty(matchingPolynomials)
%         disp('Polynomials that match all point criteria:');
%         for k = 1:length(matchingPolynomials)
%             fprintf(' - %s\n', matchingPolynomials{k});  % Display matching polynomials
%         end
%     elseif verbose
%         disp('No polynomials meet all point criteria.');
%     end
% 
%     % Return the list of polynomials that meet all property criteria
% end
% 

function writeSubspaceofVectors(polynomials, propertyFcnArray, n, verbose)
    % This function checks which polynomials, when evaluated with the
    % x-values from the given points, produce the expected y-values.
    % It also checks the sum rule and scalar multiplication rule for the points.
    % Disable all warnings
    warning('off', 'all');
    
    % Symbolic variable for evaluating polynomials and scalar multiplication
    x_sym = sym('x');  % Symbolic variable
    k = sym('k');  % Scalar for scalar multiplication check

    % Extract the x and y coordinates as numeric arrays
    x = cellfun(@(p) double(p{1}), propertyFcnArray);
    y = cellfun(@(p) double(p{2}), propertyFcnArray);

    % List to store the polynomials that meet the criteria
    matchingPolynomials = {};

    % Iterate through each polynomial to check against all points
    for i = 1:length(polynomials)
        % Assume the polynomial meets all point criteria
        all_points_match = true;

        for j = 1:length(propertyFcnArray)
            % Extract x and y values from the point
            x_val = double(propertyFcnArray{j}{1});
            y_val = double(propertyFcnArray{j}{2});

            % Evaluate the polynomial with the given x value
            poly_result = double(subs(polynomials{i}, x_sym, x_val));

            % If the result doesn't match the expected y value, it fails
            if poly_result ~= y_val
                all_points_match = false;  % The polynomial doesn't meet all criteria
                break;  % Exit checks if it fails
            end
        end

        % If it meets all point criteria, add it to matchingPolynomials
        if all_points_match
            matchingPolynomials{end + 1} = char(polynomials{i});  % Store the matching polynomial
        end
    end

    % Check the sum rule
    if verbose && ~isempty(matchingPolynomials)
        fprintf('Subspace Verification:\nChecking the sum rule:\n');
        for i = 1:length(propertyFcnArray)
            x_val = double(propertyFcnArray{i}{1});
            y_val = double(propertyFcnArray{i}{2});

            % Check if the sum of y values matches expected output
            sum_y = sum(cellfun(@(pt) double(pt{2}), propertyFcnArray));  % Sum of all y values

            if 2 * y_val ~= sum_y
                fprintf('(P+Q)(x) not equal P(x) + Q(x) = y + y = 2 * y\n');
                fprintf('Sum rule failed at point (%d, %d)\n', x_val, y_val);
            else
                fprintf('(P+Q)(x) = P(x) + Q(x) = y + y = 2 * y\n');
                fprintf('Sum rule passed at point (%d, %d)\n', x_val, y_val);
            end
        end
    end

    % Check scalar multiplication
    if verbose && ~isempty(matchingPolynomials)
        disp('Checking scalar multiplication:');
        scalar_result_matches = true;

        for i = 1:length(propertyFcnArray)
            x_val = double(propertyFcnArray{i}{1});
            y_val = double(propertyFcnArray{i}{2});

            % Scalar multiplication with symbolic scalar `k`
            scalar_result = k * y_val;

            if scalar_result ~= y_val
                scalar_result_matches = false;
                fprintf('Scalar multiplication failed at point (%d, %d)\n', x_val, y_val);
                break;
            end
        end

        if scalar_result_matches
            fprintf('Scalar multiplication passed for all points.\n');
        end
    end

    % If verbose, print the polynomials that meet all point criteria
    if verbose && ~isempty(matchingPolynomials)
        disp('Polynomials that match all point criteria:');
        for k = 1:length(matchingPolynomials)
            fprintf(' - %s\n', matchingPolynomials{k});  % Display matching polynomials
        end
    elseif verbose
        disp('No polynomials meet all point criteria.');
    end

    % If there are matching polynomials and `n` is greater than zero
    if ~isempty(matchingPolynomials) && exist('n', 'var') && n > 0
        % Generate and display polynomials from degree 1 to n
        polynomials = {};
        fprintf('=======Basis for S =====\n');
        fprintf('1. Linear Independence:\n');
        fprintf('  Suppose we have a linear combination of these polynomials equal to the zero polynomial:\n');
        fprintf('  a_1P_1 + a_2P_2 + a_3P_3 = 0\n');
        fprintf('  This implies that the polynomial P(x) = a_1(x-x1) + a_2(x-x1)^2 + a_3(x-x1)^3 .... = 0\n');
        fprintf('  An nth degree polynomial can only be identically zero if all its coefficients are zero.\n');
        fprintf('  Therefore, a_1 = a_2 = a_3 = 0 ... a_n = 0, which shows that the polynomials P_1, P_2, P_3 are linearly independent.\n');
        fprintf('\n2. Spanning:\n');
        fprintf('  Any polynomial P(x) in S can be written as\n');
        fprintf('  P(x) = a(x-x1) + b(x-x1)^2 + c(x-x1)^3 ... \n');
        fprintf('  for some scalars a, b, c....\n');
        fprintf('  This shows that the polynomials P_1, P_2, P_3 ... P_n span S.\n');
        fprintf('  Therefore, the polynomials P_1(x) = (x-x1), P_2(x) = (x-x1)^2, P_3(x) = (x-x1)^3 .... form a basis for S.\n');
                for d = 1:n
            % Fit the polynomial of degree d
            p = polyfit(x, y, d);

            % Create the polynomial as a symbolic expression
            terms = arrayfun(@(coef, pow) sprintf('%.2f * x^%d', coef, pow), p, (length(p)-1):-1:0, 'UniformOutput', false);
            polynomial = strjoin(terms, ' + ');

            % Store the polynomial in the list
            polynomials{end + 1} = polynomial;

            % Display the polynomial coefficients for degree d
            fprintf('       Polynomial of degree %d: %s\n', d, polynomial);
        end
    end
end
