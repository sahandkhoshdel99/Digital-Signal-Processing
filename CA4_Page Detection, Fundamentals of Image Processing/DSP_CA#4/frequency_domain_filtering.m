%%
% Part 1: Noise effect on Magnitude and Phase
clc
close all;

raw_face = imread('C:\Users\ASUS\Desktop\DSP_CA#4\data\att-database-of-faces\s24\3.pgm');
figure
imshow(raw_face);
title('Raw_face')

figure
mesh(raw_face);
title('Mesh face Output')

% Going to freq domain:
fourier_face = fftshift(fft2(raw_face));

ph_noise_snr_25 = awgn(angle(fourier_face), 0.25);
ph_noise_snr_50 = awgn(angle(fourier_face), 0.5);
ph_noise_snr_100 = awgn(angle(fourier_face), 1);

mg_noise_snr_25 = awgn(abs(fourier_face),0.25);
mg_noise_snr_50 = awgn(abs(fourier_face),0.5);
mg_noise_snr_100 = awgn(abs(fourier_face),1);

% Noisy phase and Correct Magnitude 
npcm_25  = abs(fourier_face).*exp(j*ph_noise_snr_25);
npcm_50  = abs(fourier_face).*exp(j*ph_noise_snr_50);
npcm_100 = abs(fourier_face).*exp(j*ph_noise_snr_100);

% Back to time domain
npcm_t_25 = ifft2(ifftshift(npcm_25));
npcm_t_50 = ifft2(ifftshift(npcm_50));
npcm_t_100 = ifft2(ifftshift(npcm_100));

% Noisy Magnitude and Correct Phase
nmcp_25 = mg_noise_snr_25.*exp(j*angle(fourier_face));
nmcp_50 = mg_noise_snr_50.*exp(j*angle(fourier_face));
nmcp_100 = mg_noise_snr_100.*exp(j*angle(fourier_face));


% Back to image(space) domain
nmcp_t_25 = ifft2(ifftshift(nmcp_25));
nmcp_t_50 = ifft2(ifftshift(nmcp_50));
nmcp_t_100 = ifft2(ifftshift(nmcp_100));


% Plotting output image:
figure
subplot(1,2,1), imshow(uint8(abs(nmcp_t_25)));
title('Noisy Magnitude, Correct Phase SNR=0.25');

subplot(1,2,2), imshow(uint8(abs(npcm_t_25)));
title('Noisy Phase, Correct Magnitude SNR=0.25');

figure
subplot(1,2,1), imshow(uint8(abs(nmcp_t_50)));
title('Noisy Magnitude, Correct Phase SNR=0.5');

subplot(1,2,2), imshow(uint8(abs(npcm_t_50)));
title('Noisy Phase, Correct Magnitude SNR=0.5');

figure
subplot(1,2,1), imshow(uint8(abs(nmcp_t_100)));
title('Noisy Magnitude, Correct Phase SNR=1');

subplot(1,2,2), imshow(uint8(abs(npcm_t_100)));
title('Noisy Phase, Correct Magnitude SNR=1');


%% 
% Part 2: Swapping face phases:

person_1 = imread('C:\Users\ASUS\Desktop\DSP_CA#4\data\att-database-of-faces\s20\8.pgm');
figure
subplot(1,2,1), imshow(person_1);
title('Person 1')

person_2 = imread('C:\Users\ASUS\Desktop\DSP_CA#4\data\att-database-of-faces\s4\2.pgm');
subplot(1,2,2), imshow(person_2);
title('Person 2')

% Going to freq domain
fourier_1 = fftshift(fft2(person_1));
fourier_2 = fftshift(fft2(person_2));

% Seperating Magnitude and Phase:
mg_person_1 = abs(fourier_1);
ph_person_1 = angle(fourier_1);

mg_person_2 = abs(fourier_2);
ph_person_2 = angle(fourier_2);

% Swapping Phase 
mg1_ph2 = mg_person_1.*exp(j*ph_person_2);
mg2_ph1 = mg_person_2.*exp(j*ph_person_1);

% Back to image(space) domain:
mg1_ph2_t = ifft2(ifftshift(mg1_ph2));
mg2_ph1_t = ifft2(ifftshift(mg2_ph1));

% Plotting output image:
figure
subplot(1,2,1), imshow(uint8(abs(mg1_ph2_t)));
title('Person 1 Magnitude + Person 2 Phase')

subplot(1,2,2), imshow(uint8(abs(mg2_ph1_t)));
title('Person 2 Magnitude + Person 1 Phase')









