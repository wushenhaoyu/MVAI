img = imread('img.png');
img = imresize(img,[1024, 1024]);
img = rgb2gray(img);
img_noise_mean = imnoise(img,"gaussian",0,0.1);
img_noise_salt = imnoise(img,'salt & pepper',0.1);
img_noise_mean_ = my_Median_filter(img_noise_mean);
img_noise_salt_ = my_Median_filter(img_noise_salt);
img_noise_mean_builtin = medfilt2(img_noise_mean, [3 3]);  
img_noise_salt_builtin = medfilt2(img_noise_salt, [3 3]);  

subplot(3, 2, 1);
imshow(img_noise_mean);
SNR = my_SNR(img,img_noise_mean);
title(sprintf('高斯噪声: %.3f', SNR));

subplot(3, 2, 2);
imshow(img_noise_salt);
SNR = my_SNR(img,img_noise_salt);
title(sprintf('椒盐噪声: %.3f', SNR));

subplot(3, 2, 3);
imshow(img_noise_mean_);
SNR = my_SNR(img,img_noise_mean_);
title(sprintf('自定义滤波后 (高斯): %.3f', SNR));

subplot(3, 2, 4);
imshow(img_noise_salt_);
SNR = my_SNR(img,img_noise_salt_);
title(sprintf('自定义滤波后 (椒盐): %.3f', SNR));

subplot(3, 2, 5);
imshow(img_noise_mean_builtin);
SNR = my_SNR(img,img_noise_mean_builtin);
title(sprintf('内置滤波后 (高斯): %.3f', SNR));

subplot(3, 2, 6);
imshow(img_noise_salt_builtin);
SNR = my_SNR(img,img_noise_salt_builtin);
title(sprintf('内置滤波后 (椒盐): %.3f', SNR));



function output_img = my_Median_filter(noisy_image)
    [height, width, ~] = size(noisy_image);
    kernel_size = 3;  
    padding = 1;      
    stride = 1;
    output_img = zeros(height, width); 
    for oh = 1:height
        for ow = 1:width
            window = [];
            for kh = 1:kernel_size
                for kw = 1:kernel_size
                    ih = (oh - 1) + kh - padding;
                    iw = (ow - 1) + kw - padding;
                    if ih >= 1 && ih <= height && iw >= 1 && iw <= width
                        window = [window, noisy_image(ih, iw)];
                    end
                end
            end
            output_img(oh, ow) = median(window);
        end
    end
    output_img = uint8(output_img);
end


function result = my_SNR(original_image,input_image)
    result = 20 * log(norm(double(original_image), 'fro') / norm(double(original_image - input_image), 'fro'));
end