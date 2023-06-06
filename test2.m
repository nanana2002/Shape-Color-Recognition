clear
clc
close all
%调入并显示彩色图像
%拆分这幅图像，并分别显示其R，G，B分量；
rgb_image=imread('lena.bmp');   %读取图像
rgb_image(:,:,2)=0;            %图像的绿色分量置零
rgb_image(:,:,3)=0;            %图像的蓝色分量置零
figure
subplot(1,3,1)
imshow(rgb_image)           %显示图像的红色分量
title('红色分量')
rgb_image=imread('lena.bmp');   %读取图像
rgb_image(:,:,1)=0;            %图像的红色分量置零
rgb_image(:,:,3)=0;            %图像的蓝色分量置零
subplot(1,3,2)
imshow(rgb_image)           %显示图像的绿色分量
title('绿色分量')
rgb_image=imread('lena.bmp');   %读取图像
rgb_image(:,:,2)=0;            %图像的绿色分量置零
rgb_image(:,:,1)=0;            %图像的红色分量置零
subplot(1,3,3)
imshow(rgb_image)           %显示图像的蓝色分量
title('蓝色分量')

%实现rgb图像转化为HSV彩色空间的图像,色调、饱和度、明度
figure
rgb=imread('1.bmp');
hsv=rgb2hsv(rgb);
[m,n,l]=size(rgb);
a=ones(m,n);
hsv1(:,:,1)=a-hsv(:,:,1);
hsv1(:,:,2)=hsv(:,:,2);
hsv1(:,:,3)=hsv(:,:,3);
img1=hsv2rgb(hsv1);
subplot(2,2,1); imshow(rgb);  title('原图像');
subplot(2,2,2); imshow(img1);  title('色调变换后的图像');
hsv2(:,:,1)=hsv(:,:,1);    
hsv2(:,:,2)=a-hsv(:,:,2);
hsv2(:,:,3)=hsv(:,:,3);
img2=hsv2rgb(hsv2);
subplot(2,2,3); imshow(img2);  title('饱和度变换后的图像');
hsv3(:,:,1)=hsv(:,:,1);
hsv3(:,:,2)=hsv(:,:,2);
hsv3(:,:,3)=a-hsv(:,:,3);
img3=hsv2rgb(hsv3);
subplot(2,2,4); imshow(img3);  title('明度变换后的图像');

%修改其他参数，显示不同的色调、饱和度效果。
figure
rgb=imread('1.bmp');
hsv=rgb2hsv(rgb);
[m,n,l]=size(rgb);
hsv1(:,:,1)=0.5*hsv(:,:,1);
hsv1(:,:,2)=hsv(:,:,2);
hsv1(:,:,3)=hsv(:,:,3);
img1=hsv2rgb(hsv1);
subplot(2,2,1); imshow(rgb);  title('原图像');
subplot(2,2,2); imshow(img1);  title('色调变换后的图像');
hsv2(:,:,1)=hsv(:,:,1);    
hsv2(:,:,2)=0.5*hsv(:,:,2);
hsv2(:,:,3)=hsv(:,:,3);
img2=hsv2rgb(hsv2);
subplot(2,2,3); imshow(img2);  title('饱和度变换后的图像');
hsv3(:,:,1)=hsv(:,:,1);
hsv3(:,:,2)=hsv(:,:,2);
hsv3(:,:,3)=0.5*hsv(:,:,3);
img3=hsv2rgb(hsv3);
subplot(2,2,4); imshow(img3);  title('明度变换后的图像');