img = imread('img.png');
img = imresize(img,[1024, 1024]);
img = rgb2gray(img);
[img_,img_x,img_y] = my_Sobel_filter(img);
img_builtin = edge(img, 'Sobel');  

subplot(3, 2, 1);
imshow(img);
title('原图像');

subplot(3, 2, 2);
imshow(img);
title('原图像');

subplot(3, 2, 3);
imshow(img_x);
title('Sobel_x');

subplot(3, 2, 4);
imshow(img_y);
title('Sobel_y');

subplot(3, 2, 5);
imshow(img_);
title('合并后');

subplot(3, 2, 6);
imshow(img_builtin);
title('Sobel(内置)');



function [xy,x,y] = my_Sobel_filter(image)
    image = double(image);
    Kernel_x = [-1 0 1; -2 0 2; -1 0 1]; 
    Kernel_y = [-1 -2 -1; 0 0 0; 1 2 1]; 
    [width,height] = size(image);
    x = zeros(width,height);
    y = zeros(width,height);
    for i = 2:width-1
        for j = 2:height-1
            x(i, j) = sum(sum(Kernel_x .* (image(i-1:i+1, j-1:j+1))));
            y(i, j) = sum(sum(Kernel_y .* (image(i-1:i+1, j-1:j+1))));
        end
    end
    xy = sqrt(x.^2 + y.^2);
    x = uint8(x);
    y = uint8(y);
    xy = uint8(xy);
end




