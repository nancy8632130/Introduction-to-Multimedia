original_picture=imread('cat1.png');
picture_double=im2double(original_picture);
s=size(original_picture);
im_R= picture_double(:,:,1);
im_G= picture_double(:,:,2);
im_B= picture_double(:,:,3);
t=[0.299 0.587 0.114;0.596 -0.275 -0.321;0.212 -0.523 0.311];
I=[1 0.956 0.620;1 -0.272 -0.647;1 -1.108 1.705];
Y_Y=zeros(8,8);
Y_I=zeros(8,8);
Y_Q=zeros(8,8);
%n=8
for i=1:s(1)
     for j=1:s(2)
       if rem(i,8)==1 && rem(j,8)==1
         for a=0:7
            for b=0:7
              yiq(1:3)=t*[im_R(i+a,j+b);im_G(i+a,j+b);im_B(i+a,j+b)];
              Y_Y(a+1,b+1)=yiq(1);
              Y_I(a+1,b+1)=yiq(2);
              Y_Q(a+1,b+1)=yiq(3); 
              end
            end
            for a=0:7
              for b=0:7
                   if a==0
                   c=sqrt(1/8);
                   else
                   c=sqrt(2/8);
                   end
                   A(a+1,b+1)=c*cos(pi*(b+0.5)*a/8);
               end
            end
            Y_R(i:i+7,j:j+7)=A*Y_Y*A';
            Y_G(i:i+7,j:j+7)=A*Y_I*A';
            Y_B(i:i+7,j:j+7)=A*Y_Q*A';
            YI_R(i:i+7,j:j+7)=A'*Y_R(i:i+7,j:j+7)*A;
            YI_G(i:i+7,j:j+7)=A'*Y_G(i:i+7,j:j+7)*A;
            YI_B(i:i+7,j:j+7)=A'*Y_B(i:i+7,j:j+7)*A;
            for a1=0:7
              for b1=0:7
               rgb(1:3)=I*[YI_R(a1+i,b1+j);YI_G(a1+i,b1+j);YI_B(a1+i,b1+j)];
               R_R(i+a1,j+b1)=rgb(1);
               R_G(i+a1,j+b1)=rgb(2);
               R_B(i+a1,j+b1)=rgb(3);    
             end
          end
         end
       end
     end
result_N8=cat(3,R_R,R_G,R_B);
%n=4
for i=1:s(1)
     for j=1:s(2)
       if rem(i,8)==1 && rem(j,8)==1
         for a=0:7
            for b=0:7
              yiq(1:3)=t*[im_R(i+a,j+b);im_G(i+a,j+b);im_B(i+a,j+b)];
              Y_Y(a+1,b+1)=yiq(1);
              Y_I(a+1,b+1)=yiq(2);
              Y_Q(a+1,b+1)=yiq(3); 
              end
            end
            for a=0:7
              for b=0:7
                   if a==0
                   c=sqrt(1/8);
                   else
                   c=sqrt(2/8);
                   end
                   A(a+1,b+1)=c*cos(pi*(b+0.5)*a/8);
               end
            end
            Y_R(i:i+7,j:j+7)=A*Y_Y*A';
            Y_G(i:i+7,j:j+7)=A*Y_I*A';
            Y_B(i:i+7,j:j+7)=A*Y_Q*A';
            Y_R(i:i+3,j+4:j+7)=0;
            Y_G(i:i+3,j+4:j+7)=0;
            Y_B(i:i+3,j+4:j+7)=0;
            Y_R(i+4:i+7,j:j+3)=0;
            Y_G(i+4:i+7,j:j+3)=0;
            Y_B(i+4:i+7,j:j+3)=0;
            Y_R(i+4:i+7,j+4:j+7)=0;
            Y_G(i+4:i+7,j+4:j+7)=0;
            Y_B(i+4:i+7,j+4:j+7)=0;
            YI_R(i:i+7,j:j+7)=A'*Y_R(i:i+7,j:j+7)*A;
            YI_G(i:i+7,j:j+7)=A'*Y_G(i:i+7,j:j+7)*A;
            YI_B(i:i+7,j:j+7)=A'*Y_B(i:i+7,j:j+7)*A;
            for a1=0:7
              for b1=0:7
               rgb(1:3)=I*[YI_R(a1+i,b1+j);YI_G(a1+i,b1+j);YI_B(a1+i,b1+j)];
               R_R(i+a1,j+b1)=rgb(1);
               R_G(i+a1,j+b1)=rgb(2);
               R_B(i+a1,j+b1)=rgb(3);    
              end
            end
         end
       end
     end
result_N4=cat(3,R_R,R_G,R_B);
%n=2
for i=1:s(1)
     for j=1:s(2)
       if rem(i,8)==1 && rem(j,8)==1
         for a=0:7
            for b=0:7
              yiq(1:3)=t*[im_R(i+a,j+b);im_G(i+a,j+b);im_B(i+a,j+b)];
              Y_Y(a+1,b+1)=yiq(1);
              Y_I(a+1,b+1)=yiq(2);
              Y_Q(a+1,b+1)=yiq(3); 
              end
            end
            for a=0:7
              for b=0:7
                   if a==0
                   c=sqrt(1/8);
                   else
                   c=sqrt(2/8);
                   end
                   A(a+1,b+1)=c*cos(pi*(b+0.5)*a/8);
               end
            end
            Y_R(i:i+7,j:j+7)=A*Y_Y*A';
            Y_G(i:i+7,j:j+7)=A*Y_I*A';
            Y_B(i:i+7,j:j+7)=A*Y_Q*A';
            Y_R(i:i+1,j+2:j+7)=0;
            Y_G(i:i+1,j+2:j+7)=0;
            Y_B(i:i+1,j+2:j+7)=0;
            Y_R(i+2:i+7,j:j+1)=0;
            Y_G(i+2:i+7,j:j+1)=0;
            Y_B(i+2:i+7,j:j+1)=0;
            Y_R(i+2:i+7,j+2:j+7)=0;
            Y_G(i+2:i+7,j+2:j+7)=0;
            Y_B(i+2:i+7,j+2:j+7)=0;
            YI_R(i:i+7,j:j+7)=A'*Y_R(i:i+7,j:j+7)*A;
            YI_G(i:i+7,j:j+7)=A'*Y_G(i:i+7,j:j+7)*A;
            YI_B(i:i+7,j:j+7)=A'*Y_B(i:i+7,j:j+7)*A;
            for a1=0:7
              for b1=0:7
               rgb(1:3)=I*[YI_R(a1+i,b1+j);YI_G(a1+i,b1+j);YI_B(a1+i,b1+j)];
               R_R(i+a1,j+b1)=rgb(1);
               R_G(i+a1,j+b1)=rgb(2);
               R_B(i+a1,j+b1)=rgb(3);    
              end
            end
         end
     end
  end
result_N2=cat(3,R_R,R_G,R_B);
%display
result_uint_N8=im2uint8(result_N8);
result_uint_N4=im2uint8(result_N4);
result_uint_N2=im2uint8(result_N2);
subplot(2,2,1),imshow(original_picture);
subplot(2,2,2),imshow(result_uint_N8);
subplot(2,2,3),imshow(result_uint_N4);
subplot(2,2,4),imshow(result_uint_N2);
%PSNR:n=8
mseR=(double(original_picture(:,:,1))-double(result_uint_N8(:,:,1))).^2;
mseG=(double(original_picture(:,:,2))-double(result_uint_N8(:,:,2))).^2;
mseB=(double(original_picture(:,:,3))-double(result_uint_N8(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_N8=10*log10(255^2/mse);
P_N8=psnr(original_picture,result_uint_N8);
%PSNR:n=4
mseR=(double(original_picture(:,:,1))-double(result_uint_N4(:,:,1))).^2;
mseG=(double(original_picture(:,:,2))-double(result_uint_N4(:,:,2))).^2;
mseB=(double(original_picture(:,:,3))-double(result_uint_N4(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_N4=10*log10(255^2/mse);
P_N4=psnr(original_picture,result_uint_N4);
%PSNR:n=2
mseR=(double(original_picture(:,:,1))-double(result_uint_N2(:,:,1))).^2;
mseG=(double(original_picture(:,:,2))-double(result_uint_N2(:,:,2))).^2;
mseB=(double(original_picture(:,:,3))-double(result_uint_N2(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2));
mG=sum(sum(mseG))/(s(1)*s(2));
mB=sum(sum(mseB))/(s(1)*s(2));
mse=(mR+mG+mB)/3;
PSNR_N2=10*log10(255^2/mse);
P_N2=psnr(original_picture,result_uint_N2);