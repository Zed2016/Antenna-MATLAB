%RWG5 Visualizes the surface current magnitude 
%   Uses the mesh file from RWG2, mesh2.mat, and
%   the file containing surface current coefficients,
%   current.mat, from RWG4 as inputs.
%
%   Copyright 2002 AEMM. Revision 2002/03/05 
%   Chapter 2

clear all

%load the data
load('mesh2');
load('current');

Index_=find(t(4,:)<=1);
Triangles=length(Index_);

%Find the current density for every triangle
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
    CurrentNorm(k)=abs(norm(i));
end

MAX=max(CurrentNorm);
MIN=min(CurrentNorm);

format long
CurrentMax=MAX*EdgeLength(Index)
CurrentMin=MIN*EdgeLength(Index)
format short

CurrentNorm1=CurrentNorm/max(CurrentNorm);
for m=1:Triangles
    N=t(1:3,m);
    X(1:3,m)=[p(1,N)]';
    Y(1:3,m)=[p(2,N)]';
    Z(1:3,m)=[p(3,N)]';      
end
C=repmat(CurrentNorm1,3,1);


h=fill3(X, Y, Z, C); %here's the linear scale
colormap gray;
axis('equal');
rotate3d
