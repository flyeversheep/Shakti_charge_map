function shakti_drawchargemap(startin)
    switch nargin
    case 1
        start=startin;
    otherwise
        start=0;
    end
     filen=input('Please input the name of the file you want to analyze, end with #:');
     total=input('please input the total number of images you want to analyze:');
     for k=start:start+total-1
        filename=sprintf('chargemap%s%04d.xls',filen,k);
        figurename=sprintf('chargemap%s%04d.tiff',filen,k);
        filearray=xlsread(filename);
        h=figure('visible','off');hold on;
        DisplayFigure=0;
        titlename=sprintf('Charge map of shakti, file%s',filen);
        title(titlename);
        create_legend();
        dim=size(filearray);
        for i=1:dim(1)
            for j=1:dim(2)
                if(filearray(i,j)~=99)
                    x=20+j*20;
                    y=-20-i*20;
                    if((mod(i,4)==1&&mod(j,4)==1)||(mod(i,4)==3&&mod(j,4)==3))
                        shape=1;
                    else
                        shape=0.5;
                    end
                    circle(x,y,shape,filearray(i,j));
                end
            end
        end
        saveas(h,figurename);
     end
end

function create_legend()
  t = [0,1];
  x = 50+0.001*cos(t);
  y = -50+0.001*sin(t);
  plus3=[1,0,0];
  plus2=[202,0,32]/256;
  plus1=[244,165,130]/256;
  zero=[247,247,247]/256;
  neg1=[146,197,222]/256;
  neg2=[5,113,176]/256;
  neg3=[0,0,1];
  patch(x,y,plus3);
  patch(x,y,plus2);
  patch(x,y,plus1);
  patch(x,y,zero);
  patch(x,y,neg1);
  patch(x,y,neg2);
  patch(x,y,neg3);
  patch(50,-50,'w');
  patch(50,-50,'w');
  hleg=legend('charge>2','charge=2','charge=1','charge=0','charge=-1','charge=-2','charge<-2','Big 4 island vertex','Small 3 island vertex',-1);
  %set(hleg,'position',[0.3 0.3 0.2 0.05]);
end
function circle(x0,y0,shapefactor,charge)
  a=10*shapefactor; t = linspace(0,2*pi);
  x = x0 + a*cos(t);
  y = y0 + a*sin(t);
  plus3=[1,0,0];
  plus2=[202,0,32]/256;
  plus1=[244,165,130]/256;
  zero=[247,247,247]/256;
  neg1=[146,197,222]/256;
  neg2=[5,113,176]/256;
  neg3=[0,0,1];
  if(charge>=3)
      patch(x,y,plus3);
  elseif(charge==2)
      patch(x,y,plus2);
  elseif(charge==1)
      patch(x,y,plus1);
  elseif(charge==0)
      patch(x,y,zero);
  elseif(charge==-1)
      patch(x,y,neg1);
  elseif(charge==-2)
      patch(x,y,neg2);
  elseif(charge<=-3)
      patch(x,y,neg3);
  end
end
