function [ fine_center ] = op_find_exact_center2( image,pre_center,Ps )
% given the rough center, this function can calculate the precise center of
% the low contrast objects according to the iamge.
dL1=round(6.7/Ps);
temp=image(pre_center(2)-dL1:pre_center(2)+dL1,pre_center(1)-dL1:pre_center(1)+dL1);
temp=mat2gray(temp);

BW=temp>=0.6;
% beacause we just choose a rectangle roi, it may contain unrelevant points
% that we don't want. so we use bwareaopen to remove the connected points
% less then 20; the results is good
BW=bwareaopen(BW,20);
[yy,xx]=find(BW==1);
fine_center=mean([xx yy])+[pre_center(1)-dL1-1 pre_center(2)-dL1-1];


end

