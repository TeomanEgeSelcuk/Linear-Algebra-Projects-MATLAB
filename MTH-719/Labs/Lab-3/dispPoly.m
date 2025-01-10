% Function to display polynomial
function dispPoly(solution, degree)
    str = "P(x) = ";
    for i = 1:length(solution)
        coef = solution(i);
        if coef ~= 0
            if i == 1
                str = [str, sprintf('%.2f', coef)];
            elseif i == 2
                str = [str, sprintf(' + %.2fx', coef)]; % Fixed sign for consistency
            else
                if coef > 0
                    str = [str, sprintf(' + %.2fx^%d', coef, i-1)];
                else
                    str = [str, sprintf(' - %.2fx^^d', abs(coef), i-1)];
                end
            end
        end
    end
    disp(str);
end