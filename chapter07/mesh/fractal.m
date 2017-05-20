%FRACTAL Mesh for the fractal antenna in the xy-plane
%
%   The following parameters need to be specified:
%
%   Stage of fractal growth             S
%   Stage of mesh growth                SM
%   Half-height of equivalent bowtie    h
%   Flare angle of equivalent bowtie    flareangle
%
%   If S=1 then SM=5,7,... or higher
%   If S=2 then SM=5,7,... or higher
%   If S=3 then SM=5,7,... or higher
%   If S=4 then SM=7,... or higher
%
%   Copyright 2002 AEMM. Revision 2002/03/25
%   Chapter 7
%   PS. This code is too complicated. Should be made simpler 

clear all

%Geometry data
S=2;                    %Stage of fractal growth
SM=5;                   %Stage of mesh growth
h=0.1;                  %Half-height of bowtie
flareangle=(0.5)*pi;    %Bowtie flare angle
TAN=tan(flareangle/2);

%Identify vertex points
Count=1;
for s=1:SM^2
    StepY=h/(SM^2-1);
    y=(s-1)*StepY;
    fuzzy=1-0.0001*s;
    for ss=1:s
        StepX=2*StepY*TAN;
        x=-y*TAN+StepX*(ss-1);
        X(Count)=x*fuzzy;
        Y(Count)=y;
        Count=Count+1;
    end
end

%Create mesh triangles
p=[X; Y; zeros(1,length(X))];
TRI = delaunay(X,Y); 
t=TRI';
TrianglesTotal=length(t);

for m=1:length(t)
    n1=t(1,m); n2=t(2,m); n3=t(3,m);       
    Center(:,m)=1/3*(p(:,n1)+p(:,n2)+p(:,n3));
end

%Create fractal triangles
%Initial triangle
ArrayOfTrianglesX(:,1)=[-h*TAN 0 h*TAN]';
ArrayOfTrianglesY(:,1)=[h 0 h]';
CatPolygonX=[];
CatPolygonY=[];

for s=1:S
    Length=length(ArrayOfTrianglesX(1,:));
    ArrayOfTrianglesX1=[];
    ArrayOfTrianglesY1=[];
    for i=1:Length
        InpX=ArrayOfTrianglesX(:,i);
        InpY=ArrayOfTrianglesY(:,i);
        [CatX, CatY, T1X, T1Y, T2X, T2Y, T3X, T3Y]=divider(InpX, InpY, TAN);
        CatPolygonX=[CatPolygonX CatX];
        CatPolygonY=[CatPolygonY CatY];
        ArrayOfTrianglesX1=[ArrayOfTrianglesX1 T1X T2X T3X];
        ArrayOfTrianglesY1=[ArrayOfTrianglesY1 T1Y T2Y T3Y];
    end
    ArrayOfTrianglesX=ArrayOfTrianglesX1;
    ArrayOfTrianglesY=ArrayOfTrianglesY1;    
end

Length=length(CatPolygonX(1,:));
ING=zeros(1,length(t));
for i=1:Length
    ING = ING+inpolygon(Center(1,:), Center(2,:), CatPolygonX(:,i),CatPolygonY(:,i));
end

%Triangles to remove
for i=1:Length
    IN      =inpolygon(Center(1,:), Center(2,:), CatPolygonX(:,i),CatPolygonY(:,i));
    Index   =find(IN==1);
    Array  =sqrt((Center(1,Index)-CatPolygonX(1,i)).^2+(Center(2,Index)-CatPolygonY(1,i)).^2);
    [Y,I]=min(Array);
    ING(Index(I))=0;
    Array  =sqrt((Center(1,Index)-CatPolygonX(2,i)).^2+(Center(2,Index)-CatPolygonY(2,i)).^2);
    [Y,I]=min(Array);
    ING(Index(I))=0;
    Array  =sqrt((Center(1,Index)-CatPolygonX(3,i)).^2+(Center(2,Index)-CatPolygonY(3,i)).^2);
    [Y,I]=min(Array);
    ING(Index(I))=0;
end

%Remove unnecessary triangles
TrianglesTotal=length(t);
Triangle=[];
for m=1:TrianglesTotal
   if(ING(m)==0)
        Triangle=[Triangle t(:,m)];
   end
end
clear t;
t=Triangle(:,2:length(Triangle)); %first triangle is removed 
TrianglesTotal=length(t);
t(4,:)=1;

%Add mirror image to structure 
p(2,:)=p(2,:)-StepY;
pbase=-p; tbase=t;
t=[tbase t+length(pbase)]; t(4,:)=1;
p=[pbase p];

%Eliminate equal points
length(p)
P(1:3,1)=p(1:3,1);
for L=2:length(p)
   [M,N]=size(P);
   Point=p(1:3,L);
   Index=find(abs(sum(abs(P-repmat(Point,1,N))))<1.e-9);
   if (isempty(Index))
       P=[P Point];
   end  
end
length(P)

%Re-enumerate triangle points
[M,N]=size(P);
for L=1:length(t);
    n=t(:,L);
    for i=1:3
        Index=find(abs(sum(abs(P-repmat(p(1:3,n(i)),1,N))))<1.e-9);
        if(~isempty(Index))
            t(i,L)=Index;
        end
    end
    t(4,L)=1;
end
clear p; p=P;

%Save result
save fractal p t;
viewer fractal
view(0,90)