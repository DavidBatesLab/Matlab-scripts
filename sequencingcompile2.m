function [ raw binned ] = Sequencingcompile2
%Compile and export sequencing data
%Combines multiple sequencing data sets, including only raw read mean
%coordinates.  Bins the data and exports to Excel.  



names=evalin('base','who');%evalin reads variable names
                            %from workspace
                           
%This part finds the length of the sample with most reads and makes
for t=1:length(names) 
    name=names{t};
    data=evalin('base',name);
    data(data(:,3)>1000,:)=[];%Exclude reads that are too big
    data(data(:,3)<-1000,:)=[];%too big right to left
    if t==1
        longest=length(data);
    else
        test=length(data); %make 'longest' the length of
        if longest<test    %the sample with most reads
            longest=test;
        end
    end
end

raw=zeros(longest,length(names));
for s=1:length(names) %for each sample...
    name=names{s};
    data=evalin('base',name);
    data(data(:,3)>1000,:)=[]; %throw out too-long reads
    data(data(:,3)<-1000,:)=[];
    raw(1:length(data),s)=data(:,4); %extract midpoint info
end
raw(raw==0)=NaN;
%raw is a 'longest' x 24 array with midpoints for each read

binsize=1000;%Change bin size
%make histograms
lowbin=ceil(min(min(raw))/binsize)*binsize;
highbin=floor(max(max(raw))/binsize)*binsize;
%figures out bins for the greatest neg and pos midpoint
numbins=(floor(max(max(raw))/binsize)-ceil(min(min(raw))/binsize))+1;
%numbins=highbin/binsize-lowbin/binsize+1
bins=linspace(lowbin, highbin, numbins)';
%makes evenly spaced bins

[~,n]=size(raw);
for s=1:n
    histtable(:,s)=hist(raw(:,s),bins); %actually does binning
end


header{1,1}=' ';
numsamples=length(names)+1;
header(1,2:numsamples)=names; %sample ID header
data2=[bins histtable];

%to catenate header with data2, have to convert to cell (data3)
for s=1:numsamples
    for t=1:numbins-1 %last bin is a half-bin to remove
        data3{t,s}=data2(t,s);
    end
end
binned=[header; data3];

xlswrite('compiledsequencing.xls',binned)%export to excel