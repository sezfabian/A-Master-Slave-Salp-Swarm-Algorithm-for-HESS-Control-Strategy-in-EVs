close all;
clear all;
clc;
s=11;
lmain=1
mat=[0,0,0,0,0,0,0,0,0,0];
while lmain<s
    HESS_EV
    ans=Score;
    mat(1,lmain)= ans
    lmain=lmain+1;    
end
mat=sort(mat);
mat=mat'