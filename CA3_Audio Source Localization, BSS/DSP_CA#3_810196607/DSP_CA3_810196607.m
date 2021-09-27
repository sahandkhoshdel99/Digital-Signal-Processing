
clc;
clear;
close all;

%reading receiver #7,#8 signals:
[c7,Fs1] = audioread('c7Mic3Intro.wav');
[c8,Fs2] = audioread('c8Mic3Intro.wav');


%%
% Question 1(intro):

%Plotting Time-Frequency Spectogram:
figure
subplot(2,1,1), spectrogram(c7,length(c7), 0, Fs1, Fs1, 'yaxis');
colormap winter;
title('Channel_7 Spectrogram');

subplot(2,1,2), spectrogram(c8,length(c8), 0, Fs2, Fs2, 'yaxis');
colormap winter;
title('Channel_8 Spectrogram');


%%
%Question 2:

figure
 
freqz(lowpass1);
freqz(bandpass1);
freqz(bandpass2);
freqz(highpass1);

sch1_c7 = filter(lowpass1,c7);
sch2_c7 = filter(bandpass1,c7);
sch3_c7 = filter(bandpass2,c7);
sch4_c7 = filter(highpass1,c7);

figure
 subplot(4,1,1), plot(sch1_c7,'c'), title('C7 - First Subchannel')
 subplot(4,1,2), plot(sch2_c7,'c'), title('C7 - Second Subchannel')
 subplot(4,1,3), plot(sch3_c7,'c'), title('C7 - Third Subchannel')
 subplot(4,1,4), plot(sch4_c7,'c'), title('C7 - Last Subchannel')

sch1_c8 = filter(lowpass1,c8);
sch2_c8 = filter(bandpass1,c8);
sch3_c8 = filter(bandpass2,c8);
sch4_c8 = filter(highpass1,c8);

figure
 subplot(4,1,1), plot(sch1_c8,'c'), title('C8 - First Subchannel')
 subplot(4,1,2), plot(sch2_c8,'c'), title('C8 - Second Subchannel')
 subplot(4,1,3), plot(sch3_c8,'c'), title('C8 - Third Subchannel')
 subplot(4,1,4), plot(sch4_c8,'c'), title('C8 - Last Subchannel')
 
%%
% Question 3:


 dec_data_i(:,1) = decimate(sch1_c7,4);
 dec_data_i(:,2) = decimate(sch2_c7,4);
 dec_data_i(:,3) = decimate(sch3_c7,4);
 dec_data_i(:,4) = decimate(sch4_c7,4);
 dec_data_i(:,5) = decimate(sch1_c8,4);
 dec_data_i(:,6) = decimate(sch2_c8,4);
 dec_data_i(:,7) = decimate(sch3_c8,4);
 dec_data_i(:,8) = decimate(sch4_c8,4);
 
 
 chunked_channels = zeros(256,140,8);
 for  data_part= 1:8
     for chunk= 1:140
         last = 256*chunk;
         first = 256*chunk-255;
         chunked_channels(:,chunk,data_part) = dec_data_i(first:last,data_part);
     end
 end
 
 %%
 %Question 4:
 
  sub_ch_corr = zeros(140,4);
 for sch = 1:4
     for chunk = 1:140
         [~,sub_ch_corr(chunk,sch)] = max(abs(xcorr(chunked_channels(:,chunk,sch),chunked_channels(:,chunk,sch+4))));
     end
 end
 
 lagindex_1 = sub_ch_corr(:,1);
 lagindex_2 = sub_ch_corr(:,2);
 lagindex_3 = sub_ch_corr(:,3);
 lagindex_4 = sub_ch_corr(:,4);

 %%
%Question 5:

xlim1 = [230:1:270];
xlim2 = [200:1:320];
xlim3 = [220:1:260];
xlim4 = [130:1:400];

figure

subplot(4,1,1), histogram(lagindex_1);
subplot(4,1,2), histogram(lagindex_2);
subplot(4,1,3), histogram(lagindex_3);
subplot(4,1,4), histogram(lagindex_4);

figure

subplot(4,1,1), h1 = histfit(lagindex_1);
mean_1 = fitdist(lagindex_1, 'normal').mean;
title("Lag_index_1 for Subchannel 1");
grid on 

[bin_values_1,~] = histcounts(lagindex_1, xlim1);
total_area_1 = area_cal(bin_values_1);
std_dev_1 = deviation(total_area_1, bin_values_1, mean_1,xlim1(1));


subplot(4,1,2), h2 = histfit(lagindex_2);
mean_2 = fitdist(lagindex_2, 'normal').mean;
title("Lag_index_2 for Subchannel 2");
grid on

[bin_values_2,~] = histcounts(lagindex_2, xlim2);
total_area_2 = area_cal(bin_values_2);
std_dev_2 = deviation(total_area_2, bin_values_2, mean_2,xlim2(1));




subplot(4,1,3), h3 = histfit(lagindex_3);
mean_3 = fitdist(lagindex_1, 'normal').mean;
title("Lag_index_3 for Subchannel 3");
grid on

[bin_values_3,~] = histcounts(lagindex_3, xlim3);
total_area_3 = area_cal(bin_values_3);
std_dev_3 = deviation(total_area_3, bin_values_3, mean_3,xlim3(1));




subplot(4,1,4) , h4 = histfit(lagindex_4);
mean_4 = fitdist(lagindex_1, 'normal').mean;
title("Lag_index_4 for Subchannel 4");
grid on

[bin_values_4,~] = histcounts(lagindex_4, xlim4);
total_area_4 = area_cal(bin_values_4);
std_dev_4 = deviation(total_area_4, bin_values_4, mean_4,xlim4(1));


%%
% Qusetion 6: repeating Q1-4 for the main signal:
% Question 1 (main):

%reading receiver #7,#8 signals:
[c7_m,Fs1_m] = audioread('c7m19.wav');
[c8_m,Fs2_m] = audioread('c8m19.wav');

%Plotting Time-Frequency Spectogram:
figure

subplot(2,1,1), spectrogram(c7_m,length(c7_m), 0, Fs1_m, Fs1_m, 'yaxis');
colormap autumn;
title('Channel_7 main Spectrogram');

subplot(2,1,2), spectrogram(c8_m,length(c8_m), 0, Fs2_m, Fs2_m, 'yaxis');
colormap autumn;
title('Channel_8 main Spectrogram');


%%
% Question 2(main):

sch1_c7_m = filter(lowpass1,c7_m);
sch2_c7_m = filter(bandpass1,c7_m);
sch3_c7_m = filter(bandpass2,c7_m);
sch4_c7_m = filter(highpass1,c7_m);

figure
 subplot(4,1,1), plot(sch1_c7_m,'c'), title('C7_main - First Subchannel')
 subplot(4,1,2), plot(sch2_c7_m,'c'), title('C7_main - Second Subchannel')
 subplot(4,1,3), plot(sch3_c7_m,'c'), title('C7_main - Third Subchannel')
 subplot(4,1,4), plot(sch4_c7_m,'c'), title('C7_main - Last Subchannel')
 
 
sch1_c8_m = filter(lowpass1,c8_m);
sch2_c8_m = filter(bandpass1,c8_m);
sch3_c8_m = filter(bandpass2,c8_m);
sch4_c8_m = filter(highpass1,c8_m);

figure
 subplot(4,1,1), plot(sch1_c8_m,'c'), title('C8_main - First Subchannel')
 subplot(4,1,2), plot(sch2_c8_m,'c'), title('C8_main - Second Subchannel')
 subplot(4,1,3), plot(sch3_c8_m,'c'), title('C8_main - Third Subchannel')
 subplot(4,1,4), plot(sch4_c8_m,'c'), title('C8_main - Last Subchannel')
 
%%
% Question 3(main):

 
 dec_data(:,1) = decimate(sch1_c7_m,4);
 dec_data(:,2) = decimate(sch2_c7_m,4);
 dec_data(:,3) = decimate(sch3_c7_m,4);
 dec_data(:,4) = decimate(sch4_c7_m,4);
 dec_data(:,5) = decimate(sch1_c8_m,4);
 dec_data(:,6) = decimate(sch2_c8_m,4);
 dec_data(:,7) = decimate(sch3_c8_m,4);
 dec_data(:,8) = decimate(sch4_c8_m,4);
  
 chunked_channels_m = zeros(256,2812,8);
 for  data_part_m= 1:8
     for chunk_m= 1:2812
         last_m = 256*chunk_m;
         first_m = 256*chunk_m-255;
         chunked_channels_m(:,chunk_m,data_part_m) = dec_data(first_m:last_m,data_part_m);
     end
 end
 
%%
% Question 4(main):
 
  sub_ch_corr_m = zeros(2812,4);
 for sch_m = 1:4
     for chunk_m = 1:2812
         [~,sub_ch_corr_m(chunk_m,sch_m)] = max(abs(xcorr(chunked_channels_m(:,chunk_m,sch_m),chunked_channels_m(:,chunk_m,sch_m+4))));
     end
 end
 
 lagindex_1_m = sub_ch_corr_m(:,1);
 lagindex_2_m = sub_ch_corr_m(:,2);
 lagindex_3_m = sub_ch_corr_m(:,3);
 lagindex_4_m = sub_ch_corr_m(:,4);
 
 
%% 
% Question 7:
% Calculating the coefficient for each cell needs the std_dev
% So we use the exact code for std calculation for the main signal:
 

xlim1_m = [230:1:280];
xlim2_m = [170:1:390];
xlim3_m = [230:1:300];
xlim4_m = [220:1:280];



figure

subplot(4,1,1), histogram(lagindex_1_m,xlim1_m);
mean_1_m = 256;
title("Lag_index_1 Main for Subchannel 1");
grid on 

[bin_values_1_m,~] = histcounts(lagindex_1_m, xlim1_m);
total_area_1_m = area_cal(bin_values_1_m);
std_dev_1_m = deviation(total_area_1_m, bin_values_1_m, mean_1_m,xlim1_m(1));




subplot(4,1,2), histogram(lagindex_2_m,xlim2_m);
mean_2_m = 256;
title("Lag_index_2 Main for Subchannel 2");
grid on 

[bin_values_2_m,~] = histcounts(lagindex_2_m, xlim2_m);
total_area_2_m = area_cal(bin_values_2_m);
std_dev_2_m = deviation(total_area_2_m, bin_values_2_m, mean_2_m,xlim2_m(1));





subplot(4,1,3), histogram(lagindex_3_m,xlim3_m);
mean_3_m = 256;
title("Lag_index_3 Main for Subchannel 3");
grid on 

[bin_values_3_m,~] = histcounts(lagindex_3_m, xlim3_m);
total_area_3_m = area_cal(bin_values_3_m);
std_dev_3_m = deviation(total_area_3_m, bin_values_3_m, mean_3_m,xlim3_m(1));




subplot(4,1,4), histogram(lagindex_4_m,xlim4_m);
mean_4_m = 256;
title("Lag_index_4 Main for Subchannel 4");
grid on 

[bin_values_4_m,~] = histcounts(lagindex_4_m, xlim4_m);
total_area_4_m = area_cal(bin_values_4_m);
std_dev_4_m = deviation(total_area_4_m, bin_values_4_m, mean_4_m,xlim4_m(1));



% Main part of Q7:
% Calculating coefficients adn plotting coefficient histogram before filtering:


W_sch_1 = coefficient_cal(lagindex_1_m, mean_1_m, .5);
W_sch_2 = coefficient_cal(lagindex_2_m, mean_2_m, std_dev_2_m);
W_sch_3 = coefficient_cal(lagindex_3_m, mean_3_m, std_dev_3_m);
W_sch_4 = coefficient_cal(lagindex_4_m, mean_4_m, std_dev_4_m);

W_sch = [W_sch_1;W_sch_2;W_sch_3;W_sch_4];

figure
subplot(4,1,1), histfit(W_sch_1(:));
subplot(4,1,2), histfit(W_sch_2(:));
subplot(4,1,3), histfit(W_sch_3(:));
subplot(4,1,4), histfit(W_sch_4(:));

%%
% Question 8:

 weight_chunks=zeros(256,2812,8);
 for i=1:4
     for j=1:2812
     weight_chunks(:,j,i)=chunked_channels_m(:,j,i).* W_sch(2812*(i-1)+j);
     weight_chunks(:,j,i+4) =  weight_chunks(:,j,i) ;
     end
 end
 
 interp_weight_chunk = zeros(720004,8);
 
  for j=1:8
    for i=1:2812
     interp_weight_chunk(256*(i-1)+1:256*i,j)= weight_chunks(:,i,j);
    end
  end
  
  
  
  for i=1:8
      interp_weight_chunks(:,i)=interp(interp_weight_chunk(:,i),4);
  end 
  
 output_r = zeros(2880016,1);
 output_l = zeros(2880016,1);

  for i=1:4
      output_r(:,1)=output_r(:,1) + interp_weight_chunks(:,i);
  end
  
  for i=5:8
      output_l(:,1)=output_l(:,1) + interp_weight_chunks(:,i);
  end
  
  

audiowrite('output_r.wav',output_r,Fs1);
audiowrite('output_l.wav',output_l,Fs1);


%%
% Question 9
% Filtering the weights using smooth filter:
% Smooth filter evaluates the average of neighbours that interprets as LP

smoothed_weight_1 = smooth(W_sch_1(:));
smoothed_weight_2 = smooth(W_sch_2(:));
smoothed_weight_3 = smooth(W_sch_3(:));
smoothed_weight_4 = smooth(W_sch_4(:));

smoothed_W_sch = [smoothed_weight_1;smoothed_weight_2;smoothed_weight_3;smoothed_weight_4];


 weight_chunks=zeros(256,11250,8);
 for i=1:4
     for j=1:2812
     weight_chunks(:,j,i) = chunked_channels_m(:,j,i).*smoothed_W_sch(2812*(i-1)+j);
     weight_chunks(:,j,i+4) =  weight_chunks(:,j,i);
     end
 end
 
output_sm_r = zeros(2880016,1);
output_sm_l = zeros(2880016,1);
 
 interp_weight_chunk = zeros(720004,8);
  for j=1:8
    for i=1:2812
     interp_weight_chunk(256*(i-1)+1:256*i,j)=weight_chunks(:,i,j);
    end
  end
  
  
  for i=1:8
      interp_weight_chunks(:,i)=interp(interp_weight_chunk(:,i),4);
  end 
  
  
  for i=1:4
      output_sm__r(:,1)=output_sm_r(:,1)+interp_weight_chunks(:,i);
  end
  
  for i=5:8
      output_sm_l(:,1)=output_sm_l(:,1)+interp_weight_chunks(:,i);
  end
  
audiowrite('output_sm_r.wav',output_sm_r,Fs1);
audiowrite('output_sm_l.wav',output_sm_l,Fs1);






