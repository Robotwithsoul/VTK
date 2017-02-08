function [ outmask ] = get_lowR_objmask( L,radius,Ps )

% this function can generate a square filled with 0 and this can be used to
% generate a circle mask.
% L--->half length of the square side.
cc=L+1;
SL=2*L+1;
temp1=repmat(1:SL,[SL 1]);
temp2=repmat((1:SL)',[1 SL]);
dis=(((temp1-cc).^2+(temp2-cc).^2).^0.5)*Ps;
outmask=(dis<radius);



end

