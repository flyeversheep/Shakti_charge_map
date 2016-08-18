function  realspace( fname )
%This function generate the real space spin configuration based on the XMCD
%spreadsheet 
xmcdname = sprintf('%s_XMCD_6_13.csv',fname);
xmcd = csvread(xmcdname);
dim = size(xmcd);
row = max(xmcd(:,1));
column = max(xmcd(:,2));
total = 64;
for i = 1:total
    spreadsheetname = sprintf('%s%04d.xls',fname,i-1);
    spread = zeros(row,column);
    for j = 1:dim(1)
        spread(int32(xmcd(j,1)),int32(xmcd(j,2))) = xmcd(j,i+2);
    end
    xlswrite(spreadsheetname,spread);
end


end

