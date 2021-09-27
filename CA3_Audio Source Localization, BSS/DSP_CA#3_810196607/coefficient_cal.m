function w_sch = coefficient_cal(lag_index, mean, std_dev)
w_sch =  exp((-(lag_index - mean).^2 / (2*std_dev^2)));
end

