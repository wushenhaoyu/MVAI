point_3d = [
    0, 0, 0;    % 点 1
    0, 14, 7;   % 点 2
    0, 14, 14;  % 点 3
    0, 7, 14;   % 点 4
    7, 7, 0;    % 点 5
    14, 7, 0;   % 点 6
    14, 14, 0;  % 点 7
    7, 14, 0;   % 点 8
    7, 0, 7;    % 点 9
    7, 0, 14;   % 点 10
    14, 0, 14;  % 点 11
    14, 0, 7    % 点 12
];
x = point_3d(:, 1);
y = point_3d(:, 2);
z = point_3d(:, 3);
figure;
plot3(x, y, z, 'o', 'MarkerFaceColor', 'r');
grid on; 
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Points Visualization');
