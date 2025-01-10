function [vertex_power, row_sums, order] = powerRank_and_Order(M, verbose)
    % Step 3: Calculate the 2-step reachability matrix (M^2)
    M2 = M^2;
    if verbose
        disp('2-step Reachability Matrix (M^2):');
        disp(M2);
    end

    % Step 4: Calculate the power of each vertex (M^2 + M)
    vertex_power = M2 + M;
    if verbose
        disp('Power of Each Vertex (M^2 + M):');
        disp(vertex_power);
    end

    % Step 5: Calculate the sum of each row in vertex_power
    row_sums = sum(vertex_power, 2);
    if verbose
        disp('Sum of Each Row:');
        disp(row_sums);
    end

    % Step 6: Rank the rows in descending order of their sums
    [sorted_sums, order] = sort(row_sums, 'descend');
    if verbose
        disp('Rows Ranked by Descending Order of Sums:');
        disp(order);
    end
end
