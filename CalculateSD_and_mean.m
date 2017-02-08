function [final_mask,SDandMean] =CalculateSD_and_mean(image, center,dL,s_mask,big_mask)
% this function is:
% 1. calculate the sd and mean of each circle;
% 2. get a local mask for each circle
SDandMean=[0 0];

temp_im=image(center(2)-dL:center(2)+dL,center(1)-dL:center(1)+dL);
temp1=temp_im.*s_mask;
Num=sum(s_mask(:));
SDandMean(1)=sum(temp1(:))/Num;

temp2=((temp_im-SDandMean(1)).*s_mask).^2;
SDandMean(2)=(sum(temp2(:))/(Num-1))^0.5;


big_mask(center(2)-dL:center(2)+dL,center(1)-dL:center(1)+dL)=s_mask;

final_mask=big_mask;


end

