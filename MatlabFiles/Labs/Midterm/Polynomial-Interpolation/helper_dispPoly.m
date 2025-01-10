% Function to display polynomial
function helper_dispPoly(solution, degree)
    str = "P(x) = ";
    for i = 1:length(solution)
        coef = solution(i);
        if coef ~= 0
            if i == 1
                str = [str, sprintf('%.4f', coef)];
            elseif i == 2
                str = [str, sprintf(' + %.4fx', coef)]; % Fixed sign for consistency
            else
                if coef > 0
                    str = [str, sprintf(' + %.4fx^%d', coef, i-1)];
                else
                    str = [str, sprintf(' - %.4fx^%d', abs(coef), i-1)];
                end
            end
        end
    end
    disp(str);
end