function [ line,bg_line ] = get_highr_line( image,precenter,bg_center,ind_c,direction,Ps )
%if we know the number of the user defined point and the roatate drerction
%we can get the line
dL=round(42/Ps);
dL1=round(1/Ps);
line=zeros(3,2*dL+1);
switch ind_c
    case 1
        if (direction>0)
            line(1,:)=image(precenter(1,2),precenter(1,1)-dL:precenter(1,1)+dL);
            line(2,:)=image(precenter(1,2)-dL1,precenter(1,1)-dL:precenter(1,1)+dL);
            line(3,:)=image(precenter(1,2)+dL1,precenter(1,1)-dL:precenter(1,1)+dL);
            bg_line=image(bg_center(1,2),bg_center(1,1)-dL:bg_center(1,1)+dL);
        else
            line(1,:)=image(precenter(1,2),precenter(1,1)+dL:-1:precenter(1,1)-dL);
            line(2,:)=image(precenter(1,2)-dL1,precenter(1,1)+dL:-1:precenter(1,1)-dL);
            line(3,:)=image(precenter(1,2)+dL1,precenter(1,1)+dL:-1:precenter(1,1)-dL);
                      
            bg_line=image(bg_center(1,2),bg_center(1,1)+dL:-1:bg_center(1,1)-dL);
        end
        
    case 2
        if (direction>0)
            
            line(1,:)=image(precenter(2,2)-dL:precenter(2,2)+dL,precenter(2,1));
            line(2,:)=image(precenter(2,2)-dL:precenter(2,2)+dL,precenter(2,1)-dL1);
            line(3,:)=image(precenter(2,2)-dL:precenter(2,2)+dL,precenter(2,1)+dL1);
            bg_line=image(bg_center(2,2)-dL:bg_center(2,2)+dL,bg_center(2,1));
        else
            line(1,:)=image(precenter(2,2)+dL:-1:precenter(2,2)-dL,precenter(2,1));
            line(2,:)=image(precenter(2,2)+dL:-1:precenter(2,2)-dL,precenter(2,1)-dL1);
            line(3,:)=image(precenter(2,2)+dL:-1:precenter(2,2)-dL,precenter(2,1)+dL1);
            bg_line=image(bg_center(2,2)+dL:-1:bg_center(2,2)-dL,bg_center(2,1));
        end
              
        
    case 3
        if (direction>0)
            line(1,:)=image(precenter(3,2),precenter(3,1)+dL:-1:precenter(3,1)-dL);
            line(2,:)=image(precenter(3,2)-dL1,precenter(3,1)+dL:-1:precenter(3,1)-dL);
            line(3,:)=image(precenter(3,2)+dL1,precenter(3,1)+dL:-1:precenter(3,1)-dL);
            bg_line=image(bg_center(3,2),bg_center(3,1)+dL:-1:bg_center(3,1)-dL);
        else
            line(1,:)=image(precenter(3,2),precenter(3,1)-dL:precenter(3,1)+dL);
            line(2,:)=image(precenter(3,2)-dL1,precenter(3,1)-dL:precenter(3,1)+dL);
            line(3,:)=image(precenter(3,2)+dL1,precenter(3,1)-dL:precenter(3,1)+dL);
            bg_line=image(bg_center(3,2),bg_center(3,1)-dL:bg_center(3,1)+dL);
        end
        
        
    case 4
        
        if (direction>0)
            line(1,:)=image(precenter(4,2)+dL:-1:precenter(4,2)-dL,precenter(4,1));
            line(2,:)=image(precenter(4,2)+dL:-1:precenter(4,2)-dL,precenter(4,1)-dL1);
            line(3,:)=image(precenter(4,2)+dL:-1:precenter(4,2)-dL,precenter(4,1)+dL1);
            bg_line=image(bg_center(4,2)+dL:-1:bg_center(4,2)-dL,bg_center(4,1));
        else
            line(1,:)=image(precenter(4,2)-dL:precenter(4,2)+dL,precenter(4,1));
            line(1,:)=image(precenter(4,2)-dL:precenter(4,2)+dL,precenter(4,1)-dL1);
            line(1,:)=image(precenter(4,2)-dL:precenter(4,2)+dL,precenter(4,1)+dL1);
            bg_line=image(bg_center(4,2)-dL:bg_center(4,2)+dL,bg_center(4,1));
        end
        
end


end

