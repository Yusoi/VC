clear all;

image_input = input('What image do you want to use? "lena" "castle" "baboon" (Default "lena")\n','s');
if strcmp(image_input,'baboon')
    image = imread('../Images/baboon.png');
    output = 'baboon_';
elseif strcmp(image_input,'castle')
    image = imread('../Images/castle.png');
    output = 'castle_';
else
    image = imread('../Images/lena.jpg');
    output = 'lena_';
end
image = rgb2gray(image);

noise_type_input = input('What noise type do you want to use? "salt_and_pepper" "gaussian" (Default "salt_and_pepper")\n','s');
if strcmp(noise_type_input,'gaussian')
    noise_type = 'gaussian';
    mean_input = input('Insert the mean:\n');
    variance_input = input('Insert the variance:\n');
    noise_parameters = [mean_input,variance_input];
    noise_output = strcat(output,noise_type,'_',num2str(mean_input),'_',num2str(variance_input));
else
    noise_type = 'salt_and_pepper';
    density_input = input('Insert the density:\n');
    noise_parameters = density_input;
    noise_output = strcat(output,noise_type,'_',num2str(density_input));
end


filtering_domain_input = input('What filtering domain do you want to use? "spatial" "frequency" (Default "spatial")\n','s');
if strcmp(filtering_domain_input,'frequency')
    filtering_domain = 'frequency';
    smoothing_type_input = input('What frequency domain smoothing type do you want to use? "butterworth" "gaussian" (Default "butterworth")\n','s');
    if strcmp(smoothing_type_input,'gaussian')
        smoothing_type = 'gaussian';
        filter_width_input = input('Insert filter width:\n');
        sigma_input = input('Insert standard deviation:\n');
        filter_parameters = [filter_width_input,sigma_input];
        filter_output = strcat(output,filtering_domain,'_',smoothing_type,'_',num2str(filter_width_input),'_',num2str(sigma_input));
    else
        smoothing_type = 'butterworth';
        filter_cutoff_input = input('Insert cutoff frequency:\n');
        filter_order_input = input('Insert filter order:\n');
        filter_parameters = [filter_cutoff_input,filter_order_input];
        filter_output = strcat(output,filtering_domain,'_',smoothing_type,'_',num2str(filter_cutoff_input),'_',num2str(filter_order_input));
    end
else
    filtering_domain = 'spatial';
    smoothing_type_input = input('What spatial domain smoothing type do you want to use? "average" "gaussian" "median" (Default "average")\n','s');
    if strcmp(smoothing_type_input,'gaussian')
        smoothing_type = 'gaussian';
        kernel_size_input = input('Insert kernel size:\n');
        sigma_input = input('Insert standard deviation:\n');
        filter_parameters = [kernel_size_input, sigma_input];
        filter_output = strcat(output,filtering_domain,'_',smoothing_type,'_',num2str(kernel_size_input),'_',num2str(sigma_input));
    elseif strcmp(smoothing_type_input,'median')
        smoothing_type = 'median';
        kernel_size_input = input('Insert kernel size:\n');
        filter_parameters = kernel_size_input;
        filter_output = strcat(output,filtering_domain,'_',smoothing_type,'_',num2str(kernel_size_input));
    else
        smoothing_type = 'average';
        kernel_size_input = input('Insert kernel size:\n');
        filter_parameters = kernel_size_input;
        filter_output = strcat(output,filtering_domain,'_',smoothing_type,'_',num2str(kernel_size_input));
    end
end

[noisy_image,smoothed_image] = main_smoothfilters(image,noise_type,noise_parameters,filtering_domain,smoothing_type,filter_parameters);

[original_f,noisy_f,smoothed_f] = fourier_transform(image,noisy_image,smoothed_image);

figure(1);
subplot(2,3,1),imshow(image);title('Original Image');
subplot(2,3,2),imshow(noisy_image);title('Noisy Image');
subplot(2,3,3),imshow(smoothed_image);title('Smoothed Image');
subplot(2,3,4),imshow(real(original_f));title('Fourier Original Image');
subplot(2,3,5),imshow(real(noisy_f));title('Fourier Noisy Image');
subplot(2,3,6),imshow(real(smoothed_f));title('Fourier Smoothed Image');

imwrite(noisy_image,strcat(noise_output,'.png'));
imwrite(smoothed_image,strcat(filter_output,'.png'));
imwrite(original_f,strcat(output,'fourier.png'));
imwrite(noisy_f,strcat(noise_output,'_fourier.png'));
imwrite(smoothed_f,strcat(filter_output,'_fourier.png'));
