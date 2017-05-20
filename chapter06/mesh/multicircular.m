%MULTICIRCLULAR
%   Creates a circular array of N dipoles
%   equally spaced over the circle of radius R
%
%   The following parameters need to be specified:
%
%   Number of elements, N, in the array         N
%   Radius of the circular array (m)            R
%
%   Copyright 2002 AEMM. Revision 2002/03/06 
%   Chapter 6


clear all
%Load the dipole structure
load strip1

N=16;   %Number of array elements
R=3;    %Radius of circular array

p(3,:)=p(2,:);
p(2,:)=0;
pbase=p; tbase=t;


Theta =2*pi/N;
p(1,:)=p(1,:)-R;
Feed(1:3,1)=[mean(p(1,:)),mean(p(2,:)),0]';

%Cloning algorithm
for k=1:N-1
    pbase1(1,:)=pbase(1,:)+R*cos(-pi+k*Theta);
    pbase1(2,:)=pbase(2,:)+R*sin(-pi+k*Theta);
    pbase1(3,:)=pbase(3,:);
    Feed(1:3,k+1)=[mean(pbase1(1,:)),mean(pbase1(2,:)),0]';
    p=[p pbase1];    
    t=[t tbase+k*length(pbase1)]; t(4,:)=1;    
end
save  array p t Feed
viewer('array')
grid on