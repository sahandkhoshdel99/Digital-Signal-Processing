 %%
 clc;
 close all;
 
 % Part 1 : Applying sample kernels:
 
house_raw = imread("house.jpg");
 house = rgb2gray(house_raw);
 
 % Manually defining filters metioned in the intsructions:
 
 sharpen = [0,-1,0;-1,5,-1;0,-1,0];
 blur = [0.0625,0.125,0.0625;0.125,0.25,0.125;0.0625,0.125,0.0625];
 outline = [-1,-1,-1;-1,8,-1;-1,-1,-1];
 gauss = [0.0113,0.0838,0.0113;0.0838,0.6193,0.0838;0.0113,0.1111,0.0113];
 avg_moving = [0.1111,0.1111,0.1111;0.1111,0.1111,0.1111;0.1111,0.1111,0.1111];
 line_H = [-1,-1,-1;2,2,2;-1,-1,-1];
 line_V = [-1,2,-1;-1,2,-1;-1,2,-1];
 identity = [0,0,0;0,1,0;0,0,0];
 
 % Applying the filters to the image house.jpg and Displaying the filtered images:
 figure
 house_sharpen = conv2(house,sharpen);
 imshow(uint8(abs(house_sharpen)));
   title('Sharpen filter')

 figure
 house_blur =  conv2(house,blur);
 imshow(uint8(abs(house_blur)));
   title('Blur filter')

figure
 house_outline =  conv2(house,outline);
 imshow(uint8(abs(house_outline)));
   title('Outline filter')

figure
 house_gauss =  conv2(house,gauss);
 imshow(uint8(abs(house_gauss)));
   title('Gaussian Blur filter')

figure
 house_avg_moving =  conv2(house,avg_moving);
 imshow(uint8(abs(house_avg_moving)));
   title('Average Moving filter')

figure
 house_line_H =  conv2(house,line_H);
 imshow(uint8(abs(house_line_H)));
   title('Horizontal Line filter')

figure
 house_line_V =  conv2(house,line_V);
 imshow(uint8(abs(house_line_V)));
   title('Vertical Line filter')

figure
 house_identity =  conv2(house,identity);
 imshow(uint8(abs(house_identity)));
    title('Identity filter')

 
 %%
 % Part 2 : Kobe:
 
 kobe_raw = imread("kobe.jpeg");
 figure
 subplot(2,2,1), imshow(kobe_raw)
 title('Pre Proccessed(raw) image')
 
 kobe = imresize(kobe_raw,0.2); 
 subplot(2,2,2), imshow(kobe);
 title('Down-sampled image')
 
 kobe_intrp = imresize(kobe,5,'nearest');
 subplot(2,2,3), imshow(kobe_intrp);
 title('Reconstructed Image')
 
 kobe_final = imfilter(kobe_intrp, avg_moving);
 subplot(2,2,4), imshow(kobe_final);
 title('Final Enhanced Image')
 
 %%
 % Part 3 : Page Detection
 
 page = imread("page.jpg");
 page_gray = rgb2gray(page);
 
 % Highliting vertical and horizantal edges using line_v and line_H:
 
 v_page = imfilter(page_gray,line_V);
 h_page = imfilter(page_gray,line_H);
 imwrite(v_page,"vertical.jpg");
 imwrite(h_page,"horizantal.jpg");

figure
subplot(1,2,1), imshow(v_page);
title("line_V Output")
subplot(1,2,2), imshow(h_page);
title("line_H Output")

% Detecting corners for page detection:
 vsum = sum(v_page,1);
 hsum = sum(h_page,2);
 

 vsum_sm = smooth(smooth(vsum));
%   figure
%   plot(vsum_sm);

 for i=1:length(vsum_sm)
     if (i<200) || (i>2800)
        vsum_sm(i) = 0;
     end
 end
 [v_max,max_index_v] = maxk(vsum_sm,2);
 
 
 hsum_sm = smooth(smooth(hsum));
%   figure
%   plot(hsum_sm);

 for i=1:length(hsum_sm)
     if (i<200) || (i>2800)
        hsum_sm(i) = 0;
     end
 end

 % There were two noise( unreal ) peak values near the first peak 
 % I used maxk, 4 to find the second real peak an then
 
 [h_max,max_index_h] = maxk(hsum_sm,4);
 h_max = [h_max(2),h_max(4)];
 max_index_h = [max_index_h(2),max_index_h(4)];
 % Indicating the corner pixel positions:
 
 top_left = [max_index_v(1),max_index_h(1)];
 top_right = [max_index_v(2),max_index_h(1)];
 bottom_left = [max_index_v(1),max_index_h(2)];
 bottom_right = [max_index_v(2),max_index_h(2)];
 
corners = [top_left;top_right;bottom_left;bottom_right];

rect_length = max_index_v(2) - max_index_v(1)
rect_width = max_index_h(2) - max_index_h(1)

figure
imshow(page);
hold on;
rectangle('position',[top_left(1),top_left(2),rect_length,rect_width],'EdgeColor','r');

 
 
 
 