%HESS optimization Function MATLAB Code
%@Fabian Cheruiyot, Department of Electrical and Information Engineering University Of Nairobi
N=60;           %initialize number of search agents
Max_iter=100;   %initialize number of iterations
lb=0;           %set lower boundary
ub=1;           %set upper boundary
dim=1;          %number of problem dimensions = 1
fobj=@F1;       %select F1 as objective function optimized 

    %select optimization algorithm%
%[Ibat,Ic,Eb,Euc,Best_score,Best_pos,SSA_cg_curve]=MSSSA(N,Max_iter,lb,ub,dim,fobj,Edemand,SOCbat,SOCuc,Quc,Cuc,Vuc,Vbat,Ib,t);
%[Ibat,Ic,Eb,Euc,Best_score,Best_pos,SSA_cg_curve]=SSA(N,Max_iter,lb,ub,dim,fobj,Edemand,SOCbat,SOCuc,Quc,Cuc,Vuc,Vbat,Ib,t);
%[Ibat,Ic,Eb,Euc,Best_score,Best_pos,SSA_cg_curve]=MFO(N,Max_iter,lb,ub,dim,fobj,Edemand,SOCbat,SOCuc,Quc,Cuc,Vuc,Vbat,Ib,t);
%[Ibat,Ic,Euc,Eb,o]=F1(0.9,Edemand,SOCbat,SOCuc,Quc,Cuc,Vuc,Vbat,Ib,t);
[Ibat,Ic,Eb,Euc,gBestScore,gBest,cg_curve]=PSO(N,Max_iter,lb,ub,dim,fobj,Edemand,SOCbat,SOCuc,Quc,Cuc,Vuc,Vbat,Ib,t);
%[Ibat,Ic,Eb,Euc,Best_score,Best_pos,cg_curve]=DA(N,Max_iter,lb,ub,dim,fobj,Edemand,SOCbat,SOCuc,Quc,Cuc,Vuc,Vbat,Ib,t);
%[Ibat,Ic,Eb,Euc,Leader_score,Leader_pos,Convergence_curve]=WOA(N,Max_iter,lb,ub,dim,fobj,Edemand,SOCbat,SOCuc,Quc,Cuc,Vuc,Vbat,Ib,t)

% HESS Model objective function
function [Ibat,Ic,Eb,Euc,o]=F1(x,Edemand,SOCbat,SOCuc,Quc,Cuc,Vuc,Vbat,Ib,t)
Rb=20000;
Ruc=700;
if Edemand(t) > 0
    Pb  = Edemand(t)*x;
    Puc = Edemand(t)*(1-x);
else
    Pb  = 0;
    Puc =  0;
end
Vuc(t)=(0.5*Quc(t-1)/Cuc)+sqrt((0.25*(Quc(t-1)/Cuc)^2)-Puc*Ruc);
Ic=Puc/Vuc(t);
a= Rb;
b=-Vbat(t);
c=Pb;
d=(sqrt((b^2)-4*a*c)); % Can be complex with no problem.
r1= (-b-d)/(2*a);
r2= (-b+d)/(2*a);
if r1>0
    Ibat=r1;
else
    Ibat=r2;
end   
Eb = abs(Ibat)*(Vbat(t).*cos(angle(Ibat))+Rb);
Euc = abs(Ic).*(Vuc(t).*cos(angle(Ic))+Ruc);
o = sum(abs(Eb)+abs(Euc));
end
