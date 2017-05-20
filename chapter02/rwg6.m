%RWG6 Compares the surface current distribution for the plate
%   with that given by Catedra, Cuevas, and Nuno, 
%   IEEE Trans. Antennas and Propagation
%   vol. AP-36, No 12, pp. 1744-1752, 1988.
%
%   Copyright 2002 AEMM. Revision 2002/03/05 
%   Chapter 2

clear all

%load the data
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
    CurrentNorm(k)=abs(i(1)); %here's the first component
end

%Comparison
K=15;
x0=min(p(1,:));
x1=max(p(1,:));
y0=min(p(2,:));
y1=max(p(2,:));

for n=1:K+1
    x(n)=x0+(n-1)*(x1-x0)/K;
    Dist=repmat([x(n) 0 0]',[1,TrianglesTotal])-Center;
    [dummy,Index]=min( sum(Dist.*Dist));
    X(n)=CurrentNorm(Index)*eta_; %eta_ means normalization over Hinc
end
for n=1:K+1
    y(n)=y0+(n-1)*(y1-y0)/K;
    Dist=repmat([0 y(n) 0]',[1,TrianglesTotal])-Center;
    [dummy,Index]=min( sum(Dist.*Dist));
    Y(n)=CurrentNorm(Index)*eta_; %eta_ means normalization over Hinc   
end
plot(x,X,y,Y);

%Data of Catedra et al.:
xi(1)=0.125; Xi(1)=1.625;
xi(2)=0.250; Xi(2)=2.083;
xi(3)=0.375; Xi(3)=2.604;
xi(4)=0.500; Xi(4)=2.896;
xi(5)=0.625; Xi(5)=2.604;
xi(6)=0.750; Xi(6)=2.083;
xi(7)=0.875; Xi(7)=1.625;

yi(1)=0.125*(0+1/2); Yi(1)=4.833;
yi(2)=0.125*(1+1/2); Yi(2)=2.6666;
yi(3)=0.125*(2+1/2); Yi(3)=2.75;
yi(4)=0.125*(3+1/2); Yi(4)=2.896;
yi(5)=0.125*(4+1/2); Yi(5)=2.896;
yi(6)=0.125*(5+1/2); Yi(6)=2.75;
yi(7)=0.125*(6+1/2); Yi(7)=2.6666;
yi(8)=0.125*(7+1/2); Yi(8)=4.833;
hold on
plot(xi-0.5,Xi,'*',yi-0.5,Yi,'*')
grid on
xlabel('x/lambda or y/lambda');
ylabel('Jx/Hinc')