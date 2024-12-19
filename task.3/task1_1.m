    bw = imread('img.jpg'); %读图片
    bw = imresize(bw,[1024, 1024]); %调大小
    bw = rgb2gray(bw); %RGB to 灰度
    i = corner(bw,200);
    imshow(bw);
    hold on;
    plot(i(:,1),i(:,2),'or');
    title('\bf Harris Corners')