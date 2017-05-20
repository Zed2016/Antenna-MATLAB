%EFIELD4 Radiation pattern for a linear array of dipoles (xy-plane)
%
%   The array axis is the x-axis (cf. Fig. 6.10 of Chapter 6)
%   The dipole axis is the z-axis (cf. Fig. 6.10 of Chapter 6)
%   Uses the array factor without mutual coupling - Eq. (6.15)
%   and Eq.(6.16)
%
%   The following parameters need to be specified:
%   
%   Frequency (Hz)                  f
%   Dipole spacing (m)              d
%   Number of array elements        N
%   Incremental phase shift (rad)   delta 
%   Number of points per pattern    NumPoints
%
%   Copyright 2002 AEMM. Revision 2002/03/06 
%   Chapter 6

%hold on
d=10;               % dipole spacing, m
f=75e6;             % frequency in Hz
k=2*pi*f/3e8;       % wavenumber
delta=-1.000*pi;    % phase shift 
N=4;                % number of array elements


%xy-pattern
NumPoints=201;
epsilon=1e-9;
for i=1:NumPoints
   phi(i)=(i-1)*pi/((NumPoints-1)/2);
   psi(i)=k*d*cos(phi(i))+delta+epsilon;
   ArrayFactor(i)=abs( sin(N*psi(i)/2)/sin(psi(i)/2) );
end
PolarXY=10*log10(ArrayFactor)+2.15;
polar(phi,max(PolarXY,0),'--');
