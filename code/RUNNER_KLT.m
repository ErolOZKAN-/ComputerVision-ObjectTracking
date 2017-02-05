clear all;
close all;

readerobj = VideoReader('daria_walk.avi'); 
numFrames = get(readerobj,'numberOfFrames');
    
[m,n] = size(rgb2gray(read(readerobj,1)));
f  = numFrames
rects = zeros(f-1,4);

frames_to_print = [1, 10, 30, 50, 80];

current_rect = [160, 45, 180, 120];
width = abs(current_rect(1)-current_rect(3));
height = abs(current_rect(2)-current_rect(4));

for i=1:numFrames-1
    img = rgb2gray(read(readerobj,i));
    img_next =rgb2gray( read(readerobj,i+1));
    
    imshow(img);
    hold on;
    rectangle('Position',[current_rect(1),current_rect(2),width,height], 'LineWidth',3, 'EdgeColor', 'y');
    hold off;
    pause(0.1);
    
    if any(i==frames_to_print)
        saveas(gcf,sprintf('Frame%d.jpg', i));
    end
    
    [u,v] = LucasKanade(img,img_next,current_rect);
	if current_rect(1)+u >= 1 && current_rect(1)+u <= n && ...
        current_rect(2)+v >= 1 && current_rect(2)+v <= m && ...
        current_rect(3)+u >= 1 && current_rect(3)+u <= n && ...
        current_rect(4)+v >= 1 && current_rect(4)+v <= m
        current_rect = round([current_rect(1)+u current_rect(2)+v current_rect(3)+u current_rect(4)+v]);
        rects(i,:) = current_rect;
    end
end


