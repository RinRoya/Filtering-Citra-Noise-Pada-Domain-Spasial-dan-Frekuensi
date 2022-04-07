function [matriks_filter, image_filter, filter_time, psnr_filter] = spaRoberts(im_gray, im_noise)
% Roberts Filter

m_filter = [-1 0;0 1];
m_filter_my = [0 -1;1 0];
[im_filter, fil_time, psnr_val] = solveSpaFilter(im_gray, im_noise, m_filter, m_filter_my);

% Return
matriks_filter = m_filter;
image_filter = im_filter;
filter_time = fil_time;
psnr_filter = psnr_val;

