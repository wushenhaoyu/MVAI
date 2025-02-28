import cv2
import numpy as np
import matplotlib.pyplot as plt

# 读取图像
bw = cv2.imread('stereo2012a.jpg')

# 调整图像大小
bw = cv2.resize(bw, (1024, 1024))

# 将图像转换为灰度图像
bw = cv2.cvtColor(bw, cv2.COLOR_BGR2GRAY)

# 显示图像
plt.imshow(bw, cmap='gray')
plt.axis('off')  # 关闭坐标轴
plt.title('Select 12 Points')
plt.show()

# 获取用户点击的12个点
def onclick(event):
    global ix, iy
    ix, iy = event.xdata, event.ydata
    print(f'x = {ix}, y = {iy}')
    plt.plot(ix, iy, 'ro', markersize=10, linewidth=2)
    plt.draw()

fig, ax = plt.subplots()
ax.imshow(bw, cmap='gray')
cid = fig.canvas.mpl_connect('button_press_event', onclick)

plt.title('Select 12 Points')
plt.show()

# 提示用户选择12个点
selected_points = []
while len(selected_points) < 12:
    plt.waitforbuttonpress()
    if ix is not None and iy is not None:
        selected_points.append([ix, iy])
        ix, iy = None, None

# 将选中的点保存到文件
selected_points = np.array(selected_points)
np.save('selected_points.npy', selected_points)
