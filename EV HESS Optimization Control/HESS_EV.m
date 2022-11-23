%EV HESS MODEL DRIVE SIMULATION MATLAB Code
%@Fabian Cheruiyot, Department of Electrical and Information Engineering University Of Nairobi

clc;
clear all;

%initialize vehicle and HESS parameters
m=3600;
Cd=0.208;
Dens=1.225;
Area= 2.34;
acom=[2 0 3 0 -3 0 -2 5 0];
v=zeros(1,125);
a=zeros(1,125);
Edemand=zeros(1,125);
Econ=zeros(1,125);
Qbat=zeros(1,125);
Qbat(1)= 198000000000;
Quc=zeros(1,125);
Quc(1)= 3600000;
for i=1:126
    SOCbat(i)=0.9;
    SOCuc(i)=0.9;
    Vbat(i)=350;
    Vuc(i) = 36;
    Ib(i)=0;
    Iuc(i)=0;
end
Cuc=400;
t=2;

%generate drive simulation variables for 126(s) (acceleration & speed)
while t<=126
    if t<12
    a(t)= acom(1);
    v(t)=v(t-1)+ a(t);
    end
    if t > 11
    a(t)= acom(2);
    v(t)=v(t-1)+ a(t);
    end
    if t > 31
    a(t)= acom(3);
    v(t)=v(t-1)+ a(t);
    end
    if t > 51
    a(t)= acom(4);
    v(t)=v(t-1)+ a(t);
    end
    if t > 81
    a(t)= acom(5);
    v(t)=v(t-1)+ a(t);
    end
    if t > 91
    a(t)= acom(6);
    v(t)=v(t-1)+ a(t);
    end
    if t > 101
    a(t)= acom(7);
    v(t)=v(t-1)+ a(t);
    end
    
    %calculate energy demand, SOC and estimate Battery Voltage
    Edemand(t)=((m*a(t))+(Cd.*Dens.*(((v(t))^2)/2)*Area))*v(t)*1.25;
    SOCbat(t)=(Qbat(t-1)/Qbat(1))*SOCbat(1);
    SOCuc(t)=(Quc(t-1)/Quc(1))*SOCuc(1);
    Vbat(t)=Vbat(t-1)-(SOCbat(t-1)-SOCbat(t))*0.0007;
    
    %call HESS energy optimization function
    HESS_function 
    
    %calculate and store energy cpacities of battery and capacitor
    Ib(t)=abs(Ibat);
    Iuc(t)=abs(Ic);
    Qbat(t)= Qbat(t-1)-abs(Eb);
    Quc(t)=Quc(t-1)-abs(Euc);
    Econ(t)= Econ(t-1)+abs(Eb)+ abs(Euc);
    t=t+1;
end

%calculate score, plot energy consumption and current distribution graphs
Score=(Qbat(1)+Quc(1))-(Qbat(126)+Quc(126))
figure (1)
plot(v)
figure (2)
plot(Edemand)
figure (3)
plot (abs(10*Ib))
hold on
plot (abs(10*Iuc))
figure (4)
hold on
plot (abs(Econ))


