function [ output_args ] = op_low_contrast( handles,rotate_corner,rotate_image,Ps )

% this function is the low contrast object assessment 

% 1. we get the image center
center=round(mean(rotate_corner));

% we use the relative position of the objects( to center)  to locate them
% Actually the objects have higher value then back ground which means that the
% objects can be easily detected by using threshhold. But the difficulty is
% that different images may have different values. Therefore we can't set a
% fixed threshold. To solve this problem, we normalize the value to (0,1).

% 2. get the theoratical position of the low contrast objects.
dL=round(21/Ps);
dcenter=zeros(4,2);
dcenter(1,:)=[center(1)-dL center(2)-dL];
dcenter(2,:)=[center(1)+dL center(2)-dL];
dcenter(3,:)=[center(1)-dL center(2)+dL];
dcenter(4,:)=[center(1)+dL center(2)+dL];
% imshow(rotate_image,[]); hold on
% scatter(dcenter(:,1),dcenter(:,2),'r')
fine_center=dcenter;  % initialize the fine_center

%3. get the low contrast object mask
obj_mask  = get_lowR_objmask( round(6/Ps),3,Ps );

final_mask=zeros(size(rotate_image));

CNR=zeros(4,1);
ob_bg_sd_mean=zeros(4,4);
% 4. for each low contrast object we find the fine center,and calculate a
% background mask. And finally get the CNR
for k=1:4
   fine_center(k,:)=op_find_exact_center2( rotate_image,dcenter(k,:),Ps);
   [ ob_bg_sd_mean(k,:),CNR(k),final_mask] = op_getLowR_CNR(rotate_image,...
       round(fine_center(k,:)),center,obj_mask,final_mask,Ps );   
end


% prepare for writing
cell4write=cell(5,6);
cell4write(1,:)={'组号','低分目标均值','低分目标标准差','背景均值','背景标准差','CNR'};
cell4write(2:5,1)={1,2,3,4};
[~,ind]=sort(CNR,'descend');
cell4write(2:5,2:5)=num2cell(ob_bg_sd_mean(ind,:));
cell4write(2:5,6)=num2cell(CNR(ind));
path=handles.axes1.UserData.path;
xlswrite([path 'low_contrast_slice_info.xlsx'],cell4write);


 axes(handles.axes1);
imshow(rotate_image,[ ]);
hold on;
color_mask=cat(3,final_mask,zeros(size(final_mask)),zeros(size(final_mask)));
h_c=imshow(color_mask);
set(h_c,'AlphaData', 0.3)


%imwrite(Oim,[path 'low_contrast.jpg']);


 
 
 %scatter(fine_center(:,1),fine_center(:,2),'r')
end

