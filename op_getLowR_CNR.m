function [ob_bj_sd_mean,CNR,outmask ] = op_getLowR_CNR(image,fine_center,center,obj_mask,final_mask,Ps )

% this function can get CNR given the fine center and generate the mask to
% show use the area they used.
dL=round(6/Ps);
% first to generate the mask to choose the points inside the object
temp=image(fine_center(2)-dL:fine_center(2)+dL,fine_center(1)-dL:fine_center(1)+dL);
final_mask(fine_center(2)-dL:fine_center(2)+dL,fine_center(1)-dL:fine_center(1)+dL)=obj_mask;
% 1. fisrt we can get the sd and mean of low contrast object;
temp2=temp.*obj_mask;
Num=sum(obj_mask(:));
Mob=sum(temp2(:))/Num;
temp2=((temp2-Mob).*obj_mask).^2;
SDob=(sum(temp2(:))/(Num-1))^0.5;

% then we get the background 
radius_v=fine_center-center;
norm_rv=radius_v/norm(radius_v);
vertical_v=[-norm_rv(2) norm_rv(1)];

bg_center=fine_center+round((11/Ps)*vertical_v);
dl1=round(3/Ps);
bgtemp=image(bg_center(2)-dl1:bg_center(2)+dl1,bg_center(1)-dl1:bg_center(1)+dl1);
final_mask(bg_center(2)-dl1:bg_center(2)+dl1,bg_center(1)-dl1:bg_center(1)+dl1)=1;
outmask=final_mask;
Mbg=mean(bgtemp(:));
SDbg=std(bgtemp(:));

CNR=(Mob-Mbg)/(SDob^2+SDbg^2)^0.5;
ob_bj_sd_mean=[Mob SDob Mbg SDbg];
end

