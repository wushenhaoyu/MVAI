bw = imread('stereo2012a.jpg'); 
bw = imresize(bw, [1024, 1024]); 
bw = rgb2gray(bw); 
imshow(bw);
hold on;
[x, y] = ginput(12);
plot(x, y, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
selected_points = [x, y];
save('selected_points.mat', 'selected_points');


