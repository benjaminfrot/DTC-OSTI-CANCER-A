function []=Play2Movies(filename1,filename2)

video1=aviread((filename1));
info1=aviinfo((filename1));

video2=aviread((filename2));
info2=aviinfo((filename2));

frames1=info1.NumFrames;
frames2=info2.NumFrames;
runTime=max(frames1,frames2);

scrsz = get(0,'ScreenSize');
f=figure('Position',[0 0 scrsz(3)/2 scrsz(4)/2]);
a1=axes('parent',f,'position',[0,0.1,0.6,0.6]);
a2=axes('parent',f,'position',[0.45,0.1,0.6,0.6]);
for i=1:runTime
    if i<=frames1
        imshow(video1(i).cdata,'parent',a1);
        drawnow
    end
    if i<=frames2
        imshow(video2(i).cdata,'parent',a2);
        drawnow
    end
    pause(0.5)
end