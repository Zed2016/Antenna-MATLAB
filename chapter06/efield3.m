%EFIELD3 2D Radiation patterns
%   Uses the mesh file from RWG2, mesh2.mat, and
%   the file containing surface current coefficients,
%   current.mat, from RWG4 as inputs.
%
%   Additionally uses the value of TotalPower saved 
%   in file gainpower.mat (script efield2.m)
%
%   The following parameters need to be specified:
%   
%   Radius of the circle (m)            R
%   Plane of the circle:                [x y 0] or 
%                                       [x 0 z] or 
%                                       [0 y z] 
%   Number of discretization points per 
%   pattern                             NumPoints
%
%   Copyright 2002 AEMM. Revision 2002/03/11 
%   Chapter 3


clear all
%Load the data
load('mesh2');
load('current');
load('gainpower');

k=omega/c_;
K=j*k;

for m=1:EdgesTotal
    Point1=Center(:,TrianglePlus(m));
    Point2=Center(:,TriangleMinus(m));
    DipoleCenter(:,m)=0.5*(Point1+Point2);
    DipoleMoment(:,m)=EdgeLength(m)*I(m)*(-Point1+Point2); 
end

NumPoints=200;
R=100; %pattern in m
%   Note: For large antenna structures the radius of 1000 m
%   should be preferred (cf. Fig 6.11 of Chapter 6)
for ii=1:NumPoints+1
   phi(ii)=(ii-1)*pi/(NumPoints/2);
   x=R*cos(phi(ii));   
   y=R*sin(phi(ii));   
   ObservationPoint=[x y 0]';
   [E,H]=point(ObservationPoint,eta_,K,DipoleMoment,DipoleCenter);
   ET=sum(E,2); HT=sum(H,2);
   Poynting=0.5*real(cross(ET,conj(HT)));
   W(ii)=norm(Poynting);
   U(ii)=(norm(ObservationPoint))^2*W(ii);
end
Polar_=10*log10(4*pi*U/TotalPower);

GainLogarithmic=max(Polar_) %gain for the particular pattern!

%This is the standard Matlab polar plot
OFFSET=0; polar(phi,max(Polar_+OFFSET,0)); grid on;
Title=strcat('Offset= ', num2str(OFFSET), ' dB');
title(Title);

%This is Balanis' relative power: 
%Polar=10*log10(U/max(U)); OFFSET=40; polar(phi,Polar+OFFSET); grid on;


