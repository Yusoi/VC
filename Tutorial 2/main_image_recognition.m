function [] = main_image_recognition(image_input,image,noise_type,noise_parameters)

    noisy_image = add_noise(image,noise_type,noise_parameters);
    subplot(3,3,2);
    imshow(noisy_image);
    title('Noisy Image');
    
    %Noise Introduction
    if strcmp(noise_type,'salt_and_pepper')
        filtered_image = medfilt2(image);
        subplot(3,3,3);
        imshow(filtered_image);
        title('Filtered Image');
    else
        filtered_image = 0;
    end
    
    [~,snr_noisy_image] = psnr(noisy_image,image)
    
    %Image check and appropriation
    if strcmp(image_input,'2')
        %Histogram equalization
        %preprocessed_image = histeq(filtered_image);
        
        otsuT = uint8(255 * graythresh(filtered_image));
        preprocessed_image = threshold(filtered_image,otsuT);
        preprocessed_image = imfill(preprocessed_image, 'holes');
        
        %eroding image
        SE = strel('disk',10,4);
        preprocessed_image = imerode(preprocessed_image,SE);
        
        subplot(3,3,4);
        RI = imref2d(size(preprocessed_image));
        imshow(preprocessed_image,RI);
        title('Processed Image');
        
        subplot(3,3,5);
        [centers, radii, ~] = imfindcircles(preprocessed_image,281,'Sensitivity',1);
        numCircles = length(centers)
        imshow(preprocessed_image);
        viscircles(centers,radii,'EdgeColor','b');
        title('Segmented Image with Noise');   
        
        subplot(3,3,6);
        histogram(radii);
        title('Coin size histogram');
        
    elseif strcmp(image_input,'3')
        %Histogram equalization
        %preprocessed_image = histeq(filtered_image);
        
        %Default Image
        preprocessed_image = medfilt2(image,[20 20]);
        preprocessed_image = double_thresholding(preprocessed_image,165,220);
        preprocessed_image = bwareaopen(preprocessed_image,1000,4);
        
        %Closing image
        SE = strel('disk',10,4);
        preprocessed_image = imclose(preprocessed_image,SE);
        
        %Filling holes
        preprocessed_image = imfill(preprocessed_image, 'holes');
        
        subplot(3,3,4);
        RI = imref2d(size(preprocessed_image));
        imshow(preprocessed_image,RI);
        title('Preprocessed Original Image');
        
        subplot(3,3,5);
        [centers, radii, ~] = imfindcircles(preprocessed_image,[250,325],'ObjectPolarity','bright','Sensitivity',0.96);
        numCircles = length(centers)
        imshow(preprocessed_image);
        viscircles(centers,radii,'EdgeColor','b');
        title('Segmented Image without Noise');
        
        subplot(3,3,6);
        histogram(radii);
        title('Coin Size Histogram Original Image');
        
        %Filtered Image
        preprocessed_image = medfilt2(filtered_image,[20 20]);
        preprocessed_image = double_thresholding(preprocessed_image,165,220);
        preprocessed_image = bwareaopen(preprocessed_image,1000,4);
        
        %Closing image
        SE = strel('disk',10,4);
        preprocessed_image = imclose(preprocessed_image,SE);
        
        %Filling holes
        preprocessed_image = imfill(preprocessed_image, 'holes');
        
        subplot(3,3,7);
        RI = imref2d(size(preprocessed_image));
        imshow(preprocessed_image,RI);
        title('Preprocessed Image');
        
        subplot(3,3,8);
        [centers, radii, metric] = imfindcircles(preprocessed_image,[250,325],'ObjectPolarity','bright','Sensitivity',0.96);
        numCircles = length(centers)
        imshow(preprocessed_image);
        viscircles(centers,radii,'EdgeColor','b');
        title('Segmented Image with Noise');
        
        subplot(3,3,9);
        histogram(radii);
        title('Coin size Histogram Filtered Image');
        
    else
        
        %Histogram equalization
        preprocessed_image = histeq(filtered_image);
        [pixelCount, ~] = imhist(filtered_image);
        subplot(3,3,4);
        bar(pixelCount);
        title('Histogram Pixel Distribution');
        
        otsuT = uint8(255 * graythresh(preprocessed_image));
        preprocessed_image = threshold(preprocessed_image,otsuT);
        %preprocessed_image = imfill(preprocessed_image, 'holes');
        
        subplot(3,3,5);
        title('Histeq Image');
        RI = imref2d(size(preprocessed_image));
        imshow(preprocessed_image,RI);
    end
end

