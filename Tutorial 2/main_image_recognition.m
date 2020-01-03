function [preprocessed_image, snr_noisy_image, seg_with_noise, seg_without_noise, hist, coin_size_num_table] = main_image_recognition(image_input,image,noise_type,noise_parameters)
%MAIN_IMAGE_RECOGNITION Summary of this function goes here
%   Detailed explanation goes here
    noisy_image = add_noise(image,noise_type,noise_parameters);
    subplot(4,3,2);
    title('Noisy Image');
    imshow(noisy_image);
    
    %Noise Introduction
    if strcmp(noise_type,'salt_and_pepper')
        filtered_image = median_spacial_filter(noisy_image);
        subplot(4,3,3);
        title('Filtered Image');
        imshow(filtered_image);
    else
        filtered_image = 0;
    end
    
    %Image check and appropriation
    if strcmp(image_input,'2')
        %Histogram equalization
        %preprocessed_image = histeq(filtered_image);
        [pixelCount, ~] = imhist(filtered_image);
        subplot(4,3,4);
        bar(pixelCount);
        title('Histogram');
        
        preprocessed_image = medfilt2(filtered_image,[20 20]);
        preprocessed_image = threshold(preprocessed_image,190);
        preprocessed_image = imfill(preprocessed_image, 'holes');
        
        %eroding image
        SE = strel('disk',20,4);
        preprocessed_image = imerode(preprocessed_image,SE);
        
        subplot(4,3,5);
        RI = imref2d(size(preprocessed_image));
        imshow(preprocessed_image,RI);
        title('Processed Image');
        
        subplot(4,3,6);
        [centers, radii, metric] = imfindcircles(preprocessed_image,[300 350],'ObjectPolarity','bright','Method','TwoStage','Sensitivity',0.95);
        numCircles = length(centers)
        viscircles(centers,radii,'EdgeColor','b');
        imshow(preprocessed_image);
        
        
    elseif strcmp(image_input,'3')
        %Histogram equalization
        %preprocessed_image = histeq(filtered_image);
        [pixelCount, ~] = imhist(filtered_image);
        subplot(4,3,4);
        title('Histogram');
        bar(pixelCount);
        
        preprocessed_image = medfilt2(filtered_image,[20 20]);
        preprocessed_image = double_thresholding(preprocessed_image,165,220);
        preprocessed_image = bwareaopen(preprocessed_image,1000,4);
        preprocessed_image = imfill(preprocessed_image, 'holes');
        
        subplot(4,3,5);
        title('Histeq Image');
        imshow(preprocessed_image);
        
        subplot(4,3,6);
        [centers, radii, metric] = imfindcircles(preprocessed_image,[400,500]);
        imshow(preprocessed_image);
        viscircles(centers,radii,'EdgeColor','b');
        
        
    else
        
        %Histogram equalization
        preprocessed_image = histeq(filtered_image);
        [pixelCount, ~] = imhist(filtered_image);
        subplot(4,3,4);
        title('Histogram');
        imshow(pixelCount);
        %bar(pixelCount);
        
        %preprocessed_image = imcomplement(filtered_image);
        otsuT = graythresh(preprocessed_image)
        preprocessed_image = threshold(preprocessed_image,otsuT);
        %
        %preprocessed_image = imfill(preprocessed_image, 'holes');
        
        subplot(4,3,5);
        title('Histeq Image');
        RI = imref2d(size(preprocessed_image));
        imshow(preprocessed_image,RI);
    end
    
    snr_noisy_image = 0;
    seg_with_noise = 0;
    seg_without_noise = 0;
    hist = 0;
    coin_size_num_table = 0;
end

