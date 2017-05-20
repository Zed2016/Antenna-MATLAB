%LOOP4
%   Creates triangular mesh for the helical tapered 
%   antenna of given radius, number of turns, spacing, 
%   and wire thickness.
%
%   The following parameters need to be specified:
%
%   Turn radius in m -Center                amin
%   Turn radius in m -Top/Bottom            amax
%   Number of loop rectangles               M
%   Width of the strip                      h
%   Number of turns                         N
%   Spacing between turns                   S
%
%   Note: the equivalent wire radius is 0.25*h
%
%   Copyright 2002 AEMM. Revision 2002/03/13 
%   Chapter 5

clear all

amin=0.1;   
amax=1;     
M=30;       
h=0.05;     
N=10;       
S=0.2;     

L=N*S;      %Total length of the antenna

Count=1;    %Point number
%Create rectangles
t=[];
for n=1:M*N
    angle=2*pi*(n-1)/M;
    R=amin-abs((n-1)-M*N/2)*(amin-amax)/(M*N/2);
    x=  R*cos(angle); 
    y=  R*sin(angle);
    zM=   n*L/(M*N)-L/2+h/2;
    X1Array(Count:Count+1)=[x x]';
    X2Array(Count:Count+1)=[y y]';
    X3Array(Count:Count+1)=[zM zM-h]';
    if(n>1)
        t=[t [Count-2; Count-1; Count+1] [Count-2; Count; Count+1]];
    end
    Count=Count+2;
end

%Nodes
PointNumber=Count-1;
for L=1:PointNumber
   p(1:3,L) = [X1Array(L); X2Array(L); X3Array(L)];
end
t(4,:)=1;

%Save result
save loop4  p t h;
viewer('loop4')