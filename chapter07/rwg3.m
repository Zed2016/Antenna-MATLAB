%RWG3-FREQUENCY LOOP 
%   Calculates the impedance matrix using function IMPMET
%   and solves MoM equations
%   Uses the mesh file from RWG2, mesh2.mat, as an input.
% 
%   The following parameters need to be specified prior to 
%   calculations:
%   
%   Number of frequency steps       NumberOfSteps
%   Lower frequency                 FreqStart
%   Upper frequency                 FreqStop
%   Dielectric constant (SI)        epsilon_
%   Magnetic permeability (SI)      mu_
%
%   Copyright 2002 AEMM. Revision 2002/03/25 
%   Chapter 7

clear all
%Load the data
load('mesh2');

%Frequency series parameters
NumberOfSteps=200;
FreqStart   =25e6;      %in Hz
FreqStop    =500e6;      %in Hz
step=(FreqStop-FreqStart)/(NumberOfSteps-1);

%EM parameters
epsilon_    =8.854e-012;
mu_         =1.257e-006;
%speed of light 
c_=1/sqrt(epsilon_*mu_);
%free-space impedance 
eta_=sqrt(mu_/epsilon_);

%Contemporary variables - metal impedance matrix
for m=1:EdgesTotal
    RHO_P(:,:,m)=repmat(RHO_Plus(:,m),[1 9]);   %[3 9 EdgesTotal]
    RHO_M(:,:,m)=repmat(RHO_Minus(:,m),[1 9]);  %[3 9 EdgesTotal]
end

%Frequency series
T0=cputime;
for FF=1:NumberOfSteps    
    FF
    f(FF)       =FreqStart+step*(FF-1);
    omega       =2*pi*f(FF);
    k           =omega/c_;
    K           =j*k;
  
    Constant1   =mu_/(4*pi);
    Constant2   =1/(j*4*pi*omega*epsilon_);
    Factor      =1/9;    
    FactorA     =Factor*(j*omega*EdgeLength/4)*Constant1;
    FactorFi    =Factor*EdgeLength*Constant2;
    FactorA     =FactorA.';
    FactorFi    =FactorFi.';
    
    Z   =  impmet( EdgesTotal,TrianglesTotal,...
            EdgeLength,K,...
            Center,Center_,...
            TrianglePlus,TriangleMinus,...
            RHO_P,RHO_M,...
            RHO__Plus,RHO__Minus,...
            FactorA,FactorFi);   
    
    %Find the feeding edge(s)(closest to the origin)
    FeedPoint=[0; 0; 0];
    for m=1:EdgesTotal
        V(m)=0;
        Distance(:,m)=0.5*sum(p(:,Edge_(:,m)),2)-FeedPoint;
    end
    [Y,INDEX]=sort(sum(Distance.*Distance));
    Index=INDEX(1);                 %Center feed - dipole
    %Index=INDEX(1:2);              %Probe feed - monopole
    
    %Solution of MoM equations
    V(Index)=1*EdgeLength(Index);    
    I=Z\V.';
    
    CURRENT(:,FF)=I(:);
    %Impedance
    GapCurrent(FF)  =sum(I(Index).*EdgeLength(Index)');
    GapVoltage(FF)  =mean(V(Index)./EdgeLength(Index));
    Impedance(FF)   =GapVoltage(FF)/GapCurrent(FF);
    FeedPower(FF)   =1/2*real(GapCurrent(FF)*conj(GapVoltage(FF)));    
    Imp             =Impedance(FF)
    T=cputime-T0
end

%Save result
FileName='current.mat'; 
save(FileName, 'f','NumberOfSteps','FreqStart','FreqStop','step',...
                'omega','mu_','epsilon_','c_', 'eta_',...
                'CURRENT','GapCurrent','GapVoltage','Impedance','FeedPower','Index');            