function ShowPath(G,path)

if nargin < 1   % demo mode
    disp('No input was set!');
    return;
end
map=G.mapshow;
drate=G.drate;
figure;
imshow(map);
imagesc(map);
hold on;
for i=1:size(path,2)
    color=rand(1,3);
    if (path(i).dist==-1)
        continue;
    end
    Pathtemp=path(i).points;
    l=size(Pathtemp,2);
    x=[];
    y=[];
    for ll=1:l
        x=[x G.points(2,Pathtemp(ll))*drate+(drate/2)];
        y=[y G.points(1,Pathtemp(ll))*drate+(drate/2)];
    end
    hold on;
    plot(x,y,'b-');
    hold on;
    coltemp=[];
    plot(x,y,'color',color(1,:),'LineWidth',3); 
    plot(x,y,'color',color(1,:),'LineWidth',3);
    hold on;
    plot(x(1),y(1), '-mo',...
        'LineWidth',2,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',color(1,:),...%[.49 1 .63],...
        'MarkerSize',11);
    hold on;
    plot(x(end),y(end),'--ys',...
    'LineWidth',2,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor',color(1,:),...
        'MarkerSize',11);
end
