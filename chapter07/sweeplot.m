%SWEEPLOT Plots the input impedance (resistance/reactance),
%   reflection coefficient, antenna gain, and total radiated power 
%   as functions of frequency
%
%   Uses current.mat as an input to load the impedance data
%   Uses gainpower.mat as an input to load the gain/power data
%   Run this script after RWG3.m and EFIELD2.m
%
%   Copyright 2002 AEMM. Revision 2002/03/23 
%   Chapter 7

clear all
load('current.mat');

%Plot impedance (real+imag)
a=figure
plot(f, real(Impedance));
xlabel ('Frequency, Hz')
ylabel('Input  resistance, Ohm')
%axis([0 8000e6 0 400])
grid on
b=figure
plot(f, imag(Impedance));
xlabel ('Frequency, Hz')
ylabel('Input  reactance, Ohm')
%axis([0 8000e6 -250 150])
grid on

%Plot reflection coefficient(return loss) versus 50 Ohm
c=figure
Gamma=(Impedance-50)./(Impedance+50);
Out=20*log10(abs(Gamma));
plot(f, Out);
xlabel ('Frequency, Hz')
ylabel('Reflection Coefficient, dB')
grid on

%Plot gain and power
load('gainpower.mat')

d=figure
plot(f,GainLogarithmic);
xlabel('Frequency, Hz')
ylabel('Gain, dB')
grid on
e=figure
plot(f, TotalPower);
xlabel('Frequency, Hz')
ylabel('Radiated power, W')
%axis([0 8000e6 0 0.018])
grid on


