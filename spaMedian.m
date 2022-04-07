function [matriks_filter, image_filter, filter_time, psnr_filter] = spaMedian(im_gray, im_noise)
% Median Filter

start_time = tic();
im_filter = medfilt2(im_noise,[3,3]);
fil_time = toc(start_time);

psnr_val = psnr(im_gray, im_filter);

% Return
matriks_filter = zeros(3);
image_filter = im_filter;
filter_time = fil_time;
psnr_filter = psnr_val;