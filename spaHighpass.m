function [matriks_filter, image_filter, filter_time, psnr_filter] = spaHighpass(im_gray, im_noise)
% High-pass Filter

m_filter = [0 -1 0;-1 5 -1;0 -1 0];
[im_filter, fil_time, psnr_val] = solveSpaFilter(im_gray, im_noise, m_filter);

% Return
matriks_filter = m_filter;
image_filter = im_filter;
filter_time = fil_time;
psnr_filter = psnr_val;

