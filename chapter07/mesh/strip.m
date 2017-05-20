%STRIP Creates a dipole antenna (thin strip) in the 
%   xz-plane (not the xy-plane as it was in Chapter 4!)
%
%   The following parameters need to be specified:
%
%   Strip width (along the x-axis)          W
%   Strip length (along the z-axis)         L
%   Discretization parameter (width)        Nx
%   Discretization parameter (length)       Ny
%
%   Note: the equivalent wire radius is 0.25*W
%
%   For more general version of this script please 
%   see strip_.m of Appendix A.
%
%   Copyright 2002 AEMM. Revision 2002/03/25 
%   Chapter 7

clear all
warning off

W=0.02;     
L=1.00;     
Nx=1; 
Ny=150;

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

%Rotate strip
p(3,:)=p(1,:);
p(1,:)=p(2,:);
p(2,:)=0;

%Save mesh file
save strip p t;
viewer strip