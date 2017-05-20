%RWG2 Geometry calculations - all Chapters
%   Uses the mesh file from RWG1, mesh1.mat, 
%   as an input.
%
%   Creates the following parameters of the RWG edge elements: 
%
%   Position vector rho_c_plus from the free vertex of 
%   the "plus" triangle to its center
%                                   RHO_Plus(1:3,1:EdgesTotal)
%   Position vector rho_c_minus from the center of the "minus"
%   triangle to its free vertex 
%                                   RHO_Minus(1:3,1:EdgesTotal)
%
%   In addition to these parameters creates the following
%   arrays for nine subtriangles (barycentric subdivision):
%
%   Midpoints of nine subtriangles
%                                   Center_(1:3,1:9,1:TrianglesTotal)   
%   Position vectors rho_c_plus from the free vertex of 
%   the "plus" triangle to nine subtriangle midpoints
%                                   RHO__Plus(1:3,1:9,1:EdgesTotal)
%   Position vectors rho_c_minus from nine subtriangle midpoints
%   to the free vertex of the "minus" triangle
%                                   RHO__Minus(1:3,1:9,1:EdgesTotal)
%
%   See Rao, Wilton, Glisson, IEEE Trans. Antennas and Propagation,
%   vol. AP-30, No 3, pp. 409-418, 1982.
%
%   The modification for Chapters 6 and 7 passes the array 
%   Feed (see Chapter 6) 
%
%   Copyright 2002 AEMM. Revision 2002/03/14 Chapter 6

clear all

%load the data
load('mesh1')
%Find nine sub-triangle midpoints 
IMT=[];
for m=1:TrianglesTotal
    n1=t(1,m);
    n2=t(2,m);
    n3=t(3,m); 
    M=Center(:,m);
    r1=    p(:,n1);
    r2=    p(:,n2);
    r3=    p(:,n3);
    r12=r2-r1;
    r23=r3-r2;
    r13=r3-r1;
    C1=r1+(1/3)*r12;
    C2=r1+(2/3)*r12;
    C3=r2+(1/3)*r23;
    C4=r2+(2/3)*r23;
    C5=r1+(1/3)*r13;
    C6=r1+(2/3)*r13;
    a1=1/3*(C1+C5+r1);
    a2=1/3*(C1+C2+M);
    a3=1/3*(C2+C3+r2);
    a4=1/3*(C2+C3+M);
    a5=1/3*(C3+C4+M);
    a6=1/3*(C1+C5+M);
    a7=1/3*(C5+C6+M);
    a8=1/3*(C4+C6+M);
    a9=1/3*(C4+C6+r3);
    Center_(:,:,m)=...
        [a1 a2 a3 a4 a5 a6 a7 a8 a9];
end
%PLUS
for m=1:EdgesTotal
    NoPlus=TrianglePlus(m);
    n1=t(1,NoPlus);
    n2=t(2,NoPlus);
    n3=t(3,NoPlus); 
    if((n1~=Edge_(1,m))&(n1~=Edge_(2,m))) NODE=n1; end;
    if((n2~=Edge_(1,m))&(n2~=Edge_(2,m))) NODE=n2; end;
    if((n3~=Edge_(1,m))&(n3~=Edge_(2,m))) NODE=n3; end;
    FreeVertex=p(:,NODE);
    
    RHO_Plus(:,m)   =+Center(:,NoPlus)-FreeVertex;
    %Nine rho's of the "plus" triangle
    RHO__Plus(:,:,m)  =...
        +Center_(:,:,NoPlus)-repmat(FreeVertex,[1 9]);
end
%MINUS
for m=1:EdgesTotal
    NoMinus=TriangleMinus(m);
    n1=t(1,NoMinus);
    n2=t(2,NoMinus);
    n3=t(3,NoMinus); 
    if((n1~=Edge_(1,m))&(n1~=Edge_(2,m))) NODE=n1; end;
    if((n2~=Edge_(1,m))&(n2~=Edge_(2,m))) NODE=n2; end;
    if((n3~=Edge_(1,m))&(n3~=Edge_(2,m))) NODE=n3; end;
    FreeVertex=p(:,NODE);
    
    RHO_Minus(:,m)   =-Center(:,NoMinus) +FreeVertex;
    %Nine rho's of the "minus" triangle
    RHO__Minus(:,:,m)=...
        -Center_(:,:,NoMinus)+repmat(FreeVertex,[1 9]);
end

%Save result
save mesh2  p ...
            t ...            
            TrianglesTotal ...
            EdgesTotal ...
            Edge_ ...
            TrianglePlus ...
            TriangleMinus ...
            EdgeLength ...
            EdgeIndicator ...
            Area ...
            RHO_Plus ...
            RHO_Minus ...
            RHO__Plus ...
            RHO__Minus ...
            Center ...
            Center_ ...
            Feed