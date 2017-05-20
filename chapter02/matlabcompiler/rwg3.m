function [] = rwg3
%RWG3 Calculates the impedance matrix using function IMPMET
%   Uses the mesh file from RWG2, mesh2.mat, as an input.
%
%   The following parameters need to be specified prior to 
%   calculations:
%   
%   Frequency (Hz)                  f
%   Dielectric constant (SI)        epsilon_
%   Magnetic permeability (SI)      mu_
%
%   Copyright 2002 AEMM. Revision 2002/03/11 
%   Chapter 2

clear all
%Load the data
load('mesh2');

%EM parameters (f=3e8 means that f=300 MHz) 
f           =3e8;  
epsilon_    =8.854e-012;
mu_         =1.257e-006;
%Speed of light
c_=1/sqrt(epsilon_*mu_);
%Free-space impedance 
eta_=sqrt(mu_/epsilon_);

%Contemporary variables - introduced to speed up 
%the impedance matrix calculation
omega       =2*pi*f;                                            
k           =omega/c_;
K           =j*k;
Constant1   =mu_/(4*pi);
Constant2   =1/(j*4*pi*omega*epsilon_);
Factor      =1/9;    

FactorA     =Factor*(j*omega*EdgeLength/4)*Constant1;
FactorFi    =Factor*EdgeLength*Constant2;

for m=1:EdgesTotal
    RHO_P(:,:,m)=repmat(RHO_Plus(:,m),[1 9]);   %[3 9 EdgesTotal]
    RHO_M(:,:,m)=repmat(RHO_Minus(:,m),[1 9]);  %[3 9 EdgesTotal]
end
FactorA=FactorA.';
FactorFi=FactorFi.';

%Impedance matrix Z
tic; %start timer

Z=  impmet( EdgesTotal,TrianglesTotal,...
            EdgeLength,K,...
            Center,Center_,...
            TrianglePlus,TriangleMinus,...
            RHO_P,RHO_M,...
            RHO__Plus,RHO__Minus,...
            FactorA,FactorFi);   

toc %elapsed time

%Save result
FileName='impedance.mat'; 
save(FileName, 'f','omega','mu_','epsilon_','c_', 'eta_','Z');            