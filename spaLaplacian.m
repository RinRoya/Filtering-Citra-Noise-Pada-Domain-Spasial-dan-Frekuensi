function [matriks_filter, image_filter, filter_time, psnr_filter] = spaLaplacian(im_gray, im_noise)
% Laplacian Filter

m_filter = fspecial('laplacian');
[im_filter, fil_time, psnr_val] = solveSpaFilter(im_gray, im_noise, m_filter);

% Return
matriks_filter = m_filter;
image_filter = im_filter;
filter_time = fil_time;
psnr_filter = psnr_val;

