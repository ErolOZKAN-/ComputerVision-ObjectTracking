clear all;
close all;

filein = 'daria_walk.avi';
numberOfImagesToCombine=30;
value = 0;
values = 0;

readerobj = VideoReader(filein); %,'tag','myreader');    
numFrames = get(readerobj,'numberOfFrames');  
   
    for i = (numberOfImagesToCombine+1):(numFrames-numberOfImagesToCombine)      
         im = uint32(read(readerobj,(i-numberOfImagesToCombine)));
         someImage = uint32(read(readerobj,i));
         
         for j = (i-numberOfImagesToCombine+1):(i+numberOfImagesToCombine)
             imToAdd = uint32(read(readerobj,j));
             im = imadd(im,imToAdd);
         end         
         
         im = im/(2*numberOfImagesToCombine+1);
         backgroundImage= uint8(im);
         pause(1)
         
         realImage=read(readerobj,(i-numberOfImagesToCombine));         
         BackgroundSubstraction(realImage, backgroundImage);
   end


