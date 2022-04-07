%% IDEAL HIGH-PASS
function ihpf = ideal_hp(im, d0)
%im = Gambar Abu-Abu
%d0 = Frekuensi Batas

% Ukuran Gambar
[X, Y] = size(im);
%Transformasi Fourier
trans_Fourier = fft2(double(im));

%Filter Ideal High-Pass
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
H = double(D > d0);

%Konvolusi
G = H.*trans_Fourier;
ihpf = real(ifft2(double(G)));

%Menampilkan Hasil
figure('Name', 'Ideal High-Pass Filter'),
subplot(2, 3, 1),
imshow(fftshift(log(1+abs(trans_Fourier))),[ ]),
title('Spektrum Asli')

subplot(2, 3, 2),
imshow(fftshift(log(1+abs(H))),[ ]),
title('IHPF')

subplot(2, 3, 3),
imshow(fftshift(log(1+abs(G))),[ ]),
title('Spektrum Hasil')

subplot(2, 3, 4),
imshow(im, [ ]),
title('Citra Asli')

subplot(2, 3, 5),
plot3(U,V,H),
title('IHPF Graph')

subplot(2, 3, 6),
imshow(ihpf, [ ]),
title('Citra Hasil'),
sgtitle('Ideal High-Pass Filter')
end