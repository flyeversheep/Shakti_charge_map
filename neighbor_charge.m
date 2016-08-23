function [ratio_change,ratio_unchange]=neighbor_charge(startin)
%This function calculate the average absolute charge value of four-island
%vertices in the vicinity of a changed/unchanged three-island vertices
switch nargin
    case 1
        start = startin;
    otherwise
        start = 0;
end
filen = input('Please input the name of the file you want to analyze, end with #:');
total = input('please input the total number of images you want to analyze:');
count_change = 0;
charge_change = 0;
count_unchange = 0;
charge_unchange =0;
for k = start:start+total-2
% for k=0:0
        filename = sprintf('chargemap%s%04d.xls',filen,k);
        filename2 = sprintf('3islandmap%s%04d.xls',filen,k);
        filename3 = sprintf('3islandmap%s%04d.xls',filen,k+1);
        filearray = xlsread(filename);
        filearray2 = xlsread(filename2);
        filearray3 = xlsread(filename3);
        filearraydiff = (filearray2==filearray3).*filearray2;
        if(k==start)
            dim = size(filearray);
        end
        for i = 2:2:dim(1)-2
            for j = 2:2:dim(2)-2
                charge4 = 0;
                if(filearray(i-1,j-1)~=99)
                    charge4 = charge4+abs(filearray(i-1,j-1));
                end
                if(filearray(i+1,j-1)~=99)
                    charge4 = charge4+abs(filearray(i+1,j-1));
                end
                if(filearray(i-1,j+1)~=99)
                    charge4 = charge4+abs(filearray(i-1,j+1));
                end
                if(filearray(i+1,j+1)~=99)
                    charge4 = charge4+abs(filearray(i+1,j+1));
                end
                if(filearraydiff(i,j)==0)
                    count_change = count_change + 1;
                    charge_change = charge_change + charge4;
                elseif(abs(filearraydiff(i,j))==1)
                    count_unchange = count_unchange + 1;
                    charge_unchange = charge_unchange + charge4;
                end
            end
        end
end
ratio_change = charge_change/count_change;
ratio_unchange = charge_unchange/count_unchange;
% display([count_change,charge_change,count_unchange,charge_unchange]);
end

