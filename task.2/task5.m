img = imread('img.png');
img = imresize(img,[1024, 1024]);
img = rgb2gray(img);
img_noise_mean = imnoise(img,"gaussian",0,0.1);
img_noise_salt = imnoise(img,'salt & pepper',0.1);
img_noise_mean_ = my_Gauss_filter(img_noise_mean);
img_noise_salt_ = my_Gauss_filter(img_noise_salt);
img_noise_mean_b = bilateralFilter(img_noise_mean,3,25);
img_noise_salt_b = bilateralFilter(img_noise_salt,3,25);
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
title(sprintf('滤波后: %.3f', SNR));
subplot(3, 2, 4);
imshow(img_noise_salt_);
SNR = my_SNR(img,img_noise_salt_);
title(sprintf('滤波后: %.3f', SNR));
subplot(3, 2, 5);
imshow(img_noise_mean_b);
SNR = my_SNR(img,img_noise_mean_b);
title(sprintf('双边滤波后: %.3f', SNR));
subplot(3, 2, 6);
imshow(img_noise_salt_b);
SNR = my_SNR(img,img_noise_salt_b);
title(sprintf('双边滤波后: %.3f', SNR));


function output_img = my_Gauss_filter(noisy_image)
    [height, width, ~] = size(noisy_image);
    kernel_size = 9;
    kernel = fspecial('gaussian',[kernel_size,kernel_size]);
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

function output_img = bilateralFilter(input_img, sigma_d, sigma_r)
    input_img = double(input_img);
    [rows, cols] = size(input_img);
    window_size = 2 * ceil(3 * sigma_d) + 1;
    padding_size = floor(window_size / 2);
    padded_img = padarray(input_img, [padding_size, padding_size], 'symmetric');
    output_img = zeros(rows, cols);
    space_domain_kernel = w_g(window_size, sigma_d);
    for i = 1:rows
        for j = 1:cols
            
            neighborhood = padded_img(i:i+window_size-1, j:j+window_size-1);
           
            value_weights = w_p(neighborhood, sigma_r);
            
            weights = space_domain_kernel .* value_weights;
            

            weights = weights / sum(weights(:));
            

            output_img(i, j) = sum(sum(weights .* neighborhood));
        end
    end


    output_img = uint8(output_img);
end


function result = w_g(window, sigma_d)
    radius = (window - 1) / 2;
    [X, Y] = meshgrid(-radius:radius, -radius:radius);
    distance = X.^2 + Y.^2;
    result = exp(-distance / (2 * sigma_d^2));
    result = result / sum(result(:)); 
end


function result = w_p(window, sigma_r)
    [w_size, ~] = size(window);
    center = floor(w_size / 2) + 1;
    centered_window = window - window(center, center);
    result = exp(-(centered_window .^ 2) / (2 * sigma_r^2));
end
