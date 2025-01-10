%% Questions

%{
{17. If possible write down a $3 \times 2$ system of linear equations, $A X=B$, such that


Has many solutions

Has a unique solution

Has no solutions


19. Let $A$ and $B$ be square, $n \times n$ matrices.

(a) If $A$ and $B$ are invertible is $A+B$ necessarily invertible? Explain.

(b) If $A B$ is invertible does this imply that both $A$ and $B$ are invertible?

%}



%% Answers 
%{
Sure, let's break it down:

17.
A $3 \times 2$ system of linear equations, $AX = B$, represents a system of 3 equations with 2 variables. Here are examples for each case:

- Many solutions: This happens when the system is dependent, i.e., one equation is a multiple of another. For example:

  1. $x + y = 2$
  2. $2x + 2y = 4$
  3. $3x + 3y = 6$

  This system has infinitely many solutions as all three equations represent the same line in the xy-plane.

- Unique solution: This happens when the system is independent and consistent, i.e., the equations describe different lines that intersect at a single point. For example:

  1. $x + y = 1$
  2. $x - y = 1$
  3. $2x = 2$

  This system has a unique solution at (x, y) = (1, 0).

- No solutions: This happens when the system is inconsistent, i.e., at least two of the equations represent parallel lines that do not intersect. For example:

  1. $x + y = 1$
  2. $x - y = 1$
  3. $x + y = 2$

  The first and third equations are parallel and do not intersect, so there is no solution that satisfies all three equations.

19. 
(a) If $A$ and $B$ are invertible, is $A+B$ necessarily invertible? No, not necessarily. For instance, consider two $2 \times 2$ matrices:

  $A = \begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix}$ and $B = \begin{bmatrix} -1 & 0 \\ 0 & -1 \end{bmatrix}$

  Both A and B are invertible, but $A + B = \begin{bmatrix} 0 & 0 \\ 0 & 0 \end{bmatrix}$ is not invertible because it's a zero matrix.

(b) If $AB$ is invertible, does this imply that both $A$ and $B$ are invertible? Yes, it does. If the product of two square matrices $A$ and $B$ is invertible, then both $A$ and $B$ must be invertible. This is because the inverse of $AB$ is $B^{-1}A^{-1}$, which only exists if both $B^{-1}$ and $A^{-1}$ exist, meaning both $A$ and $B$ are invertible.

%}