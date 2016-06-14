% This main program is used to input values to calculate the reverse puma
% and print the result. It will also check the results and print it.
clc;
clear all;
%input values
%
S6 = input('Type S6(Unit:inches):');
tool_6 = input('Type tool_6(Unit:inches):');
tool_F = input('Type tool_F(Unit:inches):');
S6_F = input('Type S6_F(Unit:inches, It must be a unit vector):');
a67_F = input('Type a67_F(Unit:inches, It must be a unit vector):');
%}
%calculate the reverse puma
%{
%The input example in the text book
S6 = 4;
tool_6 = [5; 3; 7];
tool_F = [24.112; 20.113; 18.167];
S6_F = [0.079; -0.787; 0.612];
a67_F = [0.997; 0.064; -0.047];
%}
[ phi1, th2, th3, th4, th5, th6, int_num_soln ] = ...
    Reverse_puma ( S6, tool_6, tool_F, S6_F, a67_F );
fprintf('Print the result: \n');
fprintf('There are %2.0f solutions \n', int_num_soln);
for i = 1:1:int_num_soln
    fprintf('Solution: %2.0f \n',i);
    fprintf('phi1= %5.4f,', phi1(i));
    fprintf(' th2= %5.4f,', th2(i));
    fprintf(' th3= %5.4f,', th3(i));
    fprintf(' th4= %5.4f,', th4(i));
    fprintf(' th5= %5.4f,', th5(i));
    fprintf(' th6= %5.4f \n', th6(i));
end
%now check result
fprintf('Now print the solution of forward puma to check calculation \n');
for i = 1:1:int_num_soln
    [ tool_F, a67_F, S6_F ] = Forward_puma...
        ( S6, tool_6, phi1(i)*pi/180, th2(i)*pi/180, th3(i)*pi/180,...
        th4(i)*pi/180, th5(i)*pi/180, th6(i)*pi/180 );
    fprintf('Solution: %2.0f \n',i);
    fprintf('tool_F is [ %5.3f; %5.3f; %5.3f; %2.0f ] inches\n',tool_F);
    fprintf('a67_F is [ %5.3f; %5.3f; %5.3f ] inches\n' ,a67_F);
    fprintf('S6_F is [ %5.3f; %5.3f; %5.3f ] inches\n',S6_F);
end
