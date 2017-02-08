function [ flag ] = op_uniformity( handles,rotate_corner,rotate_image,Ps)
% this function is to assess uniformity slice

% first get the center from the four corners
center=round(mean(rotate_corner));
L=round(29/Ps);  % 29mm is the length of two centers in horizontal or vertical direction
dx=[-L 0 L];
dy=dx;
dL=round(12/Ps); % 12mm is the length of half square
% we need a mask for marking the area we focused on
contour_mask=zeros(size(rotate_image));
s_mask=zeros(2*dL+1,2*dL+1);
s_mask=get_small_mask(s_mask,Ps);

% we also need a small mask for 
SDandMean=zeros(9,2);
s=1;

for kx=1:3
    for ky=1:3
        d_center=[center(1)+dx(kx) center(2)+dy(ky)];
        [contour_mask,tempsd_mean]=CalculateSD_and_mean(rotate_image,d_center,dL,s_mask....
            ,contour_mask);
        SDandMean(s,:)=tempsd_mean;
        s=s+1;        
    end
end
im1=mat2gray(rotate_image);

%prepare to write in xls
cell4write=cell(13,3);
cell4write(:,1)={'','R1','R2','R3','R4','R5','R6','R7','R8','R9','','均值标准差','最大值与最小值之差'};
cell4write(1,:)={'','均值','标准差'};
cell4write(2:10,2:3)=num2cell(SDandMean);
cell4write(12,2)={std(SDandMean(:,1))};
cell4write(13,2)={max(SDandMean(:,1))-min(SDandMean(:,1))};
path=handles.axes1.UserData.path;
xlswrite([path 'unifomity_info.xlsx'],cell4write,'SDandMean');



% then we calculate the slice thickness

[contour_mask,profile,thickness] = op_unifomity_get_thickness(center, rotate_image,contour_mask,Ps);


 axes(handles.axes1);
 imshow(im1,[]); hold on;
 color_mask=cat(3,contour_mask,zeros(size(contour_mask)),zeros(size(contour_mask)));
 h_c=imshow(color_mask);
 set(h_c,'AlphaData', 0.3)
 
 hold on
 %  the vertical and horizontal line
 
 dL2=round(40/Ps);
 Vx=repmat(center(1),[1 2*dL2+1 ]);
 Vy=center(2)-dL2:center(2)+dL2;
 plot(Vx,Vy,'g'); 

 Hy=repmat(center(2),[1 2*dL2+1]);
 Hx=center(1)-dL2:center(1)+dL2;
 plot(Hx,Hy,'r');
  
 VLine=rotate_image(center(2)-dL2:center(2)+dL2,center(1));
 figure(2);
 subplot(2,1,1); plot(Vy,VLine,'g');title('垂直Profile')
 HLine=rotate_image(center(2),center(1)-dL2:center(1)+dL2);
 subplot(2,1,2); plot(Hx,HLine,'r');title('水平Profile')

 figure;
plot(profile');title('反应层厚的Profile')
T=cell(4,1);
T{1}=['up-层厚' num2str(thickness(1)) 'mm'];
T{2}=['right-层厚' num2str(thickness(2)) 'mm'];
T{3}=['down-层厚' num2str(thickness(3)) 'mm'];
T{4}=['left-层厚' num2str(thickness(4)) 'mm'];
legend(T{1:4});
 
 flag=1;

end

