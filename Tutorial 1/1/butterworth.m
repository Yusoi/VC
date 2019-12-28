function  res = butterworth(im,Wn,n)
% im - image
% Wn - cuttoff frequency
%  n - filter order

 hb = 1-butterhp(im,Wn,n); % cria um filtro butter
 af=fftshift(fft2(im));  % aplica se a transformação fourier 
 afhb=af.*hb;            % aplica-se o filtro
 afhbi = ifft2(afhb);    % inverso da transformação fourier
 res = ifftshow(afhbi);        % resultado
end