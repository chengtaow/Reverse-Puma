function [ a71, S7, S1, al71, th7, gam1 ] = ...
    Close_the_loop( Ptool_6, Ptool_F, S6_F, a67_F )
% This function calculate the close the loop problem
i=[1;0;0];
j=[0;1;0];
k=[0;0;1];
P6orig_F=Ptool_F-dot(Ptool_6,i)*a67_F ...
    -dot(Ptool_6,j)*cross(S6_F,a67_F)-dot(Ptool_6,k)*S6_F;
S7_F=cross(a67_F,S6_F);
S1_F=[0;0;1];

if cross(S7_F,S1_F)==zeros(3,1)
    al71=0;
    S7=0;
    S1=-dot(P6orig_F,S1_F);
    if S1*S1_F+P6orig_F==zeros(3,1)
        %When S1 and S7 collinear
        a71=0;
        th7=0;
        a71_F=a67_F;
        cos_gam1=dot(a71_F,i);
        sin_gam1=dot(cross(a71_F,i),S1_F);
        gam1=atan2(sin_gam1,cos_gam1)*180/pi;
    else
        %When S1 and S7 parallel
        a71=-norm(-(P6orig_F+S1*S1_F));
        a71_F=-(P6orig_F+S1*S1_F)/a71;
        cos_th7=dot(a67_F,a71_F);
        sin_th7=dot(cross(a67_F,a71_F),S7_F);
        th7=atan2(sin_th7,cos_th7)*180/pi;
        cos_gam1=dot(a71_F,i);
        sin_gam1=dot(cross(a71_F,i),S1_F);
        gam1=atan2(sin_gam1,cos_gam1)*180/pi;
    end
else
    %genearal solutions
    a71_F=cross(S7_F,S1_F)/norm(cross(S7_F,S1_F));
    cos_al71=dot(S7_F,S1_F);
    sin_al71=dot(cross(S7_F,S1_F),a71_F);
    al71=atan2(sin_al71,cos_al71)*180/pi;
    cos_th7=dot(a67_F,a71_F);
    sin_th7=dot(cross(a67_F,a71_F),S7_F);
    th7=atan2(sin_th7,cos_th7)*180/pi;
    cos_gam1=dot(a71_F,i);
    sin_gam1=dot(cross(a71_F,i),S1_F);
    gam1=atan2(sin_gam1,cos_gam1)*180/pi;
    S7=dot(cross(S1_F,P6orig_F),a71_F)/sin_al71;
    a71=dot(cross(P6orig_F,S1_F),S7_F)/sin_al71;
    S1=dot(cross(P6orig_F,S7_F),a71_F)/sin_al71;
end

end