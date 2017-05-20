%Problem 4.7 to Chapter 4
%   Copyright 2002 AEMM. Revision 2002/03/12 
%   Chapter 4

clear all

load platefine
p=p*2;
R=1.25;
d=1;
p(3,:)=R-d-sqrt(R^2-p(1,:).^2);
pbase=p; tbase=t;
clear p, t;

load strip2

x=p(1,:);
y=p(2,:);
z=p(3,:);

p(1,:)=p(1,:);
p(2,:)=p(2,:);
p(3,:)=0;

t=[tbase t+length(pbase)]; t(4,:)=1;
p=[pbase p];

save dip p t
viewer('dip')
