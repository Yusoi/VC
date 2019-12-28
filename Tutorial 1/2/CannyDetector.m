clear all;

image_input = input('What image do you want to use? "lena" "castle" "baboon" (Default "lena")\n','s');
if strcmp(image_input,'baboon')
    image = imread('../Images/baboon.png');
elseif strcmp(image_input,'castle')
    image = imread('../Images/castle.png');
else
    image = imread('../Images/lena.jpg');
end
image = rgb2gray(image);

main_CannyDetector(image);
