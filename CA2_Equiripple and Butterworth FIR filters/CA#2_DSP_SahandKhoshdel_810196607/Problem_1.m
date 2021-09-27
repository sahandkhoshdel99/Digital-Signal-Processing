

% Part 0 : Reading the noisy sound and playing it 

[noisy_sound,Fs] = audioread('Noisysound.wav');
%sound(noisy_sound,Fs);

% Part 1 : Plotting the Frequency Spectrum :

noisy_sound_ft = fft(noisy_sound ,length(noisy_sound));
noisy_sound_fts = fftshift(abs(noisy_sound_ft));
len=length(noisy_sound);
Freq_range=Fs*(-len/2:len/2-1)/len;

figure
plot(Freq_range,noisy_sound_ft);
title('Fourier transform (Noisy Sound) ');
xlabel('Frequency (Hz)');
ylabel('Amplitude ');

figure
plot(Freq_range,noisy_sound_fts);
title('Shifted Fourier transform (Noisy Sound) ');
xlabel('Frequency (Hz)');
ylabel('Amplitude ');


% Part 2 : Designing Band-Stop Filter (Equi-ripple method)

figure
freqz(BS_ER);
title('Band-stop Filter (Equi-ripple)');
xlabel('Frequency');
ylabel('Amplitude');
filtered_sound = filter(BS_ER,1,noisy_sound);


% Part 3 : Playing the filtered sound

%sound(filtered_sound,Fs);
audiowrite('NoiseLess.wav',filtered_sound,Fs);

figure
plot(Freq_range,filtered_sound);
title('Band-Pass Filtered sound');
xlabel('Frequency (Hz)');
ylabel('Amplitude ')


% Part 4 : Designing Low-pass 

BS_filtered = audioread('NoiseLess.wav');
%Playying sound before low-pass 

%sound(BS_filtered,Fs);

%frequency response of LP_filter : 
figure
freqz(LP_ER);
title('Low-pass Filter (Equi-ripple)');
xlabel('Frequency');
ylabel('Amplitude');

LP_filtered = filter(LP_ER,1,BS_filtered);
%Playing sound after low-pass:
%sound(LP_filtered,Fs);
audiowrite('NoiseLess_LP.wav',LP_filtered,Fs);

% Comparing signal before and after applying LP filter (time domain)
figure
plot((0:len-1)/Fs,filtered_sound)
hold on
plot((0:len-1)/Fs,LP_filtered)
legend('Sound before Low-pass filter','Sound after Low-Pass filter');
title('Comparing signal before and after applying LP filter (time domain)');
xlabel('Time');
ylabel('Amplitude');


% Comparing fft-shifted signal before and after applying LP filter (freq domain)
fftshift_before_LP = abs(fftshift(fft(filtered_sound)));
fftshift_after_LP = abs(fftshift(fft(LP_filtered)));

figure
plot(Freq_range,fftshift_before_LP);
title('FFT-shifted of noiseless signal before LP');
ylabel('Amplitude');
xlabel('Frequency');

figure
plot(Freq_range,fftshift_after_LP);
title('FFT-shifted of noiseless signal after LP');
ylabel('Amplitude');
xlabel('Frequency');


% Part 4 : with IIR

%Playying sound before and after high-pass
%sound(LP_filtered,Fs);

%frequency response of HP_filter : 
figure
freqz(HP_BW);
title('High-pass Filter (Butter-worth)');
xlabel('Frequency');
ylabel('Amplitude');

HP_filtered = filter(HP_BW,1,BS_filtered);

%Playing sound after High-pass:
%sound(HP_filtered,Fs);
audiowrite('NoiseLess_HP.wav',HP_filtered,Fs);

% Comparing signal before and after applying HP filter (time domain)
figure
plot((0:len-1)/Fs,filtered_sound)
hold on
plot((0:len-1)/Fs,HP_filtered)
legend('Sound before High-pass filter','Sound after High-Pass filter');
title('Comparing signal before and after applying HP filter (time domain)');
xlabel('Time');
ylabel('Amplitude');

% Comparing fft-shifted signal before and after applying LP filter (freq domain)
fftshift_before_HP = abs(fftshift(fft(filtered_sound)));
fftshift_after_HP = abs(fftshift(fft(HP_filtered)));

figure
plot(Freq_range,fftshift_before_HP);
title('FFT-shifted of noiseless signal before HP');
ylabel('Amplitude');
xlabel('Frequency');

figure
plot(Freq_range,fftshift_after_HP);
title('FFT-shifted of noiseless signal after HP');
ylabel('Amplitude');
xlabel('Frequency');
