function [ out ] = Get_cutoff_Lp( line,threshold )
temp1=line>threshold;
k=find(temp1==1);
k=min(k);

k1=(k-1)+(threshold-line(k-1))/(line(k)-line(k-1));

%temp2=line>threshold;
out=[k1,threshold];


end

