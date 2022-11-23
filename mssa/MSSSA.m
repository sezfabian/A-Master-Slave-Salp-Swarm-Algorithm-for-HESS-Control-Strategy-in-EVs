%  Master Slave Salp Swarm Algorithm (SSA)


function [FoodFitness,FoodPosition,Convergence_curve]=MSSSA(N,Max_iter,lb,ub,dim,fobj)

if size(ub,1)==1
    ub=ones(dim,1)*ub;
    lb=ones(dim,1)*lb;
end

Convergence_curve = zeros(1,Max_iter);

%Initialize the positions of salps
SalpPositions=initialization(N,dim,ub,lb);


FoodPosition=zeros(1,dim);
FoodFitness=inf;


%calculate the fitness of initial salps

for i=1:size(SalpPositions,1)
    SalpFitness(1,i)=fobj(SalpPositions(i,:));
end

[sorted_salps_fitness,sorted_indexes]=sort(SalpFitness);
n = ceil(numel(sorted_salps_fitness)/2);
Master_salps = sorted_salps_fitness(1:n);
Slave_salps =sorted_salps_fitness(n+1:end);
Master_indexes = sorted_indexes(1:n);
Slave_indexes = sorted_indexes(n+1:end);


for newindex=1:N
    Sorted_salps(newindex,:)=SalpPositions(sorted_indexes(newindex),:);
end

FoodPosition=sorted_salps_fitness(1,:);
FoodFitness=sorted_salps_fitness(1);

%Main loop
l=2; % start from the second iteration since the first iteration was dedicated to calculating the fitness of salps
while l<Max_iter+1
    %[sorted_salps_fitness,sorted_indexes]=sort(SalpFitness);
    %n = ceil(numel(sorted_salps_fitness)/2);
    %Master_salps = sorted_salps_fitness(1:n);
    %Slave_salps =sorted_salps_fitness(n+1:end);
    Master_indexes = sorted_indexes(1:n);
    Slaves = sorted_indexes(n+1:end);
    Slave_indexes = Slaves(randperm(length(Slaves)));
    
   
   for newindexM=1:n
     Master_Sorted_salps(newindexM,:)=SalpPositions(Master_indexes(newindexM),:);
   end
   for newindexS=1:n
       Slave_Sorted_salps(newindexS,:)=SalpPositions(Slave_indexes(newindexS),:);
   end
    
    c1 = 2*exp(-(4*l/Max_iter)^2); 
    r1 = rand ();
    Lq=abs(r1*SalpPositions(Master_indexes)-SalpPositions(Slave_indexes))/c1;
    SalpPositions(Slave_indexes)=SalpPositions(Master_indexes)-Lq;
    for i=1:size(SalpPositions,1)
  
        SalpPositions = SalpPositions';
        
        if i<=N/2
            for j=1:1:dim
                c2=rand();
                c3=rand();
                %%%%%%%%%%%%% % Eq. (3.1) in the paper %%%%%%%%%%%%%%
                if c3<0.5 
                    SalpPositions(j,i)=FoodPosition(j)+c1*((ub(j)-lb(j))*c2+lb(j));
                else
                    SalpPositions(j,i)=FoodPosition(j)-c1*((ub(j)-lb(j))*c2+lb(j));
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
            
        elseif i>N/2 && i<N+1
            point1=SalpPositions(:,i-1);
            point2=SalpPositions(:,i);
            
            SalpPositions(:,i)=(point2+point1)/2; % % Eq. (3.4) in the paper
        end
        
        SalpPositions= SalpPositions';
    end
    
    for i=1:size(SalpPositions,1)
        
        Tp=SalpPositions(i,:)>ub';Tm=SalpPositions(i,:)<lb';SalpPositions(i,:)=(SalpPositions(i,:).*(~(Tp+Tm)))+ub'.*Tp+lb'.*Tm;
        
        SalpFitness(1,i)=fobj(SalpPositions(i,:));
        
        if SalpFitness(1,i)<FoodFitness
            FoodPosition=SalpPositions(i,:);
            FoodFitness=SalpFitness(1,i);
            
        end
    end
    
    Convergence_curve(l)=FoodFitness;
    l = l + 1;
end



