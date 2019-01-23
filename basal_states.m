function [Gb,Gpb,Gtb,Ilb,Ipb,Ipob,Ib,IIRb,Isc1ss,Isc2ss,kp1,Km0,Hb,SRHb,Gth,SRsHb, XHb,Ith,IGRb,Hsc1ss,Hsc2ss]=basal_states(type,Gb)
[Vg,k1,k2,...
    VI,m1,m2,m4,m5,m6,HEb,...
    kp1,kp2,kp3,kp4,ki,...
    kmax,kmin,kabs,kgri,f,a,b,c,d,...
    Fcns,Vm0,Vmx,Km0,P2u,...
    K,Alpha,Beta,Gamma,...
    ke1,ke2,kd,ka1,ka2,Delta,Sigma,n,Zeta, Rho, kH, Hb,kh1,kh2,kh3]=parameters(type);
      
Sb= 0;%(m6-HEb)/m5; 
IIRb = 0;
m3=HEb*m1/(1-HEb);
Ipb= IIRb/(m2+m4-(m1*m2)/(m1+m3));%2/5*Sb*(1-HEb)/m4;
Ilb= Ipb*(m2/(m1+m3));
Ib=Ipb/VI;
Ipob= 0;%Sb/Gamma;
EGPb= 2.4;%(1/(2*(k1+kp2)))*(Fcns*k1+k1*kp1+2*Fcns*kp2+k2*Km0*kp2-Ib*k1*kp3-Ipob*k1*kp4+k1*Vm0+kp2*Vm0...
     %-sqrt(-4*k1*k2*Km0*kp2*(Fcns-kp1+Ib*kp3+Ipob*kp4)+(k2*Km0*kp2+k1*(Fcns-kp1+Ib*kp3+Ipob*kp4)+(k1+kp2)*Vm0)^2)); 
 % two possible solutions! but the (+) solution give negative glucose basal values! 
% Gb = 160;%72.763;
Gpb= Gb*Vg;%(kp1-EGPb-kp3*Ib)/kp2;
Gtb=(Fcns-EGPb+k1*Gpb)/k2;
Isc1ss = IIRb/(kd+ka1);
Isc2ss = kd*Isc1ss/ka2;
kp1 = EGPb+kp2*Gpb+kp3*Ib;
Km0 = (Vm0*Gtb)/(EGPb-Fcns) -Gtb;

SRHb = n*Hb;
Gth = Gb;
SRsHb = max(Sigma*(Gth-Gb)+SRHb,0);
XHb = 0;
Ith = Ib;
% Subcutaeneous Glucagon
IGRb = 0;
Hsc1ss = IGRb/(kh1+kh2);
Hsc2ss = kh1*Hsc1ss/kh3;
