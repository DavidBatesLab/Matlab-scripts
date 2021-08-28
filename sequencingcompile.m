function [ data ] = sequencingcompile (name)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%May 10, 2018 coordinates refer to MiSeq Genome 000913.3

toadd=bamread(name,'MG1655',[1 4641652]);
data=zeros(length(toadd),4);
    for s=1:length(toadd)
        if toadd(s,1).InsertSize~=0
            origin=int32(toadd(s,1).Position);
            bases=int32(toadd(s,1).InsertSize);
                if bases<0
                    first=origin+bases;
                    last=origin;
                else
                    first=origin;
                    last=origin+bases;
                end

            %make ori-centric
            if first<=1590764 %right arm past '1' to dif # is for dif
                first=first+715777;
                last=last+715777;
            elseif first>=3925875 %right arm ori to '1' #for oriC
                first=first-3925875;
                last=last-3925875;
            else %left arm
                first=first-3925875;
                last=last-3925875;
            end
            data(s,1:4)=[first last bases round(mean([first last]))];
        end
    end
    data=sortrows(data,4);

    data(data(:,1)==0,:)=[];
    data=double(data);
beep
pause(3)
beep
end