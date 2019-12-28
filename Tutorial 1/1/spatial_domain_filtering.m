function [ image_out ] = spatial_domain_filtering(image,filter_type,filter_parameters)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if strcmp(filter_type,'average')
        f = fspecial('average',filter_parameters);
        image_out = imfilter(image,f,'replicate');
    elseif strcmp(filter_type,'gaussian')
        image_out = imgaussfilt(image,filter_parameters(2),'FilterSize',filter_parameters(1),'FilterDomain','spatial');
    elseif strcmp(filter_type,'median')
        image_out = medfilt2(image,[filter_parameters(1) filter_parameters(1)]);
    end
    
    imshow(image_out);
end

