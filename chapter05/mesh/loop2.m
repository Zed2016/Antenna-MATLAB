%LOOP2
%   Creates triangular mesh for the helical antenna 
%   of given radius, number of turns, spacing, and 
%   wire thickness.
%
%   The following parameters need to be specified:
%
%   Turn radius in m                        a
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

%Normal mode parameters
a=0.1;      
M=40;       
h=0.005;    
N=9;       
S=0.04;    

%Pitch angle
pitch=atan(S/(2*pi*a))
factor=sin(pitch);
factor1=h*cos(pitch);

L=N*S      %Total length of the antenna

Count=1;    %Point number
%Create rectangles
t=[];
for n=1:M*N
    angle=2*pi*(n-1)/M;
    x=  a*cos(angle); 
    y=  a*sin(angle);
    zM=   n*L/(M*N)-L/2+h/2;
    X(Count:Count+1)=[x x]';
    Y(Count:Count+1)=[y y]';
    Z(Count:Count+1)=[zM zM-h]';
    if(n>1)
        t=[t [Count-2; Count-1; Count+1] [Count-2; Count; Count+1]];
    end
    Count=Count+2;
end

%Nodes
PointNumber=Count-1;
for L=1:PointNumber
   p(1:3,L) = [X(L); Y(L); Z(L)];
end
t(4,:)=1;

%Save result
save loop2  p t h;
viewer('loop2')