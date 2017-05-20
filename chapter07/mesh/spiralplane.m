%SPIRALPLANE Archimedean spiral of N turns
%   This script "bends" the strip (strip.mat) in order to get 
%   a spiral
%
%   The following parameters need to be specified:
%
%   Number of turns                     N
%   Spiral size in m                    Size
%
%   Copyright 2002 AEMM. Revision 2002/03/25
%   Chapter 7

clear all
load strip

N=5;            %Number of turns
Size=0.2;       %Spiral size in m

angle=abs(2*pi*N*p(1,:));

P(1,:)=p(1,:).*cos(angle);
P(2,:)=p(1,:).*sin(angle);
P(3,:)=p(3,:);

p=Size*P;
save spiralplane  p t;
viewer('spiralplane')
