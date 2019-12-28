function [image_out] = add_noise(image, noise_type, noise_parameters)
%ADD_NOISE Summary of this function goes here
%   Detailed explanation goes here
    if strcmp(noise_type,'salt_and_pepper')
        image_out = imnoise(image,'salt & pepper',noise_parameters);
    elseif strcmp(noise_type,'gaussian')
        image_out = imnoise(image,'gaussian',noise_parameters(1),noise_parameters(2));
    else
        disp('Invalid noise type');
    end
end

