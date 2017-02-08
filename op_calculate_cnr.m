function [ CNR,max_point,min_point] = op_calculate_cnr( seg_line,M,type)

% set the threshold =mean(seg_line)
Th=mean(seg_line);
[p_max,ind_max]=findpeaks(seg_line,'MinPeakHeight',Th);
% figure;
% plot(seg_line); hold on;
% scatter(ind_max,p_max,'r')
max_point=ind_max;
[p_min,ind_min]=findpeaks(-seg_line);
if(type==1)
    %non_p=(p_min<-Th);
    %non_p1=(ind_min>min(ind_max)) & (ind_min<max(ind_max));s
    %non_p=non_p & non_p1;
    %p_min(non_p)=[];
    %ind_min(non_p)=[];
    non_p1=~((ind_min>min(ind_max)) & (ind_min<max(ind_max))); 
    p_min(non_p1)=[];
    ind_min(non_p1)=[];
    
else
    non_p1=~((ind_min>min(ind_max)) & (ind_min<max(ind_max))); 
    p_min(non_p1)=[];
    ind_min(non_p1)=[];
   
end

 min_point=ind_min;
% figure;
% plot(seg_line); hold on;
% scatter(ind_min,-p_min,'r')


CNR=(mean(-p_min)-M)/(mean(p_max)-M);

end

