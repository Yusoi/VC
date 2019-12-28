function [ BW, T_High, T_Low, Harsh, Soft ] = double_threshold ( BW )
    T_Low = 0.075;
    T_High = 0.175;

    T_Low = T_Low * max(max(BW));
    T_High = T_High * max(max(BW));
    
    [h,l] = size(BW);
    
    Harsh = zeros(size(BW));
    Soft = zeros(size(BW));
    
    for i = 1  : h
        for j = 1 : l
            if (BW(i, j) > T_High)
              Harsh(i, j) = 1;
              
            elseif (BW(i, j) > T_Low)
              Soft(i, j) = 1;
            end
        end
    end
    
end