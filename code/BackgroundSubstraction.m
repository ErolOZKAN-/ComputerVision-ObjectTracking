function result= BackgroundSubstraction(realImage, backgroundImage)
    Background=backgroundImage;
    CurrentFrame=realImage;

    [Background_hsv]=round(rgb2hsv(Background));
    [CurrentFrame_hsv]=round(rgb2hsv(CurrentFrame));
    Out = (Background_hsv - CurrentFrame_hsv);
    Out=rgb2gray(Out);
    [rows columns]=size(Out);
    for i=1:rows
        for j=1:columns
            if Out(i,j) >0.11402005
                BinaryImage(i,j)=1;
            else
                BinaryImage(i,j)=0;
            end
        end
    end
    FilteredImage=medfilt2(BinaryImage,[5 5]);
    [L num]=bwlabel(FilteredImage);
    STATS=regionprops(L,'all');
    cc=[];
    removed=0;

    for i=1:num
        dd=STATS(i).Area;
        if (dd < 500)
            L(L==i)=0;
            removed = removed + 1;
            num=num-1;
        end
    end
    [L2 num2]=bwlabel(L);
    [B,L,N,A] = bwboundaries(L2);
    imshow(L2);
