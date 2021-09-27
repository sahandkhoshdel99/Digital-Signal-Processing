function std_dev = deviation(total_area, bin_values, mean, first)

% Caclulating standard deviation with (1-sigma = 68 percent) method:
% 1-sigma method has less accuracey than 3-sigma method in general
% But in This case we want the main speakers voice to be taken out.

left = 0;
right = 0;
covered_area = 0;
last = length(bin_values) + first - 1;

% iterating on a loop from the mean to left and right equally:

% j is the decrementing counter for calcuating left areas
% i is the incrementing counter for calculating right areas

j = floor(mean);
for i = floor(mean)+1:last
    
  right  = right + bin_values(i-first + 1);
  left = left + bin_values(j-first + 1);
  covered_area = right + left;
  
  if(covered_area >= 0.6827* total_area)
    % calculating the exact std using interpolation in the specified bin:  
     std_dev = i -(mean);
      
      break;    

  end
  j = j-1;
end