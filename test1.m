clc
clear 
close all
% 图像读取与显示
%Image=imread('1.bmp');
Image=imread('2.jpg');
figure
subplot(231)
imshow(Image);
title('原始图像');
%彩色图像转换为多灰度图像
Y=rgb2gray(Image);
subplot(232)
imshow(Y);
title('灰度图像');
%多灰度图像转换为二值图像
%Image_BW=im2bw(Y,0.86);
Image_BW=im2bw(Y,0.90);
subplot(233)
imshow(Image_BW);
title("二值图像")
%画出直方图

subplot(234)
imhist(Y);
title('直方图')
%二值图像取反
Reverse_Image_BW=~Image_BW;
subplot(235)
imshow(Reverse_Image_BW);
title('二值化图像取反');
%计数
[Label,Number]=bwlabel(Reverse_Image_BW,8);
Number

