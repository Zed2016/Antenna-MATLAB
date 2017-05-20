%PLATE Plate mesh in the xy plane - all Chapters
%   
%   Copyright 2002 AEMM. Revision 2002/04/10

clear all
warning off

W=2.00;         %Plate width (along the x-axis)
L=2.00;         %Plate length (along the y-axis)
Nx=20;          %Discretization parameter (width)
Ny=20;          %Discretization parameter (length)

%Set vertexes
epsilon=1e-6;
M=1;
for i=1:Nx+1
    for j=1:Ny+1
        X(M)=-W/2+(i-1)/Nx*W;
        Y(M)=-L/2+(j-1)/Ny*L-epsilon*X(M);
        M=M+1;
    end
end

%Use Delaunay triangulation
TRI = delaunay(X,Y,0);
t=TRI';
t(4,:)=1;
p=[X; Y; zeros(1,length(X))];

%Save result
save plate p t;
viewer plate

