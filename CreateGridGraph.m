function Graph=CreateGridGraph (filename,drate,showflag)

% This function converts (discretizes) an input image (.png, .jpg, .bmp) into a grid
% graph (grid cells) in a shape of sparse matrix. Furthure, dijkstra algorithm is
% applied to find the shortest path between points.
% To consider the neighboir cellls, 8 connectivity is used:
%  0\--0--/0
%   |--\|/--|
%  0---@---0
%   |--/|\--|
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

if nargin < 1   % demo mode
    drate = 19; 
    filename  = 'testmap_883_556.png';
    showflag=1;
end

% read the input image and convert to a binary map
map=imread(filename);
mapshow=map;
if (showflag)
    figure,
    imshow(map);
end
map=rgb2gray(map);
map=logical(map);
imgcol=size(map,2);
imgrow=size(map,1);
row=round(imgrow/drate); 
col=round(imgcol/drate); 
cubsize=floor(drate/2);

%% -------------<Create the spars matrix of map>---------------
fprintf('discretizing the map...\n');
rowindx=[-1,-1,-1,0,1,1,1,0];
colindx=[-1,0,1,1,1,0,-1,-1];
cnt=1;
for i=0:row-1
    for j=0:col-1
        if (Checkobs(map,i,j,cubsize,drate)~=0)
            indx1=(j+1)+(col*(i));
            point(1:3,indx1)=[i;j;indx1]; %x,y,value
            cnttemp=0;
            for p=1:8
                r=i+rowindx(p);
                c=j+colindx(p);
                cnttemp=cnttemp+1;
                % check whether the cell is occupied by obstacle or it is out
                % of range 
                if(r>=0 && r<row && c>=0 && c<col && Checkobs(map,r,c,cubsize,drate)~=0)
                    indx2=((r)*col)+(c+1);
                    if(indx1~=indx2)
                        if (cnttemp==2 || cnttemp==4 || cnttemp==6 || cnttemp==8)
                            indx1Mat(1,cnt)=indx1;
                            indx1Mat(2,cnt)=indx2;
                            weight(cnt)=1;
                            SpMatrix(indx1,indx2)=1;
                            cnt=cnt+1;
                        else
                            indx1Mat(1,cnt)=indx1;
                            indx1Mat(2,cnt)=indx2;
                            weight(cnt)=1.4;
                            SpMatrix(indx1,indx2)=1.4;
                            cnt=cnt+1;
                        end
                    else
                        fprintf('else \n');
                    end
                end % if(r>=1 && r<row && c>=1 && c<col && map(r,c)~=0)
            end % p=1:8
            % show points (center of cells)
            ii=i*drate+round(drate/2);
            jj=j*drate+round(drate/2);
            mapshow(ii-2:ii+2,jj-2:jj+2)=uint8(1);
        else
            indx1=(j+1)+(col*(i));
            point(1:3,indx1)=0; %x            
        end %if (map(i,j)~=1) it's not an obstacle
        ii=i*drate+drate/2;
        jj=j*drate+drate/2;
    end%end for col  number
end%end first for row

if (showflag)
    imshow(mapshow);
end

% conver to a sparce matrix
[I,J,S] = find(SpMatrix);
[m n]=size(SpMatrix);
DG = sparse(I,J,S,m,n);

% output graph
Graph.g=DG;
Graph.points=point;
Graph.map=map;
Graph.mapshow=mapshow;
Graph.drate=drate;
