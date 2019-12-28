function [original_f,noisy_f,smoothed_f] = fourier_transform(image,noisy_image,smoothed_image)

    % fourier transform
    original_f = fftshift(fft2(image));
    original_f = abs(original_f); % Get the magnitude
    original_f = log(original_f+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
    original_f = mat2gray(original_f);
    
    noisy_f = fftshift(fft2(noisy_image));
    noisy_f = abs(noisy_f);
    noisy_f = log(noisy_f+1);
    noisy_f = mat2gray(noisy_f);
    
    smoothed_f = fftshift(fft2(smoothed_image));
    smoothed_f = abs(smoothed_f); 
    smoothed_f = log(smoothed_f+1); 
    smoothed_f = mat2gray(smoothed_f);
end

