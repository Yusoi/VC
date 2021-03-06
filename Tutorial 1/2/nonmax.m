function [ BW, dir2, h, l ] = nonmax (v_grad, h_grad )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %Calculate directions/orientations
  dir = atan2 (v_grad, h_grad);
  dir = dir*180/pi;
  height=size(v_grad,1);
  length=size(v_grad,2);
  
  %Adjustment for negative directions, making all directions positive
  for i=1:height
      for j=1:length
          if (dir(i,j)<0) 
              dir(i,j)=360+dir(i,j);
          end
      end
  end

  dir2=zeros(height, length);
  
  %Adjusting directions to nearest 0, 45, 90, or 135 degree
  for i = 1  : height
      for j = 1 : length
          if ((dir(i, j) >= 0 ) && (dir(i, j) < 22.5) || (dir(i, j) >= 157.5) && (dir(i, j) < 202.5) || (dir(i, j) >= 337.5) && (dir(i, j) <= 360))
              dir2(i, j) = 0;
          elseif ((dir(i, j) >= 22.5) && (dir(i, j) < 67.5) || (dir(i, j) >= 202.5) && (dir(i, j) < 247.5))
              dir2(i, j) = 45;
          elseif ((dir(i, j) >= 67.5 && dir(i, j) < 112.5) || (dir(i, j) >= 247.5 && dir(i, j) < 292.5))
              dir2(i, j) = 90;
          elseif ((dir(i, j) >= 112.5 && dir(i, j) < 157.5) || (dir(i, j) >= 292.5 && dir(i, j) < 337.5))
              dir2(i, j) = 135;
          end
      end
  end
  
  %Calculate mag
  mag = (h_grad.^2) + (v_grad.^2);
  mag2 = sqrt(mag);
  BW = zeros (height, length);
  
  %Non-Maximum Supression
  for i=2:height-1
      for j=2:length-1
          if (dir2(i,j)==0)
              BW(i,j) = (mag2(i,j) == max([mag2(i,j), mag2(i,j+1), mag2(i,j-1)]));
          elseif (dir2(i,j)==45)
              BW(i,j) = (mag2(i,j) == max([mag2(i,j), mag2(i+1,j-1), mag2(i-1,j+1)]));
          elseif (dir2(i,j)==90)
              BW(i,j) = (mag2(i,j) == max([mag2(i,j), mag2(i+1,j), mag2(i-1,j)]));
          elseif (dir2(i,j)==135)
              BW(i,j) = (mag2(i,j) == max([mag2(i,j), mag2(i+1,j+1), mag2(i-1,j-1)]));
          end
      end
  end
  
  BW = BW.*mag2;
  
  

end

