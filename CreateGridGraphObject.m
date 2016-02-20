Graph=CreateGridGraphObject(filename,drate,robsize)

% This function converts an input image(.png, .jpg, .bmp) into a grid graph
% with 8 neighboring
% Graph=CreateGraph (filename,drate)
% filename is the black-white input image file with size n*m, black objects
% are obstacles (there will not be any node over those cells) and white are
% where is free space, and drate is the discritization ratio
% if we set this rate to 1, for each pixel in the image we will have a node
% in the graph. 
% in case of we would have a bigger object than a point which might move
% over the environment, in order to compute the free configuration space
% robsize can be used, its size is in pixel

% the reference frame (0,0) in the image is considered in left-up
% |(0,0)----------...
% |
% |
% .
% .
% .

% -------------------------------------------------
% the output is a sparse matrix of a grid graph

if nargin < 1   % demo mode
    drate = 5;
    filename  = 'test.png';
end

map=imread('beatch1.png');
oufilename='SparseMatrix_beach_21.mat'
rgbmap=map;
map=im2bw(map,0.9312);
imshow(map);
 map=logical(map);
% imagesc(map);
% must be even
drate=21;
imgcol=size(map,2);
imgrow=size(map,1);
row=round(imgrow/drate); % x=row index
col=round(imgcol/drate); % y=col index
cubsize=floor(drate/2);
Sx=drate;
% |------------------
% | (0,0)
% |
% |
%% -------------<Create the spars matrix of map>---------------
rowindx=[-1,-1,-1,0,1,1,1,0];
colindx=[-1,0,1,1,1,0,-1,-1];
cnt=1;
for i=0:row-1
    i
    for j=0:col-1
        if (Checkobs(map, i,j,cubsize,Sx)~=0)
            indx1=(j+1)+(col*(i));
            out(1,indx1)=i; %x
            out(2,indx1)=j; %y
            out(3,indx1)=indx1; % flag
            cnttemp=0;
            for p=1:8
                r=i+rowindx(p);
                c=j+colindx(p);
                cnttemp=cnttemp+1;
                if(r>=0 && r<row && c>=0 && c<col && Checkobs(map,r,c,cubsize,Sx)~=0)
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
            ii=i*Sx+round(Sx/2);
            jj=j*Sx+round(Sx/2);
            for k=-1:1:1
                for l=-1:1:1
                    k=0;
                    l=0;
                    if ((ii+k>=imgrow ) || ( jj+l>=imgcol))
                        continue;
                    end
                rgbmap(ii+k,jj+l,1)=uint8(1);
%                 rgbmap(ii+k,jj+l,2)=uint8(0);
%                 rgbmap(ii+k,jj+l,3)=uint8(0);
                end
            end
            %------------------<Draw lines
            
        else
            indx1=(j+1)+(col*(i));
            out(1,indx1)=i; %x
            out(2,indx1)=j; %y
            out(3,indx1)=0; % theta randomly
        end %if (map(i,j)~=1) it's not an obstacle
        ii=i*Sx+Sx/2;
        jj=j*Sx+Sx/2;
        %             //for(int k=-1;k<1;k++)
        %                 //	for(int l=-1;l<1;l++)
        k=0;
        l=0;
        if ((ii+k>=imgrow ) || ( jj+l>=imgcol))
            continue;
        end
%         rgbmap(ii+k,jj+l,1)=uint8(255);
%         rgbmap(ii+k,jj+l,2)=uint8(0);
%         rgbmap(ii+k,jj+l,3)=uint8(0);
%         hold on;
%         imshow(rgbmap);
    end%}//end for col  number
end%//end first for row
% figure;
 imshow(rgbmap);
[I,J,S] = find(SpMatrix);
[m n]=size(SpMatrix);
DG = sparse(I,J,S,m,n);
% [dist,path,prred] = graphshortestpath(DG,3,2);%,'directed',false);
% DG = sparse(indx1Mat(1,:),indx1Mat(2,:),weight,row,col);
Points=out;
 save(oufilename,'DG','SpMatrix','Points');
% [dist,path,pred] = graphshortestpath(DG,1,6);
% h = view(biograph(SpMatrix,[],'ShowWeights','on'));
% ----------------------------
