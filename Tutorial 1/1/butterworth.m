function  res = butterworth(im,Wn,n)
% im - image
% Wn - cuttoff frequency
%  n - filter order

 hb = 1-butterhp(im,Wn,n); % cria um filtro butter
 af=fftshift(fft2(im));  % aplica se a transforma��o fourier 
 afhb=af.*hb;            % aplica-se o filtro
 afhbi = ifft2(afhb);    % inverso da transforma��o fourier
 res = ifftshow(afhbi);        % resultado
end