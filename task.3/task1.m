
bw = imread('img.jpg'); % 读取图片文件 'img.jpg'
bw = imresize(bw,[1024, 1024]); % 将图片大小调整为 1024x1024 像素
bw = rgb2gray(bw); % 将图片从RGB颜色空间转换为灰度空间

% Harris Corner detector 
sigma=2; % 高斯核的标准差
thresh=0.1; % 用于确定角点的阈值
sze=11; % Harris角点检测器的窗口大小
disp=0; % 显示参数（这里未使用）
k = 0.04; % Harris角点检测器中的常数

% Derivative masks
dy = [-1 0 1; -1 0 1; -1 0 1]; % 定义垂直方向的边缘检测核
dx = dy'; % dx 是 dy 的转置矩阵，用于水平方向的边缘检测

Ix = conv2(bw, dx, 'same'); % 计算图像在x方向的梯度
Iy = conv2(bw, dy, 'same'); % 计算图像在y方向的梯度

% Calculating the gradient of the image Ix and Iy
g = fspecial('gaussian',max(1,fix(6*sigma)), sigma); % 定义高斯核
Ix2 = conv2(Ix.^2, g, 'same'); % 平滑图像梯度的x方向平方
Iy2 = conv2(Iy.^2, g, 'same'); % 平滑图像梯度的y方向平方
Ixy = conv2(Ix.*Iy, g, 'same'); % 平滑图像梯度的xy方向乘积

% Compute the cornerness. 
R = (Ix2 .* Iy2 - Ixy.^2) - k * (Ix2 + Iy2).^2; % Harris角点度量公式

% Now we need to perform non-maximum suppression and threshold
R_thresh = R > thresh * max(R(:));  
cornerness = imregionalmax(R) & R_thresh; % 找到局部极大值点，并且满足阈值条件

[rws,cols] = find(cornerness); % Find row,colcoords.  clf ;
imshow(bw); % 显示原始灰度图像
hold on; % 保持图像，以便在上面绘制
p=[cols rws]; % 将列坐标和行坐标组合成一个点的坐标数组
plot(p(:,1),p(:,2),'or'); % 在角点位置绘制红色圆圈
title('Harris Corners'); % 设置图像标题为 'Harris角点'
