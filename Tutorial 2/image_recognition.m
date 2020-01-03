image_input = input('What image do you want to use? "1" "2" "3" (Default "1")\n','s');
if strcmp(image_input,'2')
    image = imread('Images/coins2.jpg');
    output = 'coins2_';
elseif strcmp(image_input,'3')
    image = imread('Images/coins3.jpg');
    output = 'coins3_';
else
    image = imread('Images/coins.jpg');
    output = 'coins1_';
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

figure;
subplot(3,3,1);
imshow(image);
title('B/W Image');

main_image_recognition(image_input,image,noise_type,noise_parameters);
