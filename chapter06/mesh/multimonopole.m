%MULTIMONOPOLE
%   Creates an array of N base-fed 
%   monopoles on a finite ground plane
%
%   Uses mouse input to identify the junction edges
%
%   Note that the following domain numbers are assigned:
%   Triangles of the metal ground plane     t(4,:)=0
%   Triangles of the monopoles              t(4,:)=1 
%
%   Copyright 2002 AEMM. Revision 2002/03/06 
%   Chapter 4

clear all
warning off

%   The following parameters need to be specified:

L=2.0;      %Plate length (along the x-axis)
W=2.0;      %Plate width (along the y-axis)
Nx=16;      %Discretization parameter (length)
Ny=16;      %Discretization parameter (width)
h=1.0;      %Monopole height
Number=7;   %Number of monopole rectangles

plate(L,W,Nx,Ny);
viewer plate; view(0,90);
load plate;
hold on

FeedingTriangle=[];
TRI=t(1:3,:)';
%Mouse input
while ~isempty(t)
    [xi,yi]=ginput(1);
    TriangleNumber = tsearch(p(1,:),p(2,:),TRI,xi,yi);
    n=t(1:3,TriangleNumber);
    FeedingTriangle= [FeedingTriangle TriangleNumber];
    x= p(1,n);
    y= p(2,n);
    if isempty(xi|yi) break; end
    fill(x,y,'w')
    clear xi yi
end
clear figure

%Create the monopole(s)
for n=1:length(FeedingTriangle)/2
    %find feeding edge
    FT=[FeedingTriangle(2*n-1) FeedingTriangle(2*n)];
    N=t(1:3,FT(1));
    M=t(1:3,FT(2));
    a=1-all([N-M(1) N-M(2) N-M(3)]);
    Edge_B=M(find(a));
    Feed(:,n)=0.5*(p(:,Edge_B(1))+p(:,Edge_B(2)));
    %set top edge
    p=[p p(:,Edge_B(1))+[0;0;h] p(:,Edge_B(2))+[0;0;h]];
    Edge_T  =[length(p)-1; length(p)];
    %fill the strip
    Edge_MM=Edge_B;
    for k=1:Number-1
        p(:,length(p)+1)=k/Number*(p(:,Edge_T(1))-p(:,Edge_B(1)))+p(:,Edge_B(1));
        p(:,length(p)+1)=k/Number*(p(:,Edge_T(2))-p(:,Edge_B(2)))+p(:,Edge_B(2));
        Edge_M=[length(p)-1,length(p)];
        tFeed1(:,k)  =[Edge_MM(1);Edge_MM(2);Edge_M(2);1];
        tFeed2(:,k)  =[Edge_MM(1);Edge_M(1);Edge_M(2);1];
        Edge_MM=Edge_M;
    end
    %update array t
    tFeed3  =[Edge_M(1);Edge_M(2);Edge_T(2);1];
    tFeed4  =[Edge_M(1);Edge_T(1);Edge_T(2);1];
    t=[t tFeed1 tFeed2 tFeed3 tFeed4];
end

save array p t Feed
hold off
clear figure
viewer array
grid on
    
    
    




