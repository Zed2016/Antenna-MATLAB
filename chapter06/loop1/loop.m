%LOOP1 Loop versus a separation distance for the linear array 
%   of dipoles. 
%   Outputs the terminal impedance and total 
%   radiated power assuming 1V feed voltage
%   The array axis is the x-axis (cf. Fig. 6.10 of Chapter 6)
%   The dipole axis is the z-axis (cf. Fig. 6.10 of Chapter 6)
%
%   The following parameters need to be specified:
%   
%   Number of sampling points for separation distance   M
%   Starting separation distance (m)                    dS
%   Final separation distance    (m)                    dF
%   Number of dipoles in the array                      N
%
%   Copyright 2002 AEMM. Revision 2002/03/16 
%   Chapter 6

clear all

M=100;
dS=0.2;
dF=20;

Step=(dF-dS)/M;

for k=1:M
    k
    d(k)=dS+(k-0.5)*Step;
    multilinear(d(k));
    drawnow;
    rwg1;
    rwg2;
    rwg3;
    [Impedance(k,:), PowerSum(k)]=rwg4;
end
save loop d Impedance PowerSum

plot(d,real(Impedance(:,1)));
xlabel('separation distance, m')
ylabel('terminal resistance, ohm')
grid on

b=figure
plot(d,imag(Impedance(:,1)));
xlabel('separation distance, m')
ylabel('terminal reactance, ohm')
grid on

c=figure
plot(d,PowerSum);
xlabel('separation distance, m')
ylabel('total radiated power, W')
grid on      