clc
clear 
close all
%使用Sobel 算子提取边界
I=imread('room.bmp');
f=rgb2gray(I);%彩色图像转换为灰度图像
[gv,t1]=edge(f,'sobel','vertical');%对图像f提取垂直的边缘
figure
subplot(3,2,1)
imshow(gv)
title('sober算子垂直边缘')
[gb,t2]=edge(f,'sobel','horizontal');%对图像f提取水平的边缘
subplot(3,2,2)
imshow(gb)
title('sober算子水平边缘')
%使用prewitt 算子提取边界
[gv1,t11]=edge(f,'prewitt','vertical');%对图像f提取垂直的边缘
subplot(3,2,3)
imshow(gv1)
title('prewitt算子垂直边缘')
[gb1,t21]=edge(f,'prewitt','horizontal');%对图像f提取水平的边缘
subplot(3,2,4)
imshow(gb1)
title('prewitt算子水平边缘')
%使用roberts 算子提取边界
[gv1,t12]=edge(f,'roberts','vertical');%对图像f提取垂直的边缘
subplot(3,2,5)
imshow(gv1)
title('roberts算子垂直边缘')
[gb1,t22]=edge(f,'roberts','horizontal');%对图像f提取水平的边缘
subplot(3,2,6)
imshow(gb1)
title('roberts算子水平边缘')

w45=[-2 -1 0;-1 0 1;0 1 2];%指定模版使用imfilter计算45度方向的边缘
g45=imfilter(double(f),w45,'replicate');%在数组边界之外的输入数组值被假定为等于最近的数组边界值。
T=0.3*max(abs(g45(:)));  %设定阈值
g45=g45>=T;           %进行阈值处理
figure
imshow(g45);

%边缘跟踪
I=imread('1.bmp');
f=rgb2gray(I);
BW=edge(f,'sobel');
[B,L]=bwboundaries(BW,'noholes');
imshow(L);
title('边缘跟踪')