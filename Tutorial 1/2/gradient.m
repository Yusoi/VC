function [ gradient,v_grad,h_grad,threshOut,mag,dir ] = gradient( image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [gradient,threshOut,v_grad,h_grad] = edge(image,'Sobel',[],'both');
    
    [mag,dir] = imgradient(gradient);
    
end

