close all;
clear all;
clc;
s=11;
l=1
mat=[0,0,0,0,0,0,0,0,0,0];
while l<s
    HESS_EV
    ans=Score;
    mat(1,l)= ans
    l=l+1;    
end
mat=mat'
