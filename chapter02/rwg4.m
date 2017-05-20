%RWG4 Solves MoM equations for the scattering problem
%   Uses the mesh file from RWG2, mesh2.mat, and
%   the impedance file from RWG3, impedance.mat,
%   as inputs.
%   
%   Also calculates the "voltage" vector V (the right-
%   hand side of moment equations)         
%                                           V(1:EdgesTotal)
%
%   The following parameters need to be specified:
%   
%   Direction of the incident signal in Cartesian coordinates
%                                           d(1:3);
%   Direction of the E-field in the incident plane wave      
%   in Cartesian coordinates                Pol(1:3);
%
%   Copyright 2002 AEMM. Revision 2002/03/05 
%   Chapter 2

clear all

%load the data
load('mesh2');
load('impedance');

%Incident field
%Example: d=[0 0 -1] means that the incident signal
% is in the -z direction. 

%Plate - normal incidence
d       =[0 0 -1];     
Pol     =[1 0 0];      

%Dipole - normal incidence
%d      =[0 0 -1];     
%Pol    =[0 1 0];      

%Custom incidence (example)
%d      =[1 0 0]
%Pol    =[0 -0.0037-0.0055*j 0]

k=omega/c_;
kv=k*d;

for m=1:EdgesTotal    
   ScalarProduct=sum(kv.*Center(:,TrianglePlus(m))');
   EmPlus =Pol.'*exp(-j*ScalarProduct);      
   ScalarProduct=sum(kv.*Center(:,TriangleMinus(m))');
   EmMinus=Pol.'*exp(-j*ScalarProduct);      
   ScalarPlus =sum(EmPlus.* RHO_Plus(:,m));
   ScalarMinus=sum(EmMinus.*RHO_Minus(:,m));
   V(m)=EdgeLength(m)*(ScalarPlus/2+ScalarMinus/2);   
end

tic;
%System solution
I=Z\V.';
toc %elapsed time


FileName='current.mat'; 
save(FileName, 'f','omega','mu_','epsilon_','c_', 'eta_','I','V','d','Pol');       