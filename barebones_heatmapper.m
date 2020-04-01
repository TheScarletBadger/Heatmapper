clear all
%Edit this part------------------------------------------------------------
source = 'C:\Users\Barry\Desktop\input';
nbin = 50;
%--------------------------------------------------------------------------

%list contents of source directory
D = dir(source);
%remove entries for working and parent directories
D = D(~ismember({D.name},{'.','..'}));
%initialize empty array
carray = [];
%iterate over files in source directory, append x-y pairs to carray
for i = 1:length(D)
    carray = vertcat(carray,csvread([source filesep D(i).name],2,0));
end
%remove extraneous data and NAN
carray = carray(sum(isnan(carray),2)==0,2:3);
%remove 0,0 pairs (tracking lost)
carray = carray(sum(carray,2)~=0,:);
%convert to nbins by nbins array of n x-y pairs inside each bin
zarray = hist3(carray,'nbins',[nbin nbin]);
%display as surface with default colormap and intepolated edge / face color
surf(zarray,'FaceColor','interp', 'EdgeColor', 'interp')
colormap('jet');
axis equal
axis off
view(2)
