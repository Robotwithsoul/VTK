function [mask,profile,thickness] = op_unifomity_get_thickness(center, rotate_image,mask_flat,Ps)

%  this function can find the mask to calculate slice thickness
dL=round(55/Ps);
m_L=round(45/Ps);
m_W=round(4/Ps);

% 1. initialize the output
profile=zeros(4,2*m_L+1);
thickness=zeros(4,1);

% calculate as following order:

% 1.Up 
Upcenter=[center(1) center(2)-dL];
mask_flat(Upcenter(2)-m_W:Upcenter(2)+m_W,Upcenter(1)-m_L:Upcenter(1)+m_L)=1;
line1=mean(rotate_image(Upcenter(2)-5:Upcenter(2)+5,Upcenter(1)-m_L:Upcenter(1)+m_L));
profile(1,:)=line1;
thickness(1)=op_calculate_slice_thick(line1,Ps);

%2.right
rightc=[center(1)+dL center(2)];
mask_flat(rightc(2)-m_L:rightc(2)+m_L,rightc(1)-m_W:rightc(1)+m_W)=1;
line2=mean(rotate_image(rightc(2)-m_L:rightc(2)+m_L,rightc(1)-5:rightc(1)+5),2);
profile(2,:)=line2;
thickness(2)=op_calculate_slice_thick(line2,Ps);

%3.down
downc=[center(1) center(2)+dL];
mask_flat(downc(2)-m_W:downc(2)+m_W,downc(1)-m_L:downc(1)+m_L)=1;
line3=mean(rotate_image(downc(2)-5:downc(2)+5,downc(1)-m_L:downc(1)+m_L));
profile(3,:)=line3;
thickness(3)=op_calculate_slice_thick(line3,Ps);

%4.left
leftc=[center(1)-dL center(2)];
mask_flat(leftc(2)-m_L:leftc(2)+m_L,leftc(1)-m_W:leftc(1)+m_W)=1;
line4=mean(rotate_image(leftc(2)-m_L:leftc(2)+m_L,leftc(1)-5:leftc(1)+5),2);
profile(4,:)=line4;
thickness(4)=op_calculate_slice_thick(line4,Ps);

mask=mask_flat;



end

