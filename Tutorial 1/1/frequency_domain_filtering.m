function [ image_out ] = frequency_domain_filtering(image,filter_type,filter_parameters)
%FREQUENCY_DOMAIN_FILTERING Summary of this function goes here
%   Detailed explanation goes here
    if strcmp(filter_type,'gaussian')
        image_out = imgaussfilt(image,filter_parameters(2),'FilterSize',filter_parameters(1),'FilterDomain','frequency');
    elseif strcmp(filter_type,'butterworth')
        image_out = butterworth(image,filter_parameters(1),filter_parameters(2));
    end
end

