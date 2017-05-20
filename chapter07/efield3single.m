%EFIELD3SINGLE 2D Radiation patterns at a particular frequency
%   Uses the mesh file from RWG2, mesh2.mat, and the file 
%   containing surface current coefficients, current.mat, 
%   from RWG3 or RWG31 as inputs.
%
%   The following parameters need to be specified:
%   
%   Radius of the circle (m)            R
%   Plane of the circle:                [x y 0] or 
%                                       [x 0 z] or 
%                                       [0 y z] 
%   Number of discretization points per 
%   pattern                             NumPoints
%   Frequency value [Hz]                FreqToPlot
%
%   Copyright 2002 AEMM. Revision 2002/03/23 
%   Chapter 7,8

clear all
%Load the data
load('mesh2');
load('current');

FreqToPlot=75e6  %in Hz
[dummy,FF]=min(abs(FreqToPlot-f));
f(FF)
I=CURRENT(:,FF);
Power=FeedPower(FF);

omega=2*pi*f(FF);
k=omega/c_;
K=j*k;

for m=1:EdgesTotal
    Point1=Center(:,TrianglePlus(m));
    Point2=Center(:,TriangleMinus(m));
    DipoleCenter(:,m)=0.5*(Point1+Point2);
    DipoleMoment(:,m)=EdgeLength(m)*I(m)*(-Point1+Point2); 
end

NumPoints=100;
R=1000; %pattern in m
for ii=1:NumPoints+1
   ii
   phi(ii)=(ii-1)*pi/(NumPoints/2);
   x=R*cos(phi(ii));   
   z=R*sin(phi(ii));   
   ObservationPoint=[x 0 z]';
   [EM,HM]=point(ObservationPoint,eta_,K,DipoleMoment,DipoleCenter);  
   ET=sum(EM,2); HT=sum(HM,2);
   Poynting=0.5*real(cross(ET,conj(HT)));
   W(ii)=norm(Poynting);
   U(ii)=(norm(ObservationPoint))^2*W(ii);
end
Polar_=10*log10(4*pi*U/Power);

%This is the standard Matlab polar plot
OFFSET=40; polar(phi,max(Polar_+OFFSET,0)); grid on;
Title=strcat('Offset= ', num2str(OFFSET), ' dB');
title(Title);

%This is Balanis' relative power: 
%Polar=10*log10(U/max(U)); OFFSET=40; polar(phi,Polar+OFFSET); grid on;