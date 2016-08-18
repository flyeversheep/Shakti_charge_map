for j = 180:2:220
    for i = 1:4  
        filename = sprintf('shakti600_%3dK_%1d#',j,i);
        filenamecheck = sprintf('%s_XMCD_6_13.csv',filename);
        display(filename);
         if(exist(filenamecheck,'file'))
             realspace(filename);
         end
    end
end