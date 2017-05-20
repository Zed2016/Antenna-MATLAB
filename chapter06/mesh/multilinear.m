%MULTILINEAR
%   Creates a linear array of N dipoles separated by 
%   distance d
%
%   The following parameters need to be specified:
%
%   Number of elements, N, in the array         N
%   Separation distance (m)                     d
%
%   Copyright 2002 AEMM. Revision 2002/03/06 
%   Chapter 6

clear all

N=2;        %Number of array elements
d=2.000;    %Separation distance between elements

%Load the dipole structure
load strip1

p(3,:)=p(2,:);
p(2,:)=0;
pbase=p; tbase=t;

Length=(N-1)*d;

if(N==1)
    save  array p t;
    break;
end

Step=d;
p(1,:)=p(1,:)-Length/2; %to position the array
Feed(1:3,1)=[mean(p(1,:)),0,0]';

%Cloning algorithm
for k=1:N-1
    pbase1(1,:)=pbase(1,:)-Length/2+k*Step;
    pbase1(2,:)=pbase(2,:);
    pbase1(3,:)=pbase(3,:);
    Feed(1:3,k+1)=[mean(pbase1(1,:)),0,0]';
    p=[p pbase1];    
    t=[t tbase+k*length(pbase1)]; t(4,:)=1;    
end
save  array p t Feed
viewer('array')
grid on