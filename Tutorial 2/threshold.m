function [image] = threshold(image,thr)
%THRESHOLD Summary of this function goes here
%   Detailed explanation goes here
    sz = size(image);
    for i = 1:sz(1)
        for j = 1:sz(2)
            if image(i,j) < thr
                image(i,j) = 255;
            else
                image(i,j) = 0;
            end
        end
    end
end

