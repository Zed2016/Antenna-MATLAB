%LOOP2 Loop versus a phase delay for the linear array 
%   of dipoles. 
%   Outputs the radiation patterns in the azimuthal plane.
%   The array axis is the x-axis (cf. Fig. 6.10 of Chapter 6)
%   The dipole axis is the z-axis (cf. Fig. 6.10 of Chapter 6)
%
%   The following parameters need to be specified:
%   
%   Number of sampling points for phase sweep           K
%   Spacing between array elements (m)                  d
%   Number of dipoles in the array                      N
%
%   Copyright 2002 AEMM. Revision 2002/03/16 
%   Chapter 6


clear all
K=20;
Step=pi/K; %rad

d=1.0;
N=2;

multilinear(d,N);
rwg1; rwg2; rwg3;

for k=1:K+1
    k
    phase(k)    =-(k-1)*Step;
    Power1      =rwg4(phase(k));
    [PolarXY, GAIN, phi]    =efield3;
    PolarXYLoop (k,:)       =PolarXY;
    GainLoop    (k)         =GAIN; 
    PowerLoop  (k)          =Power1;
    Radius                  =max(PolarXY,0);
    x1(k,:)=Radius.*cos(phi); 
    y1(k,:)=Radius.*sin(phi);
    z1(k,:)=-phase(k)*ones(length(x1),1)';
end
surf(x1,y1,z1); colormap gray; rotate3d;
xlabel('gain, dB');
ylabel('gain, dB');
zlabel('-phase, rad');

view(-12,20)
save loop x1 y1 z1 K phi PolarXYLoop GainLoop PowerLoop phase    


  	 

   


      
         
         
