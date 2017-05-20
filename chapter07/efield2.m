%EFIELD2 Radiated/scattered field over a large sphere
%   Calculates gain and total radiated power as functions of frequency
%   Uses the mesh file from RWG2, mesh2.mat, and
%   the file containing surface current coefficients,
%   current.mat, from RWG3 as inputs.
%
%   Uses the structure sphere.mat/sphere1.mat to display 
%   radiation intensity distribution. The sphere doesn't 
%   intersect the surface.
%
%   The following parameters need to be specified:
%   
%   Sphere radius (m)
%
%   Copyright 2002 AEMM. Revision 2002/03/25 
%   Chapter 7

clear all
%load the data
load('mesh2');
load('sphere');
load('current');
p=1000*p;    %observation sphere - radius is 1000 m

%Frequency series
 for FF=1:NumberOfSteps   
    FF
    omega=2*pi*f(FF);
    k=omega/c_;
    K=j*k;
    
    for m=1:EdgesTotal
        Point1=Center(:,TrianglePlus(m));
        Point2=Center(:,TriangleMinus(m));
        DipoleCenter(:,m)=0.5*(Point1+Point2);
        DipoleMoment(:,m)=EdgeLength(m)*CURRENT(m,FF)*(-Point1+Point2); 
    end
        
    TotalPower(FF)=0;
    %Sphere series
    M=length(t);
    for m=1:M
        N=t(1:3,m);
        ObservationPoint=1/3*sum(p(:,N),2);
        [E,H]=point(ObservationPoint,eta_,K,DipoleMoment,DipoleCenter);
        ET=sum(E,2); HT=sum(H,2);
        Poynting(:,m)=0.5*real(cross(ET,conj(HT)));
        U(m)=(norm(ObservationPoint))^2*norm(Poynting(:,m));    
        Vector1=p(:,N(1))-p(:,N(2));
        Vector2=p(:,N(3))-p(:,N(2));
        Area =0.5*norm(cross(Vector1,Vector2)); 
        TotalPower(FF)=TotalPower(FF)+norm(Poynting(:,m))*Area;
    end
    
    TotalPower(FF)
    GainLinear(FF)=4*pi*max(U)/TotalPower(FF);
    GainLogarithmic(FF)=10*log10(GainLinear(FF));
    
end
FileName=strcat('gainpower.mat'); 
save(FileName,'f','GainLinear', 'GainLogarithmic','TotalPower');

