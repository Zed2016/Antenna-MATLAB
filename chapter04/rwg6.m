%RWG6 Plots the surface current distribution along the dipole
%   Increase the number of sampling points, K, to obtain more 
%   accurate results 
%
%   Copyright 2002 AEMM. Revision 2002/03/11 
%   Chapter 4

clear all

%Load the data
load('mesh2');
load('current');

Index=find(t(4,:)<=1);
Triangles=length(Index);

%Find the current density Jx for every triangle
for k=1:Triangles
    i=[0 0 0]';
    for m=1:EdgesTotal
        IE=I(m)*EdgeLength(m);
        if(TrianglePlus(m)==k)
            i=i+IE*RHO_Plus(:,m)/(2*Area(TrianglePlus(m)));
        end
        if(TriangleMinus(m)==k)
            i=i+IE*RHO_Minus(:,m)/(2*Area(TriangleMinus(m)));
        end
    end
    CurrentNorm(1:2,k)=abs(i(1:2));
end

K=20;
x0=min(p(1,:));
x1=max(p(1,:));
y0=min(p(2,:));
y1=max(p(2,:));

for n=1:K+1
    y(n)=y0+(n-1)*(y1-y0)/K;
    Dist=repmat([0 y(n) 0]',[1,TrianglesTotal])-Center;
    [dummy,Index]=min( sum(Dist.*Dist));
    X(n)=CurrentNorm(1,Index); 
    Y(n)=CurrentNorm(2,Index); 
end
yi=[y0:(y1-y0)/100:y1];
Xi = interp1(y,X,yi,'cubic');
Yi = interp1(y,Y,yi,'cubic');
plot(yi,Xi,yi,Yi,'*');
xlabel('Dipole length, m')
ylabel('Surface current density, A/m')
grid on
