% function xdot=DallaMan2018f(t,x,type,BW,D,uI,uG,t0,Gb,EGPb,IIRb,IGRb)
function xdot=DallaMan2014fun(t,x,type,BW,Gb,D,uI,uG,t0)
%% define systems parameters
[Vg,k1,k2,...
    VI,m1,m2,m4,m5,m6,HEb,...
    kp1,kp2,kp3,kp4,ki,...
    kmax,kmin,kabs,kgri,f,a,b,c,d,...
    Fcns,Vm0,Vmx,Km0,P2u,...
    K,Alpha,Beta,Gamma,...
    ke1,ke2,kd,ka1,ka2,Delta,Sigma,n,Zeta, Rho, kH, Hb,kh1,kh2,kh3]=parameters(type);
diractime=1e-3; % time to approximate the dirac delta
%% compute the needed basal statesk
[~,~,~,~,~,~,Ib,IIRb,~,~,kp1,Km0,Hb,SRHb,Gth,~, ~, Ith,IGRb,~,~]=basal_states(type,Gb);

% [Ib,IIRb,kp1,Km0,Hb,SRHb,Gth,Ith,IGRb]
      
%% define the state variables and all the (state dependent) functions
% Glucose subsystem
Gp=x(1);Gt=x(2); G=Gp/Vg; 
% Insuline subsystem
Il=x(3); Ip=x(4); I=Ip/VI ;
% Endogenous glucose production
I1=x(5); Id=x(6); 
% Glucose rate of appearance
Qsto1=x(7); Qsto2=x(8); Qgut=x(9); Ra=f*kabs*Qgut/BW;
% Glucose utilization
X=x(10); Uii=Fcns; Uid=(Vm0+Vmx*X)*Gt/(Km0+Gt);
% Insuline secretion
%Ipo=x(11); Y=x(12); S= 0;%Gamma*Ipo;
% Glucagon kinetics
SRsH = x(11); H = x(12); XH = x(13);
% Endogeneous glucagon production
EGP= kp1-kp2*Gp-kp3*Id + Zeta* XH;% eq10
% Glucose renal excretion
E=ke1*(Gp-ke2)*hill(Gp,ke2,1,4);
% subcutaneous insulin infusion
Isc1 = x(14); Isc2 = x(15);
Rai = ka1*Isc1 + ka2*Isc2; % pmole/(kg*min)or  pmole/kg/min
% Subcataneous Glucagon
Hsc1 = x(16); Hsc2 = x(17);
Rah = kh3 * Hsc2;
%% define the equations
xdot=zeros(length(x),1);
% Glucose subsystem
xdot(1)=EGP+Ra-Uii-E-k1*Gp+k2*Gt;
xdot(2)=-Uid+k1*Gp-k2*Gt;
Gdot=xdot(1)/Vg;
% Insulin subsystem
HE = HEb;%-m5*S+m6;
m3=HE*m1/(1-HE);
xdot(3)= -(m1+m3)*Il+m2*Ip;
xdot(4)= -(m2+m4)*Ip+m1*Il+Rai;
% Endogenous glucose production
xdot(5)=-ki*(I1-I);
xdot(6)=-ki*(Id-I);
% Glucose rate of appearance
Qsto=Qsto1+Qsto2;
kempt = kmin+(kmax-kmin)/2*(tanh(5/(2*D*(1-b))*(Qsto-b*D))-tanh(5/(2*D*c)*(Qsto-c*D))+2); 
xdot(7)=-kgri*Qsto1+ D*delta(t,60,1,4);%1/diractime*D*((t-t0)<diractime);
xdot(8)=-kempt*Qsto2+kgri*Qsto1;
xdot(9)=-kabs*Qgut+kempt*Qsto2;
% Glucose utilization
xdot(10)=-P2u*(X-I+Ib);
% Insuline secretion
%h=Gpb/Vg;
%Spo=Y+K*Gdot*(Gdot>0)+Sb;
%xdot(11)=-Gamma*Ipo+Spo;
%xdot(12)=-Alpha*(Y+Sb-(Sb+Beta*(G-h))*(Beta*(h-G)<Sb));
% Glucagon Subsystem
SRdH = Delta*maxfunc(-Gdot,0,0.0001);
SRH = SRsH+SRdH;
xdot(11) = -Rho*(SRsH -  maxfunc((Sigma*(Gth-G)/(maxfunc(I-Ith,0,0.0001)+1))+SRHb,0,0.0001));
xdot(12) = -n*H +SRH +Rah;
xdot(13) = -kH*XH +kH* maxfunc(H-Hb,0,0.0001);
% Subcatenous Insulin
xdot(14) = -(kd+ka1)*Isc1 +IIRb +   (1/78)*uI*6944.4*delta(t,30,1,4);% +uI*(t<30);

% load('uu.mat');
% 
% aaa = 20.9*delta(t,30,1,4);
% uu = [uu;[t aaa]];150
% save('uu.mat','uu');

xdot(15) = kd*Isc1 - ka2*Isc2;
% Subcatenous Glucagon
xdot(16) = -(kh1+kh2)*Hsc1  + (1/78)*uG*1e6*delta(t,150,1,4);
xdot(17) = kh1*Hsc1 - kh3*Hsc2;
