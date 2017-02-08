function [ output_args ] = op_deformed( handles,rotate_corner,rotate_image,Ps )
center=round(mean(rotate_corner));


%imshow(rotate_image,[]); hold on
finecenter=zeros(4,2,3);

dL=[round(55.5/Ps) round(70/Ps) round(84.5/Ps)];
pre_center=zeros(4,2);

% we devide the points into 3 groups; each group has 4 points which are the
% corners of a square.
% up->1; right->2; down->3 ;left->4

for iter=1:3
    pre_center(1,:)=[center(1) center(2)-dL(iter)];
    pre_center(2,:)=[center(1)+dL(iter) center(2)];
    pre_center(3,:)=[center(1) center(2)+dL(iter)];
    pre_center(4,:)=[center(1)-dL(iter) center(2)];
    for iter1=1:4
        finecenter(iter1,:,iter)=op_find_exact_center(rotate_image,pre_center(iter1,:),Ps);
    end  
end
%scatter(finecenter(:,1,3),finecenter(:,2,3),'r')

% now we calculate the distance fo these points.
dis_p=zeros(3,4);
for k1=1:3
    for k2=1:4
        if(k2>3)
           r=mod(k2+1,4); 
        else
           r=k2+1;
        end       
        dis_p(k1,k2)=((sum((finecenter(k2,:,k1)-finecenter(r,:,k1)).^2))^0.5)*Ps;
    end
end
handles.axes1;
hold on;
plot([finecenter(:,1,1);finecenter(1,1,1)],[finecenter(:,2,1);finecenter(1,2,1)],'r');
plot([finecenter(:,1,2);finecenter(1,1,2)],[finecenter(:,2,2);finecenter(1,2,2)],'g');
plot([finecenter(:,1,3);finecenter(1,1,3)],[finecenter(:,2,3);finecenter(1,2,3)],'b');


% prepare for write
cell4write=cell(13,4);
cell4write(1,:)={'','长度','纵横比','比值'};
cell4write(:,1)={'','L1','L2','L3','L4','L5','L6','L7','L8','L9','L10','L11','L12'};
cell4write(2:13,3)={'L1/L2','L1/L4','L3/L2','L3/L4','L5/L6','L5/L8','L7/L6','L7/L8','L9/L10','L9/L12','L11/L10','L11/L12'};
cell4write(2,2)={dis_p(1,4)};  cell4write(2,4)={dis_p(1,4)/dis_p(1,1)};
cell4write(3,2)={dis_p(1,1)};  cell4write(3,4)={dis_p(1,4)/dis_p(1,3)};
cell4write(4,2)={dis_p(1,2)};  cell4write(4,4)={dis_p(1,2)/dis_p(1,1)};
cell4write(5,2)={dis_p(1,3)};  cell4write(5,4)={dis_p(1,2)/dis_p(1,3)};
%
cell4write(6,2)={dis_p(2,4)};  cell4write(6,4)={dis_p(2,4)/dis_p(2,1)};
cell4write(7,2)={dis_p(2,1)};  cell4write(7,4)={dis_p(2,4)/dis_p(2,3)};
cell4write(8,2)={dis_p(2,2)};  cell4write(8,4)={dis_p(2,2)/dis_p(2,1)};
cell4write(9,2)={dis_p(2,3)};  cell4write(9,4)={dis_p(2,2)/dis_p(2,3)};

cell4write(10,2)={dis_p(3,4)}; cell4write(10,4)={dis_p(3,4)/dis_p(3,1)};
cell4write(11,2)={dis_p(3,1)}; cell4write(11,4)={dis_p(3,4)/dis_p(3,3)};
cell4write(12,2)={dis_p(3,2)}; cell4write(12,4)={dis_p(3,2)/dis_p(3,1)};
cell4write(13,2)={dis_p(3,3)}; cell4write(13,4)={dis_p(3,2)/dis_p(3,3)};

path=handles.axes1.UserData.path;
xlswrite([path 'deformed_slice_info.xlsx'],cell4write);



end

