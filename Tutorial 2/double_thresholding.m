function [image] = double_thresholding(image,Tlow,Thigh)
    sz = size(image);
    for i = 1:sz(1)
        for j = 1:sz(2)
            if image(i,j) < Tlow
                image(i,j) = 255;
            elseif image(i,j) > Thigh
                image(i,j) = 255;
            else
                image(i,j) = 0;
            end
        end
    end
end

