function colormask=recognizecolor(color,B,L,img1,hsv,rgb)
% 图像颜色识别
% % 确定圆形目标regionprops返回每个8联通区域的面积和中心点
stats = regionprops(L,'Area','Centroid');

for k = 1:length(B)
    centroid = stats(k).Centroid;
end
% 将图像从 RGB 转换为 HSV 颜色空间
hsv_img = rgb2hsv(img1);

% 定义蓝色的 HSV 范围
blue_hue_low = 0.4;
blue_hue_high = 0.5;
blue_saturation_low = 0.7;
blue_saturation_high = 0.8;
blue_value_low = 0.7;
blue_value_high = 0.9;

% 创建一个逻辑掩码，标记所有符合蓝色范围的像素red
blue_mask = (hsv_img(:,:,1) >= blue_hue_low) & (hsv_img(:,:,1) <= blue_hue_high) & ...
           (hsv_img(:,:,2) >= blue_saturation_low) & (hsv_img(:,:,2) <= blue_saturation_high) & ...
           (hsv_img(:,:,3) >= blue_value_low) & (hsv_img(:,:,3) <= blue_value_high);

% 显示原始图像和掩码图像
% figure;
% subplot(231)
% imshow(rgb);
% title('原图');
% subplot(232)
% imshow(img1);
% title('色调变化的图像');
% subplot(233)
% imshow(blue_mask);
% title('blue Mask');

% 定义绿色的 HSV 范围
green_hue_low = 0.65;
green_hue_high = 0.8;
green_saturation_low = 0.4;
green_saturation_high = 0.6;
green_value_low = 0.7;
green_value_high = 0.9;

% 创建一个逻辑掩码，标记所有符合绿色范围的像素
green_mask = (hsv_img(:,:,1) >= green_hue_low) & (hsv_img(:,:,1) <= green_hue_high) & ...
           (hsv_img(:,:,2) >= green_saturation_low) & (hsv_img(:,:,2) <= green_saturation_high) & ...
           (hsv_img(:,:,3) >= green_value_low) & (hsv_img(:,:,3) <= green_value_high);
% 
% % 显示原始图像和掩码图像
% subplot(234)
% imshow(green_mask);
% title('green Mask');

% 定义黄色的 HSV 范围
yellow_hue_low = 0.7;
yellow_hue_high = 0.9;
yellow_saturation_low = 0.6;
yellow_saturation_high = 0.8;
yellow_value_low = 0.9;
yellow_value_high = 1;

% 创建一个逻辑掩码，标记所有符合黄色范围的像素
yellow_mask = (hsv_img(:,:,1) >= yellow_hue_low) & (hsv_img(:,:,1) <= yellow_hue_high) & ...
           (hsv_img(:,:,2) >= yellow_saturation_low) & (hsv_img(:,:,2) <= yellow_saturation_high) & ...
           (hsv_img(:,:,3) >= yellow_value_low) & (hsv_img(:,:,3) <= yellow_value_high);

% % 显示原始图像和掩码图像
% subplot(235)
% imshow(yellow_mask);
% title('yellow Mask');

% 定义红色的 HSV 范围

red_hue_low = 0;
red_hue_high = 0.4;
red_saturation_low = 0.5;
red_saturation_high = 1;
red_value_low = 0;
red_value_high = 1;

% 创建一个逻辑掩码，标记所有符合红色范围的像素
red_mask = (hsv_img(:,:,1) >= red_hue_low) & (hsv_img(:,:,1) <= red_hue_high) & ...
           (hsv_img(:,:,2) >= red_saturation_low) & (hsv_img(:,:,2) <= red_saturation_high) & ...
           (hsv_img(:,:,3) >= red_value_low) & (hsv_img(:,:,3) <= red_value_high);

% % 显示原始图像和掩码图像
% subplot(236)
% imshow(red_mask);
% title('red Mask');

%% MASK膨胀
% figure;
% subplot(231)
% imshow(rgb);
% title('原图');
% subplot(232)
% imshow(img1);
% title('色调变化的图像');

%设置膨胀结构元素
SE = strel('square',15);                
%膨胀
blue_mask_se = imdilate(blue_mask,SE); 
green_mask_se = imdilate(green_mask,SE); 
yellow_mask_se = imdilate(yellow_mask,SE); 
red_mask_se = imdilate(red_mask,SE);                
% subplot(233)
% imshow(blue_mask_se);title('blue mask');
% subplot(234)
% imshow(green_mask_se);title('green mask');
% subplot(235)
% imshow(yellow_mask_se);title('yellow mask');
% subplot(236)
% imshow(red_mask_se);title('red mask');

%% 遮盖

blue_img_hsv(:,:,1)=hsv(:,:,1);
blue_img_hsv(:,:,2)=hsv(:,:,2);
blue_img_hsv(:,:,3)=blue_mask_se;
blue_img=hsv2rgb(blue_img_hsv);

green_img_hsv(:,:,1)=hsv(:,:,1);
green_img_hsv(:,:,2)=hsv(:,:,2);
green_img_hsv(:,:,3)=green_mask_se;
green_img=hsv2rgb(green_img_hsv);

yellow_img_hsv(:,:,1)=hsv(:,:,1);
yellow_img_hsv(:,:,2)=hsv(:,:,2);
yellow_img_hsv(:,:,3)=yellow_mask_se;
yellow_img=hsv2rgb(yellow_img_hsv);

red_img_hsv(:,:,1)=hsv(:,:,1);
red_img_hsv(:,:,2)=hsv(:,:,2);
red_img_hsv(:,:,3)=red_mask_se;
red_img=hsv2rgb(red_img_hsv);

% figure
% subplot(231)
% imshow(rgb);title('原图')
% subplot(232)
% imshow(img1);title('色彩反转')
% subplot(233)
% imshow(blue_img);title('蓝色')
% subplot(234)
% imshow(green_img);title('绿色')
% subplot(235)
% imshow(yellow_img);title('黄色')
% subplot(236)
% imshow(red_img);title('红色')

if color==1
    colormask=blue_img_hsv;
elseif color==2
    colormask=green_img_hsv;
elseif color==3
    colormask=yellow_img_hsv;
elseif color==4
    colormask=red_img_hsv;
end

end