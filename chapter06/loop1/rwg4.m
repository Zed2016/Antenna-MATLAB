function [Impedance, PowerSum]=rwg4
%RWG4 Solves MoM equations for the antenna radiation problem -
%   antenna arrays
%
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
%   The feed point positions                Feed(1:3,1:N);
%   Number of feeding edges (one for the dipole; 
%   two for the monopole)                   INDEX(1:2);
%
%   Copyright 2002 AEMM. Revision 2002/03/16 
%   Chapter 6

%Load the data
load('mesh2');
load('impedance');

V(1:EdgesTotal)=0;

%Find feeding edges closest to the array Feed 
N=length(Feed(1,:));
Index=[];
for k=1:N
    for m=1:EdgesTotal    
        Distance(:,m)=0.5*sum(p(:,Edge_(:,m)),2)-Feed(:,k);
    end
    [Y,INDEX]=sort(sum(Distance.*Distance));
    Index=[Index INDEX(1)];      %Center feed - dipole
    %Index=[Index INDEX(1:2)];   %Probe feed - monopole
end
V(Index)=1.0*EdgeLength(Index);
N=length(Index);

%Identify phase shift 
%The progressive phase shift is zero for the broadside array:
phase=0;

%The progressive phase shift can be any number for 
%the end-fire array:
%phase=-2*pi/3; % or -pi/2 or etc.

%Identify feeding voltages-linear array (dipole array only!)
for n=1:N
    nn=Index(n);
    V(nn)=V(nn)*exp(j*phase*(n-1));    
end        

%Solve system of MoM equations
tic;
I=Z\V.';
toc %elapsed time

%Terminal impedance (dipole array only!)
for n=1:N
    nn=Index(n);
    GapCurrent(n)=I(nn)*EdgeLength(nn);
    GapVoltage(n)=V(nn)/EdgeLength(nn);
    Impedance (n)=GapVoltage(n)/GapCurrent(n); %this is the terminal impedance
    FeedPower (n)=1/2*real(GapCurrent(n)*conj(GapVoltage(n)));    
end        

Impedance
PowerSum=sum(FeedPower);
