%MULTIBOWTIE
%   Creates a planar array of NxN bowties (or other antenna elements)
%   over a finite ground plane
%
%   The following parameters need to be specified:
%
%   Antenna element filename                    filename
%   Number of elements, N, in the NxN array     N
%   Maximum size of the element (m)             SizeE
%   Size of the square ground plane (m)         SizeP
%   Height of elements above ground plane (m)   Height
%   
%   Note that the following domain numbers are assigned:
%   Triangles of the metal ground plane     t(4,:)=0
%   Triangles of the antenna elements       t(4,:)=1 
%
%   Copyright 2002 AEMM. Revision 2002/03/06 
%   Chapter 6

clear all

filename='bowtie';    
N=8;
SizeE=0.5;
SizeP=6;
Height=0.5;

load(filename);
t(4,:)=1; 
tbase=t; 
p=p/max(max(p))*SizeE/2;

%Set centers of array elements
h=SizeP/N;
Count=1;
for i=1:N
    x(i)=h/2+(i-1)*h-SizeP/2;
    for j=1:N
        y(j)=h/2+(j-1)*h-SizeP/2;
        Feed(1:2,Count)=[x(i),y(j)]';
        Feed(3:3,Count)=Height;
        Indicator(Count)=(-1)^i;
        Count=Count+1;        
    end
end

%Clone array elements
P=[];
T=[];
X=p(1,:);
Y=p(2,:);    
for k=1:Count-1
    if(Indicator(k)==1)
        pbase(1,:)=X+Feed(1,k);
        pbase(2,:)=Y+Feed(2,k);
    else
        pbase(1,:)=Y+Feed(1,k);
        pbase(2,:)=X+Feed(2,k);
    end    
    pbase(3,:)=p(3,:)+Feed(3,k);
    P=[P pbase];    
    T=[T tbase+(k-1)*length(pbase)]; T(4,:)=1;    
end

%Attach the finite ground plane
clear p t;

L=SizeP;    %Plate length (along the x-axis)
W=SizeP;    %Plate width (along the y-axis)
Nx=16;      %Discretization parameter (length)
Ny=16;      %Discretization parameter (width)

plate(L,W,Nx,Ny);
load plate; 

t_=t+length(P); t_(4,:)=0;

p=[P p];    
t=[T t_]; 

TrianglesTotal=length(t)
save  array p t Feed
viewer('array')
grid on
