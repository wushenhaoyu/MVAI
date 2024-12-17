img = imread('img.png');
img = imresize(img,[1024, 1024]);
img = rgb2gray(img);
img_noise_mean = imnoise(img,"gaussian",0,0.1);
img_noise_salt = imnoise(img,'salt & pepper',0.1);
img_noise_mean_ = my_Gauss_filter(img_noise_mean);
img_noise_salt_ = my_Gauss_filter(img_noise_salt);
subplot(2, 2, 1);
imshow(img_noise_mean);
SNR = my_SNR(img,img_noise_mean);
title(sprintf('信噪比: %.3f', SNR));
subplot(2, 2, 2);
imshow(img_noise_salt);
SNR = my_SNR(img,img_noise_salt);
title(sprintf('信噪比: %.3f', SNR));
subplot(2, 2, 3);
imshow(img_noise_mean_);
SNR = my_SNR(img,img_noise_mean_);
title(sprintf('信噪比: %.3f', SNR));
subplot(2, 2, 4);
imshow(img_noise_salt_);
SNR = my_SNR(img,img_noise_salt_);
title(sprintf('信噪比: %.3f', SNR));


function output_img = my_Gauss_filter(noisy_image)
    [height, width, ~] = size(noisy_image);
    kernel_size = 9;
    kernel = fspecial('gaussian',[kernel_size,kernel_size],10);
    padding = 4;
    stride = 1;
    output_img = zeros(height, width);
    for oh = 1:height
        for ow = 1:width
            sum_val = 0;
            for kh = 1:kernel_size
                for kw = 1:kernel_size 
                    ih = (oh - 1) * stride - padding + kh;
                    iw = (ow - 1) * stride - padding + kw;
                    if ih >= 1 && ih <= height && iw >= 1 && iw <= width
                        sum_val = sum_val + noisy_image(ih, iw) * kernel(kh, kw);
                    end
                end
            end
            output_img(oh, ow) = sum_val;
        end
    end
    output_img = uint8(output_img);
end

function result = my_SNR(original_image,input_image)
    result = 20 * log(norm(double(original_image), 'fro') / norm(double(original_image - input_image), 'fro'));
end