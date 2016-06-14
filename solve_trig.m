function [ int_x, ang_a, ang_b ] = solve_trig( A, B, D )
%This function calculate trigonometric solution
%Of equation Ac1+Bs1+D=0
    gam=atan2(B/sqrt(A^2+B^2),A/sqrt(A^2+B^2));
    th1_minus_gam=acos(-D/sqrt(A^2+B^2));
    ang_a=(th1_minus_gam+gam)*180/pi;
    ang_b=(2*pi-th1_minus_gam+gam)*180/pi;
    if ang_a>=360
        ang_a=ang_a-360;
    end
    if ang_b>=360
        ang_b=ang_b-360;
    end
    int_x=isreal(ang_a)&&isreal(ang_b)&&(A~=0||B~=0);
        
end

