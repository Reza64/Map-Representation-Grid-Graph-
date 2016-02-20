% In this example 4 points are set as the sources and destinations
% filename, name of the input image
% drate, the rate of iscritization or tiling 
% showflag, it will show the output image if it is set to 1

close all;
clear all;
clc;

% initializing parameters
filename='testmap_883_556.png';
drate = 21;
showflag=1;

% create the grid graph
G=CreateGridGraph(filename,drate,showflag);

% these are the index of nodes in the graph
% p1=[x1,x2,...]
% p2=[y1,y2,...]
p1=[99,993]; 
p2=[149,890];
path=ComputePath(G,p1,p2);

% path=ComputePath(startpoint,endpoint);
ShowPath(G,path);
