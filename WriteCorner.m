function [ flag ] = WriteCorner( path, corner )
% use this we can write cornerdata to txt
fid=fopen(path,'wt');
fprintf(fid,'%d\t',corner(1,1));
fprintf(fid,'%d\n',corner(1,2));

fprintf(fid,'%d\t',corner(2,1));
fprintf(fid,'%d\n',corner(2,2));

fprintf(fid,'%d\t',corner(3,1));
fprintf(fid,'%d\n',corner(3,2));

fprintf(fid,'%d\t',corner(4,1));
fprintf(fid,'%d\n',corner(4,2));

fclose(fid);
end

