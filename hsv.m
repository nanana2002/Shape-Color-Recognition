clc
clear
close all
%% 实现rgb图像转化为HSV彩色空间的图像,色调、饱和度、明度
rgb=imread('3.jpg');
hsv1=rgb2hsv(rgb);
[m,n,l]=size(rgb);
a=ones(m,n);
hsv1(:,:,1)=a-hsv1(:,:,1);
hsv1(:,:,2)=hsv1(:,:,2);
hsv1(:,:,3)=hsv1(:,:,3);
img1=hsv2rgb(hsv1);

figure
subplot(331)
imshow(img1);  title('色调变换后的图像');

x=23;
y=30;
% 获取该点的HSV值
hsva = hsv1(x,y,1);
hsvb = hsv1(x,y,2);
hsvc = hsv1(x,y,3);