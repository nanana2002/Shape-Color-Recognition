clc
clear 
close all

f=imread('1.bmp');
I=rgb2gray(f);
level = graythresh(I);                 %得到合适的阈值
bw = im2bw(I,level);                   %二值化
SE = strel('square',5);                %设置膨胀结构元素
BW1 = imdilate(bw,SE);                 %膨胀
SE1 = strel('arbitrary',eye(7));       %设置腐蚀结构元素
BW2 = imerode(bw,SE1);                 %腐蚀

BW3 = bwmorph(bw, 'open',1);              %开运算
BW4 = bwmorph(bw, 'close',1);             %闭运算

SE = strel('square',3);                %设置膨胀结构元素
BW3 = imopen(bw, SE);
BW4 = imclose(bw, SE);%%%我不能理解

figure
subplot(3,2,1)
imshow(I);
title('原图')
subplot(3,2,2)
imshow(bw);
title('二值化')
subplot(3,2,3)
imshow(BW1);
title('膨胀')
subplot(3,2,4)
imshow(BW2);
title('腐蚀')
subplot(3,2,5)
imshow(BW3);
title('开运算')
subplot(3,2,6)
imshow(BW4);
title('闭运算')
