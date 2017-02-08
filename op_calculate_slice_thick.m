function [ thickness ] = op_calculate_slice_thick( line,Ps )
% this function can calculate the thickness from the profile

% 1. first we find the minium of this line
[Min,min_ind]=min(line);

%2. cut the line into half to find the maxinum

temp1=line(1:min_ind);
temp2=line(min_ind:end);
[~,max_ind1]=max(temp1);
[~,max_ind2]=max(temp2);

max1=mean(temp1(max_ind1:max_ind1+2));
max2=mean(temp2(max_ind2-2:max_ind2));

base_max=(max1+max2)/2;

% calculate the FWHM
half_p=(Min+base_max)/2;

[~,left_p]=min(abs(temp1(max_ind1:end)-half_p));
[~,right_p]=min(abs(temp2(1:max_ind2)-half_p));

FWHM=(min_ind-max_ind1-left_p+right_p-1)*Ps;

thickness=FWHM*0.25;




end

