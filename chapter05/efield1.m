%EFIELD1 Radiated/scattered field at a point
%   The point is outside the metal surface
%   Uses the mesh file from RWG2, mesh2.mat, and
%   the file containing surface current coefficients,
%   current.mat, from RWG4 as inputs.
%
%   The following parameters need to be specified:
%   
%   Observation point           ObservationPoint[X; Y; Z] (m)
%
%   Copyright 2002 AEMM. Revision 2002/03/11 
%   Chapter 3


clear all
%Load the data
load('mesh2');
load('current');

k=omega/c_;
K=j*k;

for m=1:EdgesTotal
    Point1=Center(:,TrianglePlus(m));
    Point2=Center(:,TriangleMinus(m));
    DipoleCenter(:,m)=0.5*(Point1+Point2);
    DipoleMoment(:,m)=EdgeLength(m)*I(m)*(-Point1+Point2); 
end

ObservationPoint=[100; 0; 0];
[E,H]=point(ObservationPoint,eta_,K,DipoleMoment,DipoleCenter);

%find the sum of all dipole contributions
EField=sum(E,2); HField=sum(H,2);

%Common
EField                  %Radiated/scattered electric field 
                        %(complex vector at a point, V/m)

HField                  %Radiated/scattered magnetic field 
                        %(complex vector at a point, A/m)            

Poynting=0.5*real(cross(EField,conj(HField)))           
                        %Poynting vector (W/m^2) for radiated/scattered field

W=norm(Poynting)        %Radiation density (W/m^2) for radiated/scattered field
   
U=norm(ObservationPoint)^2*W                            
                        %Radiation intensity (W/unit solid angle)                     

%Only scattering
RCS=4*pi*(norm(ObservationPoint))^2*sum(EField.*conj(EField));     
                        %Backscattering radar cross-section (scattering)


         
