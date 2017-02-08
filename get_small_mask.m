function [ outmask ] = get_small_mask( mask,ps)
% this function is to generate a circle mask in the given square 
L=size(mask,1);
cc=(L+1)/2;

temp1=repmat(1:L,[L 1]);
temp2=repmat((1:L)',[1 L]);
dis=(((temp1-cc).^2+(temp2-cc).^2).^0.5)*ps;

outmask=(dis<=10); % the small circle' radius is about 10mm


end

