function residual_image= generate_residual_image(Target,Reference)
   temp(:,:,1)=abs(Target(:,:,1)-Reference(:,:,1));
   temp(:,:,2)=abs(Target(:,:,1)-Reference(:,:,1));
   temp(:,:,3)=abs(Target(:,:,1)-Reference(:,:,1));
   residual_image=temp(:,:,1)+temp(:,:,2)+temp(:,:,3);
end