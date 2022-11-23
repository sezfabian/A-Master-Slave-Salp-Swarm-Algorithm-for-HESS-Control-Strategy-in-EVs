close all;
clear all;
clc;
s=11;
l=1
mat=[0,0,0,0,0,0,0,0,0,0];
while l<s
    Function_name='F20';
    main;
    ans=Best_score;
    mat(1,l)= ans
    l=l+1;    
end
mat=sort(mat);
mat=mat'
writematrix(mat,'write.csv')