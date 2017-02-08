function [ fine_center ] = op_find_exact_center(image,precenter,Ps)
dL=round(4.5/Ps);
temp=image(precenter(2)-dL:precenter(2)+dL,precenter(1)-dL:precenter(1)+dL);
%figure; imshow(temp,[])
mat_temp=mat2gray(temp);
temp2=(mat_temp>0.4);
[yy,xx]=find(temp2==1);
fine_center=mean([xx yy])+[precenter(1)-dL-1 precenter(2)-dL-1];


end

