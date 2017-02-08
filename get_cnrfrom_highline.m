function [ cnr_min,cnr_mean ] = get_cnrfrom_highline( line,bg_line,type,Ps )
% this function can get the ratio of (min/max) from the profile
% cnr_min and cnr_mean are derived from different strategy

if(type==1)
    cnr_min=zeros(4,1);
    cnr_mean=cnr_min;
   dis=[1 round(28/Ps) round(44/Ps) round(56.5/Ps) round(70/Ps)];
   dis1=[round(8.6/Ps) round(28/Ps) round(44/Ps) round(56.5/Ps) round(70/Ps)];
   num_peak=[0 3 3 4];
   for k=1:4
      temp=line(dis(k):dis(k+1));
      %temp2=bg_line(dis1(k):dis1(k+1));
      temp_mean=mean(bg_line(dis1(k):dis1(k+1)));
      [cnr_mean(k),max_point,min_point]=op_calculate_cnr(temp,temp_mean,1);
      if(k==1)
          cnr_mean(1)=0;
          cnr_min(1)=0;
          %(mean(temp(min_point))-temp_mean)/(mean(temp(max_point))-temp_mean);
      else
          if (length(max_point)==num_peak(k))
               cnr_min(k)=min((temp(min_point)-temp_mean)/(temp(max_point(1:end-1))-temp_mean));
          else
               cnr_min(k)=1;
          end

      end
%       figure; plot(temp); hold on 
%       plot(temp2)
%       
   end

else
   cnr_min=zeros(4,1);
   cnr_mean=cnr_min;
   dis=[round(16.4/Ps) round(29/Ps) round(40/Ps) round(50.5/Ps) round(60/Ps)  ];
   num_peak=[5 5 5 5];
   for k=1:4
      temp=line(dis(k):dis(k+1));
      %temp2=bg_line(dis(k):dis(k+1));
      temp_mean=mean(bg_line(dis(k):dis(k+1)));
      [cnr_mean(k),max_point,min_point]=op_calculate_cnr(temp,temp_mean,2);   
      
      if (length(max_point)==num_peak(k))
           cnr_min(k)=min((temp(min_point)-temp_mean)/(temp(max_point(1:end-1))-temp_mean));
      else
           cnr_min(k)=1;
      end
    
%      figure; plot(temp); 
%      hold on ;plot(temp2)
   end
    
end




end

