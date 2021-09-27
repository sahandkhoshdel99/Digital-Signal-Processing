% Calculating histograms total area;

function total_area = area_cal(bin_values)

% Iterating on the bins and adding up the areass of the bars 
total_area = 0;
for k = 1: length(bin_values)
    total_area = total_area + bin_values(k);
end

