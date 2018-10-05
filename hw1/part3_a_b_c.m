original_picture=imread('cat3_LR.png');
HR=imread('cat3_HR.png');
s=size(original_picture);
picture_double=im2double(original_picture);
%nearest-neighbor interpolation
for i=1:s(1)*4
     for j=1:s(2)*4
        x=round(i/4);
        y=round(j/4);
        if x==0 x=1;
        end
        if y==0 y=1;
        end
        result_neighbor(i,j,1)=picture_double(x,y,1);
        result_neighbor(i,j,2)=picture_double(x,y,2);
        result_neighbor(i,j,3)=picture_double(x,y,3);
      end
end
%bilinear interpolation
for i=1:s(1)*4
     for j=1:s(2)*4
        r=i/4;
        c=j/4;
        rf=floor(r);
        cf=floor(c);
        if(rf<1) rf=1;
        end
        if(cf<1) cf=1;
        end
        if(rf>249) rf=249;
        end
        if(cf>375) cf=375;
        end
        deltaR=r-rf;
        deltaC=c-cf;
        result_bilinear(i,j,1)=picture_double(rf,cf,1)*(1-deltaR)*(1-deltaC)+picture_double(rf+1,cf,1)*(deltaR)*(1-deltaC)+picture_double(rf,cf+1,1)*(1-deltaR)*(deltaC)+picture_double(rf+1,cf+1,1)*(deltaR)*(deltaC);
        result_bilinear(i,j,2)=picture_double(rf,cf,2)*(1-deltaR)*(1-deltaC)+picture_double(rf+1,cf,2)*(deltaR)*(1-deltaC)+picture_double(rf,cf+1,2)*(1-deltaR)*(deltaC)+picture_double(rf+1,cf+1,2)*(deltaR)*(deltaC);
        result_bilinear(i,j,3)=picture_double(rf,cf,3)*(1-deltaR)*(1-deltaC)+picture_double(rf+1,cf,3)*(deltaR)*(1-deltaC)+picture_double(rf,cf+1,3)*(1-deltaR)*(deltaC)+picture_double(rf+1,cf+1,3)*(deltaR)*(deltaC);
      end
end
%bicubic interpolation
image_R=picture_double(:,:,1);
image_G=picture_double(:,:,2);
image_B=picture_double(:,:,3);
result_r=zeros(s(1)*4,s(2)*4);
result_g=zeros(s(1)*4,s(2)*4);
result_b=zeros(s(1)*4,s(2)*4);
for i=1:s(1)*4
    for j=1:s(2)*4
        x=i/4;
        y=j/4;
        rf=floor(x);
        cf=floor(y);
        u=x-rf;
        v=y-cf;
        gtm=4-8*abs(u+1)+5*abs(u+1)^2-abs(u+1).^3;
        gtm2=4-8*abs(u-2)+5*abs(u-2)^2-abs(u-2).^3;
        gun=4-8*abs(v+1)+5*abs(v+1)^2-abs(v+1).^3;
        gun2=4-8*abs(v-2)+5*abs(v-2)^2-abs(v-2).^3;
        ftm=1-2*abs(u)^2+abs(u)^3;
        ftm2=1-2*abs(u-1)^2+abs(u-1)^3;
        fun=1-2*abs(v)^2+abs(v)^3;
        fun2=1-2*abs(v-1)^2+abs(v-1)^3;
        xi = max(1,rf-1); 
        xx = max(1,rf); 
        xa = min(250,rf+1); 
        xaa = min(250,rf+2);
        yi = max(1,cf-1); 
        yy = max(1,cf); 
        ya = min(376,cf+1); 
        yaa = min(376,cf+2);
        result_r(i,j)=image_R(xi,yi)*gtm*gun+image_R(xi,yy)*gtm*fun+image_R(xi,ya)*gtm*fun2+image_R(xi,yaa)*gtm*gun2+image_R(xx,yi)*ftm*gun+image_R(xx,yy)*ftm*fun+image_R(xx,ya)*ftm*fun2+image_R(xx,yaa)*ftm*gun2+image_R(xa,yi)*ftm2*gun+image_R(xa,yy)*ftm2*fun+image_R(xa,ya)*ftm2*fun2+image_R(xa,yaa)*ftm2*gun2+image_R(xaa,yi)*gtm2*gun+image_R(xaa,yy)*gtm2*fun+image_R(xaa,ya)*gtm2*fun2+image_R(xaa,yaa)*gtm2*gun2;
        result_g(i,j)=image_G(xi,yi)*gtm*gun+image_G(xi,yy)*gtm*fun+image_G(xi,ya)*gtm*fun2+image_G(xi,yaa)*gtm*gun2+image_G(xx,yi)*ftm*gun+image_G(xx,yy)*ftm*fun+image_G(xx,ya)*ftm*fun2+image_G(xx,yaa)*ftm*gun2+image_G(xa,yi)*ftm2*gun+image_G(xa,yy)*ftm2*fun+image_G(xa,ya)*ftm2*fun2+image_G(xa,yaa)*ftm2*gun2+image_G(xaa,yi)*gtm2*gun+image_G(xaa,yy)*gtm2*fun+image_G(xaa,ya)*gtm2*fun2+image_G(xaa,yaa)*gtm2*gun2;
        result_b(i,j)=image_B(xi,yi)*gtm*gun+image_B(xi,yy)*gtm*fun+image_B(xi,ya)*gtm*fun2+image_B(xi,yaa)*gtm*gun2+image_B(xx,yi)*ftm*gun+image_B(xx,yy)*ftm*fun+image_B(xx,ya)*ftm*fun2+image_B(xx,yaa)*ftm*gun2+image_B(xa,yi)*ftm2*gun+image_B(xa,yy)*ftm2*fun+image_B(xa,ya)*ftm2*fun2+image_B(xa,yaa)*ftm2*gun2+image_B(xaa,yi)*gtm2*gun+image_B(xaa,yy)*gtm2*fun+image_B(xaa,ya)*gtm2*fun2+image_B(xaa,yaa)*gtm2*gun2;            
    end
end
result_bicubic= cat(3,result_r,result_g,result_b);
%display
result_neighbor_uint=im2uint8(result_neighbor);
result_bilinear_uint=im2uint8(result_bilinear );
result_bicubic_uint=im2uint8(result_bicubic);
subplot(2,2,1),imshow(original_picture);
subplot(2,2,2),imshow(result_neighbor_uint);
subplot(2,2,3),imshow(result_bilinear_uint);
subplot(2,2,4),imshow(result_bicubic_uint);
%PSNR:nearest-neighbor interpolation 
mseR=(double(HR(:,:,1))-double(result_neighbor_uint(:,:,1))).^2;
mseG=(double(HR(:,:,2))-double(result_neighbor_uint(:,:,2))).^2;
mseB=(double(HR(:,:,3))-double(result_neighbor_uint(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2)*16);
mG=sum(sum(mseG))/(s(1)*s(2)*16);
mB=sum(sum(mseB))/(s(1)*s(2)*16);
mse=(mR+mG+mB)/3;
PSNR_neighbor=10*log10(255^2/mse);
P_neighbor=psnr(HR,result_neighbor_uint);
%PSNR:bilinear interpolation
mseR=(double(HR(:,:,1))-double(result_bilinear_uint(:,:,1))).^2;
mseG=(double(HR(:,:,2))-double(result_bilinear_uint(:,:,2))).^2;
mseB=(double(HR(:,:,3))-double(result_bilinear_uint(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2)*16);
mG=sum(sum(mseG))/(s(1)*s(2)*16);
mB=sum(sum(mseB))/(s(1)*s(2)*16);
mse=(mR+mG+mB)/3;
PSNR_bilinear=10*log10(255^2/mse);
P_bilinear=psnr(HR,result_bilinear_uint);
%PSNR:bicubic interpolation
mseR=(double(HR(:,:,1))-double(result_bicubic_uint(:,:,1))).^2;
mseG=(double(HR(:,:,2))-double(result_bicubic_uint(:,:,2))).^2;
mseB=(double(HR(:,:,3))-double(result_bicubic_uint(:,:,3))).^2;
mR=sum(sum(mseR))/(s(1)*s(2)*16);
mG=sum(sum(mseG))/(s(1)*s(2)*16);
mB=sum(sum(mseB))/(s(1)*s(2)*16);
mse=(mR+mG+mB)/3;
PSNR_bicubic=10*log10(255^2/mse);
P_bicubic=psnr(HR,result_bicubic_uint);









