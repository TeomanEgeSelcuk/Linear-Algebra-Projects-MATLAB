function FindEquations()
    syms a1 a2 a3 a4 x;  % Define symbolic variables

    % Define the polynomial with x^2 isolated on one side
    poly = a1 + a4*(x^3 + x^2 + x + 1) + a3*(x^2 + x + 1) + a2*(x + 1) - x^3;

    % Expand the polynomial to simplify it
    poly = expand(poly);

    % Collect terms of polynomial as coefficients of powers of x
    % Coefficients for x^3, x^2, x^1, x^0
    c = coeffs(poly, x, 'All');  % Only two arguments are needed here

    % Coefficients expected to be zero or given values
    target_coeffs = [0, 0, 0, 0];  % 0*x^3 + 0*x^2 + 0*x + 0 for all powers

    % Generate equations from the coefficients
    equations = [];
    n = length(target_coeffs);
    if length(c) < n
        c = [sym(zeros(1, n-length(c))), c];  % Pad with zeros if fewer coefficients than expected
    end

    for i = 1:n
        equations = [equations, c(i) == target_coeffs(i)];
    end

    % Solve the equations for a1, a2, a3, a4
    sol = solve(equations, [a1, a2, a3, a4])

    % Display the solution
    disp('The solutions for a1, a2, a3, a4 are:');
    % disp([sol.a1, sol.a2, sol.a3, sol.a4]);
end



% function FindEquations()
%     syms a1 a2 a3 a4 x;  % Define symbolic variables
% 
%     % Define the equation with all terms on one side (zero on the other side)
%     eqn = a1 + a4*(x^3 + x^2 + x + 1) + a3*(x^2 + x + 1) + a2*(x + 1) == x^2;
% 
%     % Expand the equation to simplify it and correctly distribute all terms
%     eqn = expand(eqn);
% 
%     % Collect coefficients for the system of linear equations
%     [A, B] = equationsToMatrix(eqn, [a1, a2, a3, a4])
% 
%     % Solve the linear system
%     sol = linsolve(A, B);
% 
%     % Display the solution
%     disp('The solutions for a1, a2, a3, a4 are:');
%     disp(sol);
% end



% function [b,p] = FindCoeefs(expr, n)
%     for j=1:n
%         eval(sprintf('x%d=0;',j));
%     end
%     b = eval([expr ';']);
% 
%     p = zeros(1,n);
%     for i=1:n
%         for j=1:n
%             eval(sprintf('x%d=0;',j));
%         end
%         eval(sprintf('x%d=1;',i));
% 
%         p(i) = eval([expr ';']) - b;    
%     end
% 
% end