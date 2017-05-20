%RWG5SINGLE Visualizes the surface current magnitude 
%   at a particular frequency
%   Uses the mesh file from RWG2, mesh2.mat, and 
%   the file containing surface current coefficients, current.mat, 
%   from RWG3 as inputs.
%
%   The following parameters need to be specified:
%
%   Frequency value [Hz]            FreqToPlot
%
%   Copyright 2002 AEMM. Revision 2002/03/23 
%   Chapter 7

clear all
load('mesh2');
load('current');
FreqToPlot=75e6

[dummy,FF]=min(abs(FreqToPlot-f));
f(FF)
I(:,1)=CURRENT(:,FF);

Index=find(t(4,:)<=1);
Triangles=length(Index);

%Find the current density for every triangle
for k=1:TrianglesTotal
   i=[0 0 0]';
   for m=1:EdgesTotal
      if(TrianglePlus(m)==k)
         i=i+I(m)*EdgeLength(m)*RHO_Plus(:,m)/(2*Area(TrianglePlus(m)));
      end
      if(TriangleMinus(m)==k)
         i=i+I(m)*EdgeLength(m)*RHO_Minus(:,m)/(2*Area(TriangleMinus(m)));
      end
   end
   CurrentNorm(k)=abs(norm(i));
end

Jmax=max(CurrentNorm);
MaxCurrent=strcat(num2str(Jmax),'[A/m]')
CurrentNorm1=CurrentNorm/max(CurrentNorm);
for m=1:Triangles
    N=t(1:3,m);
    X(1:3,m)=[p(1,N)]';
    Y(1:3,m)=[p(2,N)]';
    Z(1:3,m)=[p(3,N)]';      
end
C=repmat(CurrentNorm1,3,1);

h=fill3(X, Y, Z, C); %linear scale
%colormap copper;
colormap gray;
brighten(0.20);
axis('equal');
view(0,90);