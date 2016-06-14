function [ int_x, x, y ] = solve_pair ( A1, B1, D1, A2, B2, D2 )
%This funtion calculate the only one solution of two equations
    Matrix=[A1 B1; A2 B2]\[D1; D2];
    x=Matrix(1,1);
    y=Matrix(2,1);
    int_x=~(A1*B2-A2*B1==0);

end

