%% IDEAL LOW-PASS
function ilpf = ideal_lp(im, d0)
%im = Gambar Abu-Abu
%d0 = Frekuensi Batas

% Ukuran Gambar
[X, Y] = size(im);
%Transformasi Fourier
trans_Fourier = fft2(double(im));

%Filter Ideal Low-Pass
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
H = double(D <= d0);

%Konvolusi
G = H.*trans_Fourier;
ilpf = real(ifft2(double(G)));

%Menampilkan Hasil
figure('Name', 'Ideal Low-Pass Filter'),
subplot(2, 3, 1),
imshow(fftshift(log(1+abs(trans_Fourier))),[ ]),
title('Spektrum Asli')

subplot(2, 3, 2),
imshow(fftshift(log(1+abs(H))),[ ]),
title('ILPF')

subplot(2, 3, 3),
imshow(fftshift(log(1+abs(G))),[ ]),
title('Spektrum Hasil')

subplot(2, 3, 4),
imshow(im, [ ]),
title('Citra Asli')

subplot(2, 3, 5),
plot3(U,V,H),
title('ILPF Graph')

subplot(2, 3, 6),
imshow(ilpf, [ ]),
title('Citra Hasil'),
sgtitle('Ideal Low-Pass Filter')
end