function [image,MV]= twoD_logarithmic_search(N,p,Target,Reference)
%Reference=imread('data/frame437.jpg');
%Target=imread('data/frame439.jpg');
%N=8;
%p=8;

s=size(Target);
MV=zeros(s(1)/N,s(1)/N,2);

 for i=1:s(1)
      for j=1:s(2)
          fsad=0;
          findi=i;
          findj=j;
           n_temp=floor(log2(p));
           n=max(2,2^(n_temp-1));
          if (rem(i,N)==1 && rem(j,N)==1)          
            si=i-n;
            sj=j-n;
            ei=i+n;
            ej=j+n;
            ci=findi;
            cj=findj;
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
            
             while(1)
               if(si+N-1<s(1)+1 && cj+N-1<s(2)+1)
                SAD_value_l_r= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(si:si+N-1,cj:cj+N-1,1));
                SAD_value_l_g= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(si:si+N-1,cj:cj+N-1,2));
                SAD_value_l_b= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(si:si+N-1,cj:cj+N-1,3));
            	SAD_value_l = SAD_value_l_r+SAD_value_l_g+SAD_value_l_b;
                if(fsad==0)
                    fsad=SAD_value_l;
                    findi=si;
                    findj=cj;
                else
                  if(SAD_value_l<=fsad)
                    fsad=SAD_value_l;
                    findi=si;
                    findj=cj;
                  end
                end
               end% end of if(si+N-1<s(1)+1 && cj+N-1<s(2)+1)
               if(ei+N-1<s(1)+1 && cj+N-1<s(2)+1)      
                SAD_value_r_r= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(ei:ei+N-1,cj:cj+N-1,1));
                SAD_value_r_g= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(ei:ei+N-1,cj:cj+N-1,2));
                SAD_value_r_b= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(ei:ei+N-1,cj:cj+N-1,3));
            	SAD_value_r=SAD_value_r_r+SAD_value_r_g+SAD_value_r_b;
                if(fsad==0)
                    fsad=SAD_value_r;
                    findi=ei;
                    findj=cj;
                else
                  if(SAD_value_r<=fsad)
                    fsad=SAD_value_r;
                    findi=ei;
                    findj=cj;
                  end
                end
               end %end of if(ei+N-1<s(1)+1 && cj+N-1<s(2)+1)   
               
               if(ci+N-1<s(1)+1 && sj+N-1<s(2)+1)   
                SAD_value_u_r= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(ci:ci+N-1,sj:sj+N-1,1));
                SAD_value_u_g= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(ci:ci+N-1,sj:sj+N-1,2));
                SAD_value_u_b= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(ci:ci+N-1,sj:sj+N-1,3));
            	SAD_value_u=SAD_value_u_r+SAD_value_u_g+SAD_value_u_b;
                if(fsad==0)
                    fsad=SAD_value_u;
                    findi=ci;
                    findj=sj;
                else
                  if(SAD_value_u<=fsad)
                    fsad=SAD_value_u;
                    findi=ci;
                    findj=sj;
                  end
                end
               end %end of if(ci+N-1<s(1)+1 && sj+N-1<s(2)+1) 
               
               if(ci+N-1<s(1)+1 && ej+N-1<s(2)+1) 
                SAD_value_d_r= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(ci:ci+N-1,ej:ej+N-1,1));
                SAD_value_d_g= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(ci:ci+N-1,ej:ej+N-1,2));
                SAD_value_d_b= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(ci:ci+N-1,ej:ej+N-1,3));
            	SAD_value_d=SAD_value_d_r+SAD_value_d_g+SAD_value_d_b;
                if(fsad==0)
                    fsad=SAD_value_d;
                    findi=ci;
                    findj=ej;
                else
                  if(SAD_value_d<=fsad)
                    fsad=SAD_value_d;
                    findi=ci;
                    findj=ej;
                  end
                end
               end %end of if(ci+N-1<s(1)+1 && ej+N-1<s(2)+1) 
               
               if(ci+N-1<s(1)+1 && cj+N-1<s(2)+1) 
                SAD_value_r= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(ci:ci+N-1,cj:cj+N-1,1));
                SAD_value_g= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(ci:ci+N-1,cj:cj+N-1,2));
                SAD_value_b= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(ci:ci+N-1,cj:cj+N-1,3));
            	SAD_value=SAD_value_r+SAD_value_g+SAD_value_b;
                if(fsad==0)
                    fsad=SAD_value;
                    findi=ci;
                    findj=cj;
                    n=floor(n/2);
                     if(n==1)
                         [fsad,findi,findj]=endFind(Target,Reference,N,i,j,ci,cj,n);
                         break;
                     end
                     
                     si=findi-n;
                     sj=findj-n;
                     ei=findi+n;
                     ej=findj+n;
                     ci=findi;
                     cj=findj;
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
                else
                  if(SAD_value<=fsad)
                     fsad=SAD_value;
                     findi=ci;
                     findj=cj;
                     n=floor(n/2);
                     if(n==1)
                         [fsad,findi,findj]=endFind(Target,Reference,N,i,j,ci,cj,n);
                         break;
                     end
                     
                     si=findi-n;
                     sj=findj-n;
                     ei=findi+n;
                     ej=findj+n;
                     ci=findi;
                     cj=findj;
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
                  else
                      si=findi-n;
                      sj=findj-n;
                      ei=findi+n;
                      ej=findj+n;
                      ci=findi;
                      cj=findj;
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
                  end %end of else
                end %end of else  
               else %end of if(ci+N-1<s(1)+1 && cj+N-1<s(2)+1) 
                   if(ci==findi ||cj==findj)
                       break;
                   else
                       si=findi-n;
                       sj=findj-n;
                       ei=findi+n;
                       ej=findj+n;
                       ci=findi;
                       cj=findj;
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
                   end
               end                 
                        
             end %end of while
             MV(floor(i/N)+1,floor(j/N)+1,1)=findi-i;
             MV(floor(i/N)+1,floor(j/N)+1,2)=findj-j;
             image(i:i+N-1,j:j+N-1,1)=Reference(findi:findi+N-1,findj:findj+N-1,1);
             image(i:i+N-1,j:j+N-1,2)=Reference(findi:findi+N-1,findj:findj+N-1,2);
             image(i:i+N-1,j:j+N-1,3)=Reference(findi:findi+N-1,findj:findj+N-1,3);
           end  %end of rem(i,N)==1 && rem(j,N)==1
      end %end if for s(2)
 end %end if for s(1)