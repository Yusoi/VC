function [ ] = main_CannyDetector( image )
%MAIN_CANNYDETECTOR Summary of this function goes here
%   Detailed explanation goes here

    filter_size = 5;
    sigma = 3;
    
    image = gaussian_smoothing(image,[sigma,filter_size]);
    
    [ grad,v_grad,h_grad,threshOut,mag,dir ] = gradient(image);
    
    [ BW, dir2 ] = nonmax(v_grad, h_grad);
    
    [ BW2, T_High, T_Low, Harsh, Soft ] = double_threshold(BW);
    
    [ edge_final, T_res ] = hysteresis_thresholding(BW2, T_High, T_Low);
    
    figure(1);
    subplot(3,4,1),imshow(image);title('Smoothed Image');
    subplot(3,4,2),imshow(grad);title('Gradient');
    subplot(3,4,3),imshow(v_grad);title('Vertical Gradient');
    subplot(3,4,4),imshow(h_grad);title('Horizontal Gradient');
    subplot(3,4,5),imshow(mag);title('Magnitude');
    subplot(3,4,6),imshow(dir);title('Direction');
    subplot(3,4,7),imshow(dir2);title('Nonmax Directions');
    subplot(3,4,8),imshow(mat2gray(log(BW+1)));title('Nonmax');
    subplot(3,4,9),imshow(Harsh);title('High Threshold');
    subplot(3,4,10),imshow(Soft);title('Low Threshold');
    subplot(3,4,11),imshow(edge_final);title('Hysteresis Final');
    
    imwrite(image, 'images/lena_smoothed.png');
    imwrite(grad, 'images/lena_edge_canny_filtersize_variance.png');
    imwrite(v_grad, 'images/lena_sobel_vgrad.png');
    imwrite(h_grad, 'images/lena_sobel_hgrad.png');
    imwrite(mag, 'images/lena_sobel_mag.png');
    imwrite(dir, 'images/lena_sobel_dir.png');
    imwrite(dir2, 'images/lena_nonmax_directions.png');
    imwrite(BW, 'images/lena_edge_canny_nonmax_filtersize_variance.png');
    imwrite(Harsh, 'images/high_threshold.png');
    imwrite(Soft, 'images/low_threshold.png');
    imwrite(edge_final, 'images/lena_edge_canny_hysteresis_filtersize_variance.png');
    
end

