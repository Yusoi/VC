function [preprocessed_image, snr_noisy_image, seg_with_noise, seg_without_noise, hist, coin_size_num_table] = main_image_recognition(image_input,image,noise_type,noise_parameters)
%MAIN_IMAGE_RECOGNITION Summary of this function goes here
%   Detailed explanation goes here
    noisy_image = add_noise(image,noise_type,noise_parameters);
    subplot(2,3,2);
    title('Noisy Image');
    imshow(noisy_image);
    
    if strcmp(noise_type,'salt_and_pepper')
        filtered_image = median_spacial_filter(noisy_image);
        subplot(2,3,3);
        title('Filtered Image');
        imshow(filtered_image);
    else
        filtered_image = 0;
    end
    
    if strcmp(image_input,'2')
        
    elseif strcmp(image_input,'3')
        %Histogram equalization
        %preprocessed_image = histeq(filtered_image);
        [pixelCount, ~] = imhist(filtered_image);
        subplot(2,3,4);
        title('Histogram');
        bar(pixelCount);
        
        preprocessed_image = medfilt2(filtered_image,[20 20]);
        preprocessed_image = double_thresholding(preprocessed_image,160,220);
        preprocessed_image = bwareaopen(preprocessed_image,1000,4);
        
        subplot(2,3,5);
        title('Histeq Image');
        imshow(preprocessed_image);
        ylim('auto');
        
        subplot(2,3,6);
        [centers, radii, metric] = imfindcircles(preprocessed_image,[400,500]);
        imshow(preprocessed_image);
        viscircles(centers,radii,'EdgeColor','b');
        
        
    else
        
    end
    
    snr_noisy_image = 0;
    seg_with_noise = 0;
    seg_without_noise = 0;
    hist = 0;
    coin_size_num_table = 0;
end

