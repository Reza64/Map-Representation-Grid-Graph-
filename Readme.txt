This program is build by Reza Javanmard Alitappeh, 2015
It might be useful for the people who are working in robotic area or artificial intelligence
it contains: tiling or discretizing the input map, path planning (shortest path)
sparse grid graph etc.

% The main function converts (discretizes) an input image (.png, .jpg, .bmp) into a grid
% graph (grid cells) in a shape of sparse matrix. Furthure, dijkstra algorithm is
% applied to find the shortest path between points.
% To consider the neighboir cellls, 8 connectivity is used:
%  0\--0--/0
%  |--\|/--|
%  0---@---0
%  |--/|\--|
%  0/--0--\0
%------------------------------------------------
% Graph=CreateGraph (filename,drate,showflag)
% ** filename is the black-white input image file with size 'n*m', black
% points are obstacles (there won't be any node over those cells) and white ones are
% free space,
% ** drate is the discretization ratio (cell or tile size), if we set this rate to 1, for each
% pixel in the image we will have a node in the graph.  
% ** showflag, is to show the output image 
% the output graph is saced as sparse matrix
% the nodes are presented in a 1D vector, thus a 'k' biy'l' matrix is shown by a
% vecotr with 'k*l' cells: [row 1, row 2,... row k]
% the reference frame (0,0) in the image is considered in left-up
% |(0,0)----------...
% |
% |
% .
% .
% .

% -------------------------------------------------