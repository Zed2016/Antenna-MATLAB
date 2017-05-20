function []=plate(W,L,Nx,Ny);
%PLATE Plate mesh in the xy-plane -function
%
%   W   Plate width (along the x-axis)
%   L   Plate length (along the y-axis)
%   Nx  Discretization parameter (width)
%   Ny  Discretization parameter (length)
%
%   Copyright 2002 AEMM. Revision 2002/03/16 
%   Chapter 6; see also the equivalent script plate.m
%   of Chapter 2 and Appendix A.

if nargin < 4
  error('function plate requires four input arguments.')
end

warning off

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
t(4,:)=0;
p=[X; Y; zeros(1,length(X))];

%Save result
save plate p t;
