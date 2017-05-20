%BOWTIE Bowtie mesh in the xy plane
%
%   The following parameters need to be specified:
%
%   Discretization parameter            N
%   Half-height of bowtie               h
%   Width of the feeding neck           d
%   Bowtie flare angle                  flareangle
%
%   Change(decrease) the width of the feeding neck 
%   if inaccurate results are obtained
%
%   Copyright 2002 AEMM. Revision 2002/03/25
%   Chapter 7

clear all

N=24;               %Discretization parameter
h=0.1;              %Half-height of bowtie
d=0.01;             %Width of the feeding neck 
flareangle=pi/2;    %Bowtie flare angle

StepY=h/N;
TAN=tan(flareangle/2);

%Set y grid (from -h to h)
for j=1:N+1
    y(j,1)=-h+2*(j-1)*StepY;
end

%Set x grid (from d/2 to upper boundary)
for i=1:N/2+1
    Vector(i,1)=TAN*y(N/2+i)+d/2;
end

%Set left and right boundary
XLeft   =[-Vector(N/2+1:-1:1); -Vector(2:N/2+1)];
XRight  =[+Vector(N/2+1:-1:1); +Vector(2:N/2+1)];

%Initialize amd plot polygon, which encloses bowtie
Xpol=[XLeft; XRight(N+1:-1:1)];
Ypol=[y; y(N+1:-1:1)];

fill(Xpol, Ypol,'g'); axis('equal'); pause(0.5);
hold on

%Initialize vertexes inside bowtie
L=1;
for j=1:N+1
    M(j)=abs(j-N/2-1)+1; 
    StepX=(XRight(j)-XLeft(j))/M(j);
    for i=1:M(j)+1
        X(L)=XLeft(j)+(i-1)*StepX;
        Y(L)=y(j);
        L=L+1;
    end
end

%Use Delaunay triangulation
TRI = delaunay(X,Y); 
t=TRI';
p=[X; Y; zeros(1,length(X))];
q=trimesh(t',X,Y,zeros(size(X)));
pause(0.5)
hold off

%Remove unnecessary triangles
for m=1:length(t)
    Center(:,m)=1/3*sum(p(:,t(:,m)),2);
end
IN = inpolygon(Center(1,:), Center(2,:), Xpol,Ypol);

TrianglesTotal=length(t); 
Triangle=[];
for m=1:TrianglesTotal
   if(IN(m)==1)
        Triangle=[Triangle t(:,m)];
   end
end
clear t; t=Triangle;
TrianglesTotal=length(t);
t(4,:)=1;

%Save result
save bowtie p t;
viewer bowtie
view(0,90)
