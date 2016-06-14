function [ Ptool_F, af67_F, S6_F ] = Forward_puma( S6, Ptool_6, phi1, th2, th3, th4, th5, th6 )
 %This function calculate the forward puma problem
 a=[0 17 0.8 0 0];
 %define a12-a56? a(1) represent a12
 af=[0.5*pi 0 1.5*pi 0.5*pi 0.5*pi];
 %define af12-af56, af(1) represent af12
 S=[0 5.9 0 17 0 S6];
 %define S2-S6, S(2) represent S2
 th=[0 th2 th3 th4 th5 th6];
 %define th2-th6, th(2) represent th2
 TF=[cos(phi1) -sin(phi1) 0 0; sin(phi1) cos(phi1) 0 0; 0 0 1 0; 0 0 0 1];
 %TF represent TF1
 T=cell(5,1);
 %define T12-T56, T{1,1} represent T12
 for i=1:5
    T{i,1}=[cos(th(i+1)) -sin(th(i+1)) 0 a(i);
        sin(th(i+1))*cos(af(i)) cos(th(i+1))*cos(af(i)) -sin(af(i)) -sin(af(i))*S(i+1);
        sin(th(i+1))*sin(af(i)) cos(th(i+1))*sin(af(i)) cos(af(i)) cos(af(i))*S(i+1);
        0 0 0 1];
 end
 TF6=TF*T{1,1}*T{2,1}*T{3,1}*T{4,1}*T{5,1};
 Ptool_F=TF6*[Ptool_6; 1];
 af67_F=TF6(1:3,1);
 S6_F=TF6(1:3,3);
end

