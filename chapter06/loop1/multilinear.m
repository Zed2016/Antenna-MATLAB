function []=multilinear(d);
%MULTILINEAR - function (Chapter 6/Loop 1)
%   Creates a linear array of N dipoles separated by d
%
%   Copyright 2002 AEMM. Revision 2002/03/06 
%   Chapter 6

N=2;        %Number of array elements

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

