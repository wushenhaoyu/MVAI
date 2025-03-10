img = imread('img.png');
img = imresize(img,[1024, 1024]);
img = rgb2gray(img);
img_noise_mean = imnoise(img,"gaussian",0,100);
img_noise_salt = imnoise(img,'salt & pepper',0.1);
subplot(2, 2, 1);
imshow(img);
title('原始图像');
subplot(2, 2, 2);
imshow(img);
title('原始图像');
subplot(2, 2, 3);
imshow(img_noise_mean);
title('高斯噪声');
subplot(2, 2, 4);
imshow(img_noise_salt);
title('椒盐噪声');