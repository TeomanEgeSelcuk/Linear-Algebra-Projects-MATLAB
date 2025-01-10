% Step 1: Define the matrix M
M = [0 1 0 1 1 1;
     0 0 1 1 1 0;
     1 0 0 1 0 0;
     0 0 0 0 1 0;
     0 0 1 0 0 1;
     0 1 1 1 0 0];

% Step 2: Print the matrix M
disp('Matrix M:');
disp(M);

% Step 3: Calculate the 2-step reachability matrix (M^2) and print it
M2 = M^2;
disp('2-step Reachability Matrix (M^2):');
disp(M2);

% Step 4: Calculate the power of each vertex (M^2 + M) and print it
vertex_power = M2 + M;
disp('Power of Each Vertex (M^2 + M):');
disp(vertex_power);

% Step 5: Calculate the sum of each row in vertex_power
row_sums = sum(vertex_power, 2);
disp('Sum of Each Row:');
disp(row_sums);

% Step 6: Rank the rows in descending order of their sums and print the order
[sorted_sums, order] = sort(row_sums, 'descend');
disp('Rows Ranked by Descending Order of Sums:');
disp(order);
