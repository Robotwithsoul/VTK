function [ output_args ] = op_high_contrast( handles,rotate_corner,rotate_image,Ps )
center=round(mean(rotate_corner));

% we let the user choose 2 points from big line pairs center to the small
% line pairs center, which determines the rotate direction.

% 1.closewise condition
dL1=round(32/Ps);
pre_center=zeros(4,2);
pre_center(1,:)=[center(1) center(2)-dL1];
pre_center(2,:)=[center(1)+dL1 center(2)];
pre_center(3,:)=[center(1) center(2)+dL1];
pre_center(4,:)=[center(1)-dL1 center(2)];

dL_bg=round(39/Ps);
bg_center=zeros(4,2);
bg_center(1,:)=[center(1) center(2)-dL_bg];
bg_center(2,:)=[center(1)+dL_bg center(2)];
bg_center(3,:)=[center(1) center(2)+dL_bg];
bg_center(4,:)=[center(1)-dL_bg center(2)];
imshow(rotate_image,[]); hold on
scatter(pre_center(:,1),pre_center(:,2),'r')
%scatter(center(1),center(2),'r')
user_center=round(ginput(2));

% 1.1 find the most close pree_center to first user defined center 
temp=repmat(user_center(1,:),[4 1]);
dis=pre_center-temp;
dis=dis(:,1).^2+dis(:,2).^2;
[~,ind_c1]=min(dis);

temp=repmat(user_center(2,:),[4 1]);
dis=pre_center-temp;
dis=dis(:,1).^2+dis(:,2).^2;
[~,ind_c2]=min(dis);



% to tell the rotate direction
r1_v=user_center(1,:)-center;
r2_v=user_center(2,:)-center;

ro_direc=cross([r1_v 0],[r2_v 0]);
% if rodirection(3)>0------>clockwise;

[line1,bg_line1]=get_highr_line(rotate_image,pre_center,bg_center,ind_c1,ro_direc(3),Ps);
%[line12,~]=get_highr_line(rotate_image,)

%figure;plot(line1')
[cnr1,cnr11]=get_cnrfrom_highline(line1(1,:),bg_line1,1,Ps);

[line2,bg_line2]=get_highr_line(rotate_image,pre_center,bg_center,ind_c2,ro_direc(3),Ps);
%figure;plot(line2')
[cnr2,cnr21]=get_cnrfrom_highline(line2(1,:),bg_line2,2,Ps);
% this is the figure using the min
figure;
plot([cnr1' cnr2']);title('评价曲线1')
out=Get_cutoff_Lp([cnr1' cnr2'],str2double(handles.threshhod_edit.String));
hold on;
scatter(out(1),out(2),'r');



% this is the figure using the mean
figure;
plot([cnr11' cnr21']);title('评价曲线2')
out=Get_cutoff_Lp([cnr11' cnr21'],str2double(handles.threshhod_edit.String));
hold on;
scatter(out(1),out(2),'r');

end

