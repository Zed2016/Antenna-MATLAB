function [CatX, CatY, T1X, T1Y, T2X, T2Y, T3X, T3Y]=divider(InpX, InpY, TAN);
%DIVIDER a function supporting fractal.m
%   For an arbitrary triangle this function outputs
%   the central subtriangle to be cut and three 
%   remaining subtriangles
%
%   Copyright 2002 AEMM. Revision 2002/03/25
%   Chapter 7

h=max(InpY)-min(InpY);
CenterX=0.5*(min(InpX)+max(InpX));
CenterY=0.5*(min(InpY)+max(InpY));

CatX=[-h/2*TAN 0 h/2*TAN]'+CenterX;
CatY=[ 0 h/2 0]'+CenterY;

T1X=[-h*TAN -h/2*TAN 0]'+CenterX;
T1Y=[h/2 0 h/2]'+CenterY;

T2X=[0 h/2*TAN h*TAN]'+CenterX;
T2Y=[h/2 0 h/2]'+CenterY;

T3X=[-h/2*TAN 0 h/2*TAN]'+CenterX;
T3Y=[0 -h/2 0]'+CenterY;

