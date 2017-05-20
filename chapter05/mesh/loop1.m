%LOOP1
%   Creates triangular mesh for the loop antenna of 
%   given radius and wire thickness
%   The following parameters need to be specified:
%
%   Loop radius in m                        a
%   Number of loop rectangles               M
%   Width of the strip                      h
%
%   Note: the equivalent wire radius is 0.25*h
%
%   Copyright 2002 AEMM. Revision 2002/03/13 
%   Chapter 5

clear all

a=1;        
M=90;       
h=0.04;     

Count=1;    %Point number
%Create rectangles
t=[];
for n=1:M
    angle =2*pi*(n-1)/M;
    x=  a*cos(angle); 
    y=  a*sin(angle);
    zTop=  h/2; zBottom=-h/2;
    X(Count:Count+1)=[x x]';
    Y(Count:Count+1)=[y y]';
    Z(Count:Count+1)=[zTop zBottom]';
    if(n>1)
        t=[t [Count-2; Count-1; Count+1] [Count-2; Count; Count+1]];
    end
    Count=Count+2;
end
%Close the chain
t=[t [Count-2; Count-1; 2] [Count-2; 1; 2]];

%Nodes
PointNumber=Count-1;
for L=1:PointNumber
   p(1:3,L) = [X(L); Y(L); Z(L)];
end
t(4,:)=1;

%Save result
save loop1  p t;
viewer('loop1')
