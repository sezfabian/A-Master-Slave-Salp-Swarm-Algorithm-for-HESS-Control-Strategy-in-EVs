%  Master Slave Salp Swarm Algorithm (SSA) 


% You can simply define your cost in a seperate file and load its handle to fobj 
% The initial parameters that you need are:
%__________________________________________
% fobj = @YourCostFunction
% dim = number of your variables
% Max_iteration = maximum number of generations
% SearchAgents_no = number of search agents
% lb=[lb1,lb2,...,lbn] where lbn is the lower bound of variable n
% ub=[ub1,ub2,...,ubn] where ubn is the upper bound of variable n
% If all the variables have equal lower bound you can just
% define lb and ub as two single number numbers

% To run SSA: [Best_score,Best_pos,SSA_cg_curve]=SSA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj)
%__________________________________________

SearchAgents_no=60; % Number of search agents

%Function_name='F23'; % Name of the test function that can be from F1 to F23 ( 

Max_iteration=1000; % Maximum numbef of iterations

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);

[Best_score,Best_pos,SSA_cg_curve]=MSSSA(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

figure('Position',[500 500 660 290])
%Draw search space
subplot(1,2,1);
func_plot(Function_name);
title('Parameter space')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

%Draw objective space
subplot(1,2,2);
semilogy(SSA_cg_curve,'Color','r')
title('Objective space')
xlabel('Iteration');
ylabel('Best score obtained so far');

axis tight
grid on
box on
legend('SSA')

display(['The best solution obtained by SSA is \m ', num2str(Best_pos)]);
display(['The best optimal value of the objective funciton found by SSA is \n ', num2str(Best_score)]);

        



