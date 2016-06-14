function [ phi1, th2, th3, th4, th5, th6, int_num_soln ] = ...
    Reverse_puma ( S6, tool_6, tool_F, S6_F, a67_F )
%This function calculate the reverse puma problem

% calculate close the loop values
[ a71, S7, S1, al71, th7, gam1 ] = ...
    Close_the_loop( tool_6, tool_F, S6_F, a67_F );
a = [0 17 0.8 0 0 0 a71];
al = [90 0 270 90 90 90 al71];
S = [S1 5.9 0 17 0 S6 S7];

% calculate phi1
Y7 = -sind(al(7))*cosd(al(6))-cosd(al(7))*sind(al(6))*cosd(th7);
X7 = sind(al(6))*sind(th7);
A1 = S(6)*Y7-S(7)*sind(al(7));
B1 = S(6)*X7+a(7);
D1 = S(2);
[ ~, th1_a, th1_b ] = solve_trig( A1, B1, D1 ); 
phi1_a = th1_a-gam1;
phi1_b = th1_b-gam1;
th1 = [th1_a th1_a th1_a th1_a th1_b th1_b th1_b th1_b];
phi1 = [ phi1_a phi1_a phi1_a phi1_a phi1_b phi1_b phi1_b phi1_b ];

%calculate th3
Z7 = cosd(al(7))*cosd(al(6))-sind(al(7))*sind(al(6))*cosd(th7);
th3 = [0 0 0 0 0 0 0 0];
A = [0 0];
B = [0 0];
for i = 1:2
   X71 = X7*cosd(th1(4*i-3))-Y7*sind(th1(4*i-3));
   Y71 = cosd(al(1))*(X7*sind(th1(4*i-3))+Y7*cosd(th1(4*i-3)))-sind(al(1))*Z7;
   X1 = sind(al(7))*sind(th1(4*i-3));
   Y1 = -(sind(al(1))*cosd(al(7))+cosd(al(1))*sind(al(7))*cosd(th1(4*i-3)));
   A(i) = -S(6)*X71-S(7)*X1-a(7)*cosd(th1(4*i-3));
   B(i) = S(1)-S(6)*Y71-S(7)*Y1;
   A2 = 2*a(2)*a(3);
   B2 = -2*a(2)*S(4);
   D2 = a(2)*a(2)+a(3)*a(3)+S(4)*S(4)-A(i)*A(i)-B(i)*B(i);
   [ ~, th3_a, th3_b ] = solve_trig( A2, B2, D2 );
   th3(4*i-3) = th3_a;
   th3(4*i-2) = th3_a;
   th3(4*i-1) = th3_b;
   th3(4*i) = th3_b;
end

%calculate th2
th2 = [0 0 0 0 0 0 0 0];
for i = 1:4
    D1_th2 = A(ceil(i/2));
    D2_th2 = B(ceil(i/2));
    A1_th2 = a(2)+a(3)*cosd(th3(2*i))-S(4)*sind(th3(2*i));
    B1_th2 = -a(3)*sind(th3(2*i))-S(4)*cosd(th3(2*i));
    A2_th2 = B1_th2;
    B2_th2 = -A1_th2;
    [ ~, cos_th2, sin_th2 ] = ...
        solve_pair ( A1_th2, B1_th2, D1_th2, A2_th2, B2_th2, D2_th2 );
    th2(2*i-1) = atan2d( sin_th2, cos_th2 );
    th2(2*i) = atan2d( sin_th2, cos_th2 );
end

%calculate th5
th5 = [ 0 0 0 0 0 0 0 0 ];
for i = 1:2:7
    X7 = sind(al(6))*sind(th7);
    Y7 = -sind(al(7))*cosd(al(6))-cosd(al(7))*sind(al(6))*cosd(th7);
    Z7 = cosd(al(7))*cosd(al(6))-sind(al(7))*sind(al(6))*cosd(th7);
    X71 = X7*cosd(th1(i))-Y7*sind(th1(i));
    Y71 = cosd(al(1))*(X7*sind(th1(i))+Y7*cosd(th1(i)))-sind(al(1))*Z7;
    Z71 = sind(al(1))*(X7*sind(th1(i))+Y7*cosd(th1(i)))+cosd(al(1))*Z7;
    X712 = X71*cosd(th2(i))-Y71*sind(th2(i));
    Y712 = cosd(al(2))*(X71*sind(th2(i))+Y71*cosd(th2(i)))-sind(al(2))*Z71;
    Z712 = sind(al(2))*(X71*sind(th2(i))+Y71*cosd(th2(i)))+cosd(al(2))*Z71;
    Z7123 = sind(al(3))*(X712*sind(th3(i))+Y712*cosd(th3(i)))+cosd(al(3))*Z712;
    th5(i) = acosd(-Z7123);
    th5(i+1) = -th5(i);
end

%calculate th4
th4 = [ 0 0 0 0 0 0 0 0];
for i = 1:1:8
    X7 = sind(al(6))*sind(th7);
    Y7 = -sind(al(7))*cosd(al(6))-cosd(al(7))*sind(al(6))*cosd(th7);
    Z7 = cosd(al(7))*cosd(al(6))-sind(al(7))*sind(al(6))*cosd(th7);
    X71 = X7*cosd(th1(i))-Y7*sind(th1(i));
    Y71 = cosd(al(1))*(X7*sind(th1(i))+Y7*cosd(th1(i)))-sind(al(1))*Z7;
    Z71 = sind(al(1))*(X7*sind(th1(i))+Y7*cosd(th1(i)))+cosd(al(1))*Z7;
    X712 = X71*cosd(th2(i))-Y71*sind(th2(i));
    Y712 = cosd(al(2))*(X71*sind(th2(i))+Y71*cosd(th2(i)))-sind(al(2))*Z71;
    Z712 = sind(al(2))*(X71*sind(th2(i))+Y71*cosd(th2(i)))+cosd(al(2))*Z71;
    X7123 = X712*cosd(th3(i))-Y712*sind(th3(i));
    Y7123 = cosd(al(3))*(X712*sind(th3(i))+Y712*cosd(th3(i)))-sind(al(3))*Z712;
    th4(i) = atan2d( -Y7123/sind(th5(i)), X7123/sind(th5(i)) );
end

%calculate th6
th6 = [ 0 0 0 0 0 0 0 0 ];
for i = 1:1:8
    X4 = sind(al(4))*sind(th4(i));
    Y4 = -sind(al(3))*cosd(al(4))-cosd(al(3))*sind(al(4))*cosd(th4(i));
    Z4 = cosd(al(3))*cosd(al(4))-sind(al(3))*sind(al(4))*cosd(th4(i));
    X43 = X4*cosd(th3(i))-Y4*sind(th3(i));
    Y43 = cosd(al(2))*(X4*sind(th3(i))+Y4*cosd(th3(i)))-sind(al(2))*Z4;
    Z43 = sind(al(2))*(X4*sind(th3(i))+Y4*cosd(th3(i)))+cosd(al(2))*Z4;
    X432 = X43*cosd(th2(i))-Y43*sind(th2(i));
    Y432 = cosd(al(1))*(X43*sind(th2(i))+Y43*cosd(th2(i)))-sind(al(1))*Z43;
    Z432 = sind(al(1))*(X43*sind(th2(i))+Y43*cosd(th2(i)))+cosd(al(1))*Z43;
    X4321 = X432*cosd(th1(i))-Y432*sind(th1(i));
    Y4321 = cosd(al(7))*(X432*sind(th1(i))+Y432*cosd(th1(i)))-sind(al(7))*Z432;
    Z4321 = sind(al(7))*(X432*sind(th1(i))+Y432*cosd(th1(i)))+cosd(al(7))*Z432;
    X43217 = X4321*cosd(th7)-Y4321*sind(th7);
    Y43217 = cosd(al(4))*(X4321*sind(th7)+Y4321*cosd(th7))-sind(al(4))*Z4321;
    th6(i) = atan2d( X43217, Y43217 );
end

% just minus 360 degrees to the answers which are over 180, it will not
% influence the result
for i = 1:1:8
    if phi1(i) > 180
        phi1(i) = phi1(i)-360;
    end
    if th2(i) > 180
        th2(i) = th2(i)-360;
    end
    if th3(i) > 180
        th3(i) = th3(i)-360;
    end
    if th4(i) > 180
        th4(i) = th4(i)-360;
    end
    if th5(i) > 180
        th5(i) = th5(i)-360;
    end
    if th6(i) > 180
        th6(i) = th6(i)-360;
    end
end
%check the real answers and set int_num_soln, pack the real answers to the
%front array positions
int_num_soln = 8;
find_real = [ 0 0 0 0 0 0 0 0 ];
for i = 1:1:8
    if isreal(phi1(i)) && isreal(th2(i)) && isreal(th3(i)) ...
            && isreal(th4(i)) && isreal(th5(i)) && isreal(th6(i))
        find_real(i) = 1;
    end
end
for i = 1:1:8
    if find_real(i) == 0;    
    int_num_soln = int_num_soln - 1;
        for j = i:1:7
            phi1(j) = phi1(j+1);
            th2(j) = th2(j+1);
            th3(j) = th3(j+1);
            th4(j) = th4(j+1);
            th5(j) = th5(j+1);
            th6(j) = th6(j+1);
        end
    end
end
        
end
