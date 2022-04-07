function [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekSobel(im_gray, im_noise)
start_time = tic();


h = fspecial('sobel');
PQ = paddedsize(size(im_noise));

% Ukuran Gambar
[X, Y] = size(im_noise);
%Transformasi Fourier
trans_Fourier = fft2(double(im_noise), PQ(1), PQ(2));

%Filter Sobel di Frekuensi
u = 0:(X-1);
v = 0:(Y-1);
idx = find(u > X/2);
u(idx) = u(idx) - X;
idy = find(v > Y/2);
v(idy) = v(idy) - Y;

%Koordinat Vektor 
[V, U] = meshgrid(v, u);

%Masking Filter
H = fft2(double(h), PQ(1), PQ(2));

%Konvolusi
G = H.*trans_Fourier;
ffi = ifft2(G);
ffi = ffi(2:size(im_noise,1)+1, 2:size(im_noise,2)+1);
res = imresize(H,0.5);

fil_time = toc(start_time);
image_filter = uint8(ffi);
filter_time = fil_time;
psnr_filter = psnr(im_gray, uint8(ffi));
filt_spek = real(res);
hasil_spek = G;
U_frek=U;
V_frek=V;
end