function flag=Checkobs(map,i,j,cubsize,Sx)
imgcol=size(map,2);
imgrow=size(map,1);
i=i*Sx+round(Sx/2);
j=j*Sx+round(Sx/2);
cnt=0;
for k=-1*cubsize:cubsize
    for l=-1*cubsize:cubsize
        if ((i+k>=imgrow ) || ( j+l>=imgcol))
            cnt=cnt+1;
            continue;            
        end
        if ~map(i+k,j+l)
            flag=0;
            return;
        end
    end%end for k cubesize check if it's obstacle
end
if (cnt==Sx*Sx)
    flag=0;
    return;
end
flag=1;
return;
end