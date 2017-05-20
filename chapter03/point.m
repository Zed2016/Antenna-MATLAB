function[EField, HField]=...
    point1(Point,eta_,K,DipoleMoment,DipoleCenter)

%POINT Radiated/scattered field at a point of a dipole array 
%   or a single dipole. Gives exact near- and far-fields. Outputs
%   individual contribution of each dipole.
%
%   Observation point                   Point(1:3)         
%   Array of dipole moments             DipoleMoment(1:3,1:EdgesTotal) 
%   Array of dipole centers             DipoleCenter(1:3,1:EdgesTotal)
%   E-field at the observation point    E(1;3,1:EdgesTotal)
%   H-field at the observation point    H(1;3,1:EdgesTotal)
%
%   Copyright 2002 AEMM. Revision 2002/03/11 
%   Chapter 3

C=4*pi;
ConstantH=K/C;
ConstantE=eta_/C;
    
m=DipoleMoment;
c=DipoleCenter;
r       =repmat(Point,[1 length(c)])-c(1:3,:);
PointRM =repmat(sqrt(sum(r.*r)),[3 1]);
EXP     =exp(-K*PointRM);
PointRM2=PointRM.^2;
C=1./PointRM2.*(1+1./(K*PointRM));
D=repmat(sum(r.*m),[3 1])./PointRM2;
M=D.*r;
HField=ConstantH*cross(m,r).*C.*EXP;
EField=ConstantE*((M-m).*(K./PointRM+C)+2*M.*C).*EXP;
    



      
         
         
