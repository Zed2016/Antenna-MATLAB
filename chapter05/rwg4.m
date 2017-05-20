%RWG4 Solves MoM equations for the antenna radiation problem
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
%   The feed point position                 FeedPoint(1:3);
%   Number of feeding edges (one for the dipole; 
%   two for the monopole)                   INDEX(1:2);
%
%   Copyright 2002 AEMM. Revision 2002/03/14 
%   Chapter 4

%load the data
load('mesh2');
load('impedance');

%Find the feeding edge(s)(closest to the origin)
FeedPoint=[-1; 0; 0];

for m=1:EdgesTotal
    V(m)=0;
    Distance(:,m)=0.5*sum(p(:,Edge_(:,m)),2)-FeedPoint;
end

[Y,INDEX]=sort(sum(Distance.*Distance));
Index=INDEX(1);                 %Center feed - dipole and loop

%Define the voltage vector
V(Index)=1*EdgeLength(Index);    

%Solve system of MoM equations
tic;
I=Z\V.';
toc %elapsed time

%Find the antenna input impedance
GapCurrent  =sum(I(Index).*EdgeLength(Index)');
GapVoltage  =mean(V(Index)./EdgeLength(Index));
Impedance   =GapVoltage/GapCurrent
FeedPower   =1/2*real(GapCurrent*conj(GapVoltage))

FileName='current.mat'; 
save(FileName, 'f','omega','mu_','epsilon_','c_', 'eta_',...
    'I','V','GapCurrent','GapVoltage','Impedance','FeedPower','Index');


   

   
