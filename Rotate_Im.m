function [Im,corner] = Rotate_Im( Dicom_Im,fine_corner)

% we design an image which only contains the corner, so we can locate the
% corner after the rotate.

corner_image=zeros(size(Dicom_Im));
for p=1:4
    corner_image(fine_corner(p,2),fine_corner(p,1))=10;
end

% 1. first we calculate the rotate angle(countercloskwise)
rotate_v=fine_corner(2,:)-fine_corner(1,:);
axis_v=[1 0];
theta= acosd(dot(rotate_v,axis_v)/(norm(rotate_v)*norm(axis_v)));

temp=cross([axis_v 0],[rotate_v 0]);
if (temp(3)<0)
    
else
    theta=360-theta;
end


% 2. we start to rotate; this is to find the corner after rotate
corner_rotate=imrotate(corner_image,-theta,'bilinear','crop');

[yy,xx]=find(corner_rotate~=0);
xy=[xx yy];
% use clustering method to fnd the loaction of corner
[~,U,~]=fcm(xy,4);
[~,ind]=max(U);
corner=zeros(4,2);

for k=1:4
    corner(k,:)=mean(xy((ind==k),:));   
end
% in order to use the corners conveniently, we'd better to sort them
% 1 2
% 3 4
[~,temp_ind]=sort(corner(:,2));
temp_c=corner(temp_ind,:);
if(temp_c(1,1)<temp_c(2,1))
    corner(1,:)=temp_c(1,:);
    corner(2,:)=temp_c(2,:);
else
    corner(1,:)=temp_c(2,:);
    corner(2,:)=temp_c(1,:);
end

if(temp_c(3,1)<temp_c(4,1))
    corner(3,:)=temp_c(3,:);
    corner(4,:)=temp_c(4,:);
else
    corner(3,:)=temp_c(4,:);
    corner(4,:)=temp_c(3,:);
end

Im=imrotate(Dicom_Im,-theta,'bilinear','crop');



end

