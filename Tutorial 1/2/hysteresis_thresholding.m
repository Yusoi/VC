function [ edge_final, T_res, T_High, T_Low ] = hysteresis_thresholding ( BW, T_High, T_Low )
%   Detailed explanation goes here
    [h, l] = size(BW);
    
    T_res = zeros (h, l);
    for i = 1  : h
        for j = 1 : l
            if (BW(i, j) < T_Low)
                T_res(i, j) = 0;
            elseif (BW(i, j) > T_High)
                T_res(i, j) = 1;
            %Using 8-connected components
            elseif ( BW(i+1,j)>T_High || BW(i-1,j)>T_High || BW(i,j+1)>T_High || BW(i,j-1)>T_High || BW(i-1, j-1)>T_High || BW(i-1, j+1)>T_High || BW(i+1, j+1)>T_High || BW(i+1, j-1)>T_High)
                T_res(i,j) = 1;
            end
        end
    end
    edge_final = uint8(T_res.*255);
end