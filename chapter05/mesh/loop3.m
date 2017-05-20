%LOOP3
%   Creates triangular mesh for the helical antenna 
%   of given radius, number of turns, spacing, and 
%   wire thickness.
%
%   LOOP3 has a somewhat better mesh quality than LOOP2 
%   (see the text of Chapter 5). Otherwise, both the scripts 
%   are equivalent.  
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

%Axial mode parameters
a=0.0545;   
M=12;       
h=0.005;    
N=15;       
S=0.076;    

%pitch angle
pitch=atan(S/(2*pi*a))
factor=sin(pitch);
factor1=h*cos(pitch);

L=N*S      %Total length of the antenna
    
Count=1;    %Point number
EN=1;       %Element number
%Create rectangles
t=[];
for n=1:M*N
    angle =2*pi*(n-1)/M;
    delta  =h*factor/a;  %correction angle in radians
    Point1=[a*cos(angle) a*sin(angle) n*L/(M*N)-L/2];
    Point2=[a*cos(angle+delta) a*sin(angle+delta) n*L/(M*N)-L/2-factor1];
    X(Count:Count+1)=[Point1(1) Point2(1)]';
    Y(Count:Count+1)=[Point1(2) Point2(2)]';
    Z(Count:Count+1)=[Point1(3) Point2(3)]';
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
save loop3  p t h;
viewer('loop3')