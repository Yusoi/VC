function [ image_out ] = gaussian_smoothing( image,filter_parameters )
%GAUSSIAN_SMOOTHING Summary of this function goes here
%   Detailed explanation goes here
    image_out = imgaussfilt(image,filter_parameters(2),'FilterSize',filter_parameters(1),'FilterDomain','spatial');
end

