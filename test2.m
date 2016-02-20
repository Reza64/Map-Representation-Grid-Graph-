% An example which get the source and destination nodes from the figure and
% mouse as inputs
% filename, name of the input image
% drate, the rate of iscritization or tiling 
% showflag, it will show the output image if it is set to 1

close all;
clear all;
clc;

% initializing parameters
filename='testmap_500_500.png';
drate = 9;
showflag=1;

% create the grid graph
G=CreateGridGraph(filename,drate,showflag);

% get the source and destination nodes from inputs, 4 points in this example 
if (~showflag)
        imshow(G.mapshow);
end

% p1=[x1,x2,...]
% p2=[y1,y2,...]
[p1,p2] = ginput(4);
%convert real position on the map to the corresponding graph node index
[p1,p2]=ConvertPos2Point(G,p1,p2);

% compute shortest path between input points 
path=ComputePath(G,p1,p2);

% show the path between points
ShowPath(G,path);
