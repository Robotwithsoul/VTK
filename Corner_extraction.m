function [ fine_corner ] = Corner_extraction( cc,Image,ps)
 % given the Image and the coarse corner of a DICOM Image
 % this function can get the fine corner
 % cc->coarse corner
 
 % 1. get the corner number. Here we organize the corner in N x 2 format
 % (x,y);
 temp_corner=zeros(size(cc));
 c_Num=size(cc,1);
 crop_size=round(11/ps);
 % before we find the corner, use average filter in case the 
 
 h=fspecial('average',[3 3]);
 Image=imfilter(Image,h,'replicate');
 % 2. for every coarse corner, we find the exact corner in the image
 % since the ROI we choose may have several corner, we have to choose the 
 % most obvious one----here we use 'Corner function'
 
 for k=1:c_Num
     leftupx=cc(k,1)-crop_size;
     leftupy=cc(k,2)-crop_size;
     rightdownx=cc(k,1)+crop_size;
     rightdowny=cc(k,2)+crop_size;
     temp=Image(leftupy:rightdowny,leftupx:rightdownx);
     temp_corner(k,:)=corner(temp,1)+[leftupx leftupy]-1;
 end
 
 fine_corner=temp_corner;
 
 
 
 
 


end

