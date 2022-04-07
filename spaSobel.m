function [matriks_filter, image_filter, filter_time, psnr_filter] = spaSobel(im_gray, im_noise)
% Sobel Filter

m_filter = fspecial('sobel');
m_filter_my = transpose(m_filter);
[im_filter, fil_time, psnr_val] = solveSpaFilter(im_gray, im_noise, m_filter, m_filter_my);

% Return
matriks_filter = m_filter;
image_filter = im_filter;
filter_time = fil_time;
psnr_filter = psnr_val;

