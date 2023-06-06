function recognize(color,shape)
%% 实现rgb图像转化为HSV彩色空间的图像,色调、饱和度、明度
rgb=imread('3.jpg');
hsv=rgb2hsv(rgb);
[m,n,l]=size(rgb);
a=ones(m,n);
hsv1(:,:,1)=a-hsv(:,:,1);
hsv1(:,:,2)=hsv(:,:,2);
hsv1(:,:,3)=hsv(:,:,3);
img1=hsv2rgb(hsv1);
% figure
% subplot(331)
% imshow(img1);  title('色调变换后的图像');
%%  转化为灰度图像
I = rgb2gray(img1);
% subplot(332)
% imshow(I);  title('灰度图像');
%% 二值化
% 设置阈值
threshold = graythresh(I);
% 转化为二值图像
bw = im2bw(I,threshold);
% subplot(333)
% imshow(bw);title('二值图像');
%% 中值滤波
med_img = medfilt2(bw);
% subplot(334)
% imshow(med_img);title('中值滤波');
%% 膨胀？？？？？
SE = strel('square',2);                %设置膨胀结构元素
BW = imdilate(med_img,SE);                 %膨胀
% subplot(335)
% imshow(BW);title('膨胀');
%% 识别轮廓
[m,n] = size(BW);
%色彩反转
for i = 1:m
    for j = 1:n
        BW(i,j) = ~BW(i,j);
    end
end
%轮廓追踪bwboundaries返回B边界的位置和L边界
[B,L] = bwboundaries(BW,'noholes');
%% 形状识别1圆形2三角形3正方形
shapemask(:,:,3)=recognizeshape(shape,rgb,B,L,m,n);
shapemask(:,:,1)=hsv(:,:,1);
shapemask(:,:,2)=hsv(:,:,2);
rgbshapemask=hsv2rgb(shapemask);
% figure
% imshow(rgbshapemask);
%% 色彩识别1蓝色2绿色3黄色4红色
colormask=recognizecolor(color,B,L,img1,hsv,rgb);
rgbcolormask=hsv2rgb(colormask);
% figure
% imshow(rgbcolormask);
%% 色彩与形状识别
mask(:,:,1)=hsv(:,:,1);
mask(:,:,2)=hsv(:,:,2);
for i=1:m
    for j=1:n
        mask(i,j,3)=shapemask(i,j,3)&&colormask(i,j,3);
    end
end
rgbmask=hsv2rgb(mask);
figure
imshow(rgbmask);
end