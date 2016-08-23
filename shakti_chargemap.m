function shakti_chargemap(startin)
    %This program is to transform the spin direction map of shakti PEEM into Charge map
    %written by Yuyang Lao 12/14/2015
    %This version add the function to discriminate the happy and
    %unhappy vertices in 3-legged vertices. Store this information in
    %3islandmap spreadsheet. Denoted as +1 if it's unhappy vertex and -1 as
    %happy vertex
    switch nargin
    case 1
        start=startin;
    otherwise
        start=0;
    end
     filen=input('Please input the name of the file you want to analyze, end with #:');
     total=input('please input the total number of images you want to analyze:');
     for k=start:start+total-1
        filename=sprintf('shakti600_input/%s%04d.xls',filen,k);
        resultname=sprintf('chargemap%s%04d.xls',filen,k);
        resultname2=sprintf('3islandmap%s%04d.xls',filen,k);
        filearray=xlsread(filename);
        if(k==start)
            dim=size(filearray);
            maxi=floor(dim(1)/4);
            maxj=floor(dim(2)/4);
        end
        resultarray=99*ones(dim(1),dim(2));
        resultarray2=99*ones(dim(1),dim(2));
        for i=0:maxi
            for j=0:maxj
                origin=[1+i*4 1+j*4];
                %first 4 island vertex
                if(origin(1)+1<=dim(1)&&origin(2)+1<=dim(2))
                    temp = filearray(origin(1),origin(2))+filearray(origin(1)+1,origin(2))-filearray(origin(1),origin(2)+1)-filearray(origin(1)+1,origin(2)+1);
                    resultarray(origin(1),origin(2)) = temp;
                    if(temp ==0 )
                         resultarray2(origin(1),origin(2)) = filearray(origin(1),origin(2))*filearray(origin(1)+1,origin(2));
                    end
                end
                %second 4 island vertex
                if(origin(1)+3<=dim(1)&&origin(2)+3<=dim(2))
                    temp = filearray(origin(1)+2,origin(2)+2)+filearray(origin(1)+3,origin(2)+2)-filearray(origin(1)+2,origin(2)+3)-filearray(origin(1)+3,origin(2)+3);
                    resultarray(origin(1)+2,origin(2)+2) = temp;
                    if(temp ==0)
                         resultarray2(origin(1)+2,origin(2)+2) = filearray(origin(1)+2,origin(2)+2)*filearray(origin(1)+3,origin(2)+2);
                    end
                end
                %first 3 island vertex
                if(origin(1)+2<=dim(1)&&origin(2)+4<=dim(2))
                    temp=filearray(origin(1)+2,origin(2)+3)-filearray(origin(1)+1,origin(2)+4)-filearray(origin(1)+2,origin(2)+4);
                    resultarray(origin(1)+1,origin(2)+3)=temp;
                    if(abs(temp)==1)
                        resultarray2(origin(1)+1,origin(2)+3)=filearray(origin(1)+2,origin(2)+3)*filearray(origin(1)+1,origin(2)+4);
                    end
                end
                %second 3 island vertex
                if(origin(1)+2<=dim(1)&&origin(2)+2<=dim(2))
                    temp=filearray(origin(1)+1,origin(2)+1)-filearray(origin(1)+1,origin(2)+2)-filearray(origin(1)+2,origin(2)+2);
                    resultarray(origin(1)+1,origin(2)+1)=temp;
                    if(abs(temp)==1)
                        resultarray2(origin(1)+1,origin(2)+1)=filearray(origin(1)+1,origin(2)+1)*filearray(origin(1)+2,origin(2)+2);
                    end
                end
                %third 3 island vertex
                if(origin(1)+4<=dim(1)&&origin(2)+2<=dim(2))
                    temp=filearray(origin(1)+3,origin(2)+1)+filearray(origin(1)+4,origin(2)+1)-filearray(origin(1)+3,origin(2)+2);
                    resultarray(origin(1)+3,origin(2)+1)=temp;
                    if(abs(temp)==1)
                         resultarray2(origin(1)+3,origin(2)+1)=filearray(origin(1)+4,origin(2)+1)*filearray(origin(1)+3,origin(2)+2);
                    end
                end
                %fourth 3 island vertex
                if(origin(1)+4<=dim(1)&&origin(2)+4<=dim(2))
                    temp=filearray(origin(1)+3,origin(2)+3)+filearray(origin(1)+4,origin(2)+3)-filearray(origin(1)+4,origin(2)+4);
                    resultarray(origin(1)+3,origin(2)+3)=temp;
                    if(abs(temp)==1)
                        resultarray2(origin(1)+3,origin(2)+3)=filearray(origin(1)+3,origin(2)+3)*filearray(origin(1)+4,origin(2)+4);
                    end
                end
            end
        end
        xlswrite(resultname,resultarray);
        xlswrite(resultname2,resultarray2);
     end
end