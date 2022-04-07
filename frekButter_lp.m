function [image_filter, filter_time, psnr_filter, filt_spek, hasil_spek, U_frek, V_frek] = frekButter_lp(im_gray, im_noise)
start_time = tic();

n = 2;
d0 = 20;

% Ukuran Gambar
[X, Y] = size(im_noise);
%Transformasi Fourier
trans_Fourier = fft2(double(im_noise));

%Filter Butterworth High-Pass
u = 0:(X-1);
v = 0:(Y-1);
idx = find(u > X/2);
u(idx) = u(idx) - X;
idy = find(v > Y/2);
v(idy) = v(idy) - Y;

%Koordinat Vektor 
[V, U] = meshgrid(v, u);

%Jarak Euclid
D = sqrt(U.^2 + V.^2);

%Masking Filter
H = 1./(1 + (D./d0).^(2*n));

%Konvolusi
G = H.*trans_Fourier;
blpf = real(ifft2(double(G)));

fil_time = toc(start_time);
image_filter = uint8(blpf);
filter_time = fil_time;
psnr_filter = psnr(im_gray, uint8(blpf));
filt_spek = H;
hasil_spek = G;
U_frek=U;
V_frek=V;
end