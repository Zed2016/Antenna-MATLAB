function []=viewer(filename)
%VIEWER Visualizes the structure
%   Shows the ground plane and array elements
%   using different colors
%   
%   Usage:  viewer('plate.mat') or
%           viewer('plate') or
%           viewer plate
%
%   Copyright 2002 AEMM. Revision 2002/03/07 
%   Chapter 6

load(filename);

Color0='g';     %[0.45 0.45 0.45];
Color1='y';     %[0.75 0.75 0.75];

TrianglesTotal=length(t)
GroundPlane      =find(t(4,:)==0);
AntennaElements =find(t(4,:)==1);

for k=1:length(GroundPlane)
    m=GroundPlane(k);
    n=t(1:3,m);
    X(1:3,m)=p(1,n)';
    Y(1:3,m)=p(2,n)';
    Z(1:3,m)=p(3,n)';
end
for k=1:length(AntennaElements)
    m=AntennaElements(k);
    n=t(1:3,m);
    X_(1:3,m)=p(1,n)';
    Y_(1:3,m)=p(2,n)';
    Z_(1:3,m)=p(3,n)';
end

if(~isempty(GroundPlane))
    g=fill3(X,Y,Z,Color0,X_,Y_,Z_,Color1);
else
    g=fill3(X_,Y_,Z_,Color1);
end
    
axis('equal')
rotate3d on
