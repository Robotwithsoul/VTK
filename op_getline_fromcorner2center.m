function [ line_y,line_x,line_v] = op_getline_fromcorner2center(image,center,corner,Ps)
% this function can get line given center and corner
corner=round(corner);
p_sub=round(15/Ps);
% 1. rearrange the x and make sure it start from corner
if (corner(1)<center(1))
    x=corner(1)+p_sub:center(1);
else
    x=corner(1)-p_sub:-1:center(1);
end

% 2. we get the coresponding y
y=(corner(2)-center(2))/(corner(1)-center(1))*(x-center(1))+center(2);
line_y=round(y);
line_x=x;

y_dim=size(image,1);

ind=(line_x-1)*y_dim+line_y;

line_v=image(ind);


end

