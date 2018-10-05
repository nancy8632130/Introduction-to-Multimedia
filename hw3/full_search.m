function [image,MV]= full_search(N,p,Target,Reference)
%Reference=imread('data/frame437.jpg');
%Target=imread('data/frame439.jpg');
%N=8;
%p=16;
s=size(Target);
MV=zeros(s(1)/N,s(1)/N,2);
 
  for i=1:s(1)
      for j=1:s(2)
          findi=0;
          findj=0;
          fsad=0;
          if (rem(i,N)==1 && rem(j,N)==1)
             si=i-p;
             sj=j-p;
             ei=i+p;
             ej=j+p;
             if(si<1) 
                 si=1;
             end
             if(sj<1) 
                 sj=1;
             end
             if(ei>s(1)) 
                 ei=s(1);
             end
             if(ej>s(2)) 
                 ej=s(2);
             end
             
             for k1=si:ei
                 for k2=sj:ej
                  if(k1+N-1<s(1)+1 && k2+N-1<s(2)+1)
                     SAD_value_r= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(k1:k1+N-1,k2:k2+N-1,1));
                     SAD_value_g= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(k1:k1+N-1,k2:k2+N-1,2));
                     SAD_value_b= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(k1:k1+N-1,k2:k2+N-1,3));
                     SAD_value=SAD_value_r+SAD_value_g+SAD_value_b;
                     
                     if(fsad==0)
                         fsad=SAD_value;
                         findi=k1;
                         findj=k2;
                     else
                         if(SAD_value<fsad)
                             fsad=SAD_value;
                             findi=k1;
                             findj=k2;
                         end
                     end %end of else
                    end%end of (k1+N<=s(1)&&k2+N<=s(2))
                  end %end of k2
                end   %end of k1
                MV(floor(i/N)+1,floor(j/N)+1,1)=findi-i;
                MV(floor(i/N)+1,floor(j/N)+1,2)=findj-j;
                image(i:i+N-1,j:j+N-1,1)=Reference(findi:findi+N-1,findj:findj+N-1,1);
                image(i:i+N-1,j:j+N-1,2)=Reference(findi:findi+N-1,findj:findj+N-1,2);
                image(i:i+N-1,j:j+N-1,3)=Reference(findi:findi+N-1,findj:findj+N-1,3);
          end  %end of rem(i,N)==1 && rem(j,N)==1
      end  %end of i=1:s(2)
  end  %end of i=1:s(1)
                     
                     
                         
                 
             
                   
                   
