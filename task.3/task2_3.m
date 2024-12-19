im = imread('stereo2012a.jpg');
im = imresize(im, [1024, 1024]); 
load('2d_points.mat');  
load('3d_points.mat');  
C = calibrate(im, point_3d, selected_points);
world_point = [17; 8; 0; 1];  
image_point_homogeneous = C * world_point;  
u = image_point_homogeneous(1) / image_point_homogeneous(3);
v = image_point_homogeneous(2) / image_point_homogeneous(3);
figure; imshow(im); hold on;
plot(u, v, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
title('Projected 3D Point onto Image');
hold off;
function C = calibrate(im, XYZ, uv)
    N = size(XYZ, 1);  
    A = [];
    for i = 1:N
        X = XYZ(i, 1);
        Y = XYZ(i, 2);
        Z = XYZ(i, 3);
        u = uv(i, 1);
        v = uv(i, 2);
        A = [A;
             X, Y, Z, 1, 0, 0, 0, 0, -u*X, -u*Y, -u*Z, -u;
             0, 0, 0, 0, X, Y, Z, 1, -v*X, -v*Y, -v*Z, -v];
    end
    [~, ~, V] = svd(A);
    q = V(:, end);
    C = reshape(q, 4, 3)';
end
