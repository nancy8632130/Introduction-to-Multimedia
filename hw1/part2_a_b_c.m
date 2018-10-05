O=imread('cat2_gray.png');
original_picture=imread('cat2_gray.png');
result_random=zeros(size(original_picture));
result_average=zeros(size(original_picture));
result_error=zeros(size(original_picture));
s=size(original_picture);
%noise(random) dithering

for i=1:s(1)
     for j=1:s(2)
       random=unidrnd(256);
       R=random-1;
       if original_picture(i,j)>R
           result_random(i,j)=1;
       else
           result_random(i,j)=0;
       end
      
     end
end
%average dithering
total=sum(original_picture(:));
average=total/(s(1)*s(2));
average_floor=floor(average);
for i=1:s(1)
     for j=1:s(2)
       if original_picture(i,j)>average_floor
           result_average(i,j)=1;
       else
           result_average(i,j)=0;
       end
      
     end
end
%error diffusion dithering
for i=1:s(1)
     for j=1:s(2)
       if original_picture(i,j)<128
           e=original_picture(i,j);
       else
           e=original_picture(i,j)-255;
       end
       if j<s(2)
           original_picture(i,j+1)=((7/16)*e)+original_picture(i,j+1);
       end
       if i<s(1) && j>1
           original_picture(i+1,j-1)=((3/16)*e)+original_picture(i+1,j-1);
       end
       if i<s(1) 
           original_picture(i+1,j)=((5/16)*e)+original_picture(i+1,j);
       end
       if i<s(1) && j<s(2)
           original_picture(i+1,j+1)=((1/16)*e)+original_picture(i+1,j+1);
       end
     end
end

for i=1:s(1)
     for j=1:s(2)
         if original_picture(i,j)<128
             result_error(i,j)=0;
         else
             result_error(i,j)=1;
         end
     end
end
%display
result_error_uint=im2uint8(result_error);
result_average_uint=im2uint8(result_average);
result_random_uint=im2uint8(result_random);
%subplot(2,2,1),imshow(O);
%subplot(2,2,2),imshow(result_random_uint);
%subplot(2,2,3),imshow(result_average_uint);
%subplot(2,2,4),imshow(result_error_uint);
imshow(result_random_uint);






