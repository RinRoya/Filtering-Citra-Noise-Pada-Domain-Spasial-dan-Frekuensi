function [matriks_filter, image_filter, filter_time, psnr_filter] = spaLowpass(im_gray, im_noise)
% Low-pass Filter

m_filter = ones(3)./9;
[im_filter, fil_time, psnr_val] = solveSpaFilter(im_gray, im_noise, m_filter);

% Return
matriks_filter = m_filter;
image_filter = im_filter;
filter_time = fil_time;
psnr_filter = psnr_val;

