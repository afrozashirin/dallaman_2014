function [Vg,k1,k2,...
          VI,m1,m2,m4,m5,m6,HEb,...
          kp1,kp2,kp3,kp4,ki,...
          kmax,kmin,kabs,kgri,f,a,b,c,d,...
          Fcns,Vm0,Vmx,Km0,P2u,...
          K,Alpha,Beta,Gamma,...
          ke1,ke2,kd,ka1,ka2,Delta,Sigma,n,Zeta, Rho, kH, Hb,kh1,kh2,kh3]=parameters(type)
switch type
    case 'normal'
        % Glucose subsystem
        Vg=1.88; k1=0.065; k2=0.079;
        % Insuline subsystem
        VI=0.05; m1=0.19; m2=0.484; m4=0.194; m5=0.0304; m6=0.6471; HEb=0.6;
        % Endogenous glucose production
        kp1=2.7735; kp2=0.0021; kp3=0.009; kp4=0.0618; ki=0.0079;
        % Glucose rate of appearance
        kmax=0.0558; kmin=0.008; kabs=0.057; kgri=0.0558; f=0.9; a=0.00013; b=0.82; c=0.00236; d=0.01;
        % Glucose utilization
        Fcns=1; Vm0=2.5; Vmx=0.047; Km0=225.59; P2u=0.0331;
        % Insuline secretion
        K=2.3; Alpha=0.05; Beta=0.11; Gamma=0.5;
        % Renal excretion
        ke1=0.0005; ke2=339;
        kd = 0; ka1 = 0; ka2 = 0;

    case 'diabetic'
        % Glucose subsystem
        Vg=1.49; k1=0.065; k2=0.079;
        %k1=0.042; k2=0.071;
        % Insuline subsystem
        VI=0.04; m1=0.379; m2=0.673; m4=0.269; m5=0.0526; m6=0.8118; HEb=0.112;
        % Endogenous glucose production
        kp1= 2.7; kp2=0.0021; kp3=0.009;%kp2=0.0007; kp3=0.005;
        kp4=0.0786; ki=0.0066;
        % Glucose rate of appearance
        kmax=0.0465; kmin=0.0076; kabs=0.023; kgri=0.0465; f=0.9; a=0.00016; b=0.68; c=0.00023; d=0.009;
        % Glucose utilization
        Fcns=1; Vm0=4.65; Vmx=0.034; Km0 = 471.13;
        %Km0=466.21; 
        P2u=0.084;       
        %Fcns=1; Vm0=2.5; Vmx=0.047; Km0=225.59; P2u=0.0331;

       % Insuline secretion
        K=0.99; Alpha=0.013; Beta=0.05; Gamma=0.5;
        % Renal excretion
        ke1=0.0007; ke2=269;
        % Subcatenuous Insuln
        kd = 0.0164; ka1 = 0.0018; ka2 = 0.0182;
        % Glucagon system
        Delta = 0.682; Sigma = 1.093; n = 0.15;
        Zeta = 0.009; Rho = 0.57; kH = 0.16; Hb = 93;
        % Subcatenuous Glucagon
        kh1 = 0.0164; kh2 = 0.0018; kh3 = 0.0182;
end