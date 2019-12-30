function [filtered_image] = median_spacial_filter(image)
    filtered_image = medfilt2(image);
end

