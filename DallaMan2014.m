close all
clear
%model with open loop control
 type='diabetic'
%type='normal'
BW=78; % body weight (kg)
Gb = 130; % basal glucose
[Vg,k1,k2,...
    VI,m1,m2,m4,m5,m6,HEb,...
    kp1,kp2,kp3,kp4,ki,...
    kmax,kmin,kabs,kgri,f,a,b,c,d,...
    Fcns,Vm0,Vmx,Km0,P2u,...
    K,Alpha,Beta,Gamma,...
    ke1,ke2,kd,ka1,ka2,Delta,Sigma,n,Zeta, Rho, kH, Hb,kh1,kh2,kh3]=parameters(type);
% basal states
[Gb,Gpb,Gtb,Ilb,Ipb,Ipob,Ib,IIRb,Isc1ss,Isc2ss,kp1,Km0,Hb,SRHb,Gth,SRsHb, XHb,Ith,IGRb,Hsc1ss,Hsc2ss]=basal_states(type, Gb);
% Initial conditions

x0=[Gpb;Gtb;Ilb;Ipb;Ib;Ib;0;0;0;0;SRsHb;Hb;XHb;Isc1ss;Isc2ss;Hsc1ss;Hsc2ss];



%x0 = [167.7534; 120.4725;0.9783;0.6206; 15.4076;15.4591; 0;0;0;15.5115;15.1027; 100.7056;7.7019;11.7403;10.5793;0;0];
% time interval 
tspan=[0:0.1:301];
D=7e-6;   %amount of ingested glucose (mg)
uG = 0.0;
uI = 0;

%% conversion from pmol/min/kg to U/min to save
[t,y] = ode45(@(t,x) DallaMan2014fun(t,x,type,BW,Gb,D,uI,uG,tspan(1)),tspan, x0);

figure(1)
hold on
box on
title('glucose (mg/dL)')
line(t,y(:,1)/Vg,'color',[1 0 1],'linewidth',2), ylim([0 300])
%legend(leg(1:i))
xlabel('Time (t) (min)')
ylabel('Glucose (G(t)) (mg/dL)')

states = {'Plasma Glucose'; 'Tissue Glucose';'Liver Insulin';'Plasma Insulin';'Delayed Insulin 1';'Delayed Insulin';'Solid Glucose';'Liquide Glucose';'Intestine Glucose';'Interstial Insulin';...
    'Static Glucagon'; 'Plasma Glucagon'; 'Delayed Glucagon';'Isc1';'Isc2';'Hsc1';'Hsc2'};

figure(2)
for ii = 1:17
    subplot(5,4,ii)
    hold on
    box on
    if ii==1
    y(:,ii)  = y(:,ii)/Vg;
    line(t,y(:,ii),'color',[1 0 1],'linewidth',2)
    xlabel('Time')
    ylabel(states{ii})
    else
    line(t,y(:,ii),'color',[1 0 1],'linewidth',2)
    xlabel('Time')
    ylabel(states{ii})
    end    
end

set(findall(gcf,'-property','FontSize'),'FontSize',12,'FontWeight','Bold')

%set(findall(gcf,'-property','FontSize'),'FontSize',12,'FontWeight','Bold')
set(findobj(gcf,'type','title'),'FontName','Arial','FontSize',24,'FontWeight','Bold');

%%

% TT = array2table([t y]);
% writetable(TT,'ruleGlucagon.dat','WriteVariableNames', false,'Delimiter',' ')