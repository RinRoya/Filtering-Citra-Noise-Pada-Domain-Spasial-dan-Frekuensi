function [image_filter, filter_time, psnr_filter] = solveSpaFilter(im_gray, im_noise, m_filter, m_filter_my)
% Menghitung hasil filter

start_time = tic();
im_filter = uint8conv2(im_noise, m_filter);
fil_time = toc(start_time);

if nargin==4
    start_time = tic();
    im_filter = abs(uint8conv2(im_noise, m_filter)) + abs(uint8conv2(im_noise, m_filter_my));
    fil_time = toc(start_time);
end

psnr_val = psnr(im_gray, im_filter);

% Return
image_filter = im_filter;
filter_time = fil_time;
psnr_filter = psnr_val;


