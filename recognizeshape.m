function shapemask=recognizeshape(shape,rgb,B,L,m,n)

% 形状识别
shapemask=zeros(m,n);
% figure
% % imshow(label2rgb(L,@jet,[.5 .5 .5]));
% imshow(rgb);
% hold on;
for k = 1:length(B)
    boundary = B{k};
%     % 显示白色边界
%     plot(boundary(:,2),boundary(:,1),'w','LineWidth',2)
end
% hold on;
% 确定目标regionprops返回每个8联通区域的面积和中心点
stats = regionprops(L,'Area','Centroid');

for k = 1:length(B)
    boundary = B{k};
    delta_sq = diff(boundary).^2;
    % 求周长     
    perimeter = sum(sqrt(sum(delta_sq,2)));
    % 求面积     
    area = stats(k).Area;
    %圆形metric_round=1
    metric_round = 4*pi*area/perimeter^2;
    r_round=sqrt(area/pi);
    %三角形metric_triangle=1
    metric_triangle = 27*16*area^2/perimeter^4; 
    r_triangle=perimeter/(3^1.5);
    %正方形
    metric_square = 16*area/perimeter^2;
    r_square=sqrt(2)*perimeter/8;
    
    % 根据阈值匹配
    if metric_round > 0.85  && metric_round < 1.11
       centroid = stats(k).Centroid;
%        plot(centroid(1),centroid(2),'ko');
%        text(centroid(1)-2,centroid(2)-2, '圆形','Color','k','FontSize',14,'FontWeight','bold');
%        metric_round_string = sprintf('%2.2f',metric_round);
%        text(boundary(1,2)-10,boundary(1,1)-12, metric_round_string,'Color','k','FontSize',14,'FontWeight','bold');
       if shape==1 
           for i=1:m
               for j=1:n
                   if abs(j-centroid(1))^2+abs(i-centroid(2))^2<=r_round^2+2 
                       shapemask(i,j)=1;
                   end
               end
           end
       end
    end
    if metric_triangle >  0.85  && metric_triangle < 1.11
       centroid = stats(k).Centroid;
%        plot(centroid(1),centroid(2),'ko');
%        text(centroid(1)-2,centroid(2)-2, '三角形','Color','k','FontSize',14,'FontWeight','bold');
%        metric_triangle_string = sprintf('%2.2f',metric_triangle);
%        text(boundary(1,2)-10,boundary(1,1)-12, metric_triangle_string,'Color','k','FontSize',14,'FontWeight','bold');
       if shape==2 
           for i=1:m
               for j=1:n
                   if abs(j-centroid(1))^2+abs(i-centroid(2))^2<=r_triangle^2+2 
                       shapemask(i,j)=1;
                   end
               end
           end
       end
    end
    if metric_square > 0.85  && metric_square < 1.11
       centroid = stats(k).Centroid;
%        plot(centroid(1),centroid(2),'ko');
%        text(centroid(1)-2,centroid(2)-2, '方形','Color','k','FontSize',14,'FontWeight','bold');
%        metric_square_string = sprintf('%2.2f',metric_square);
%        text(boundary(1,2)-10,boundary(1,1)-12, metric_square_string,'Color','k','FontSize',14,'FontWeight','bold');
        if shape==3 
           for i=1:m
               for j=1:n
                   if abs(j-centroid(1))^2+abs(i-centroid(2))^2<=r_square^2+2 
                       shapemask(i,j)=1;
                   end
               end
           end
       end
    end
end
% title('图像形状识别')
end