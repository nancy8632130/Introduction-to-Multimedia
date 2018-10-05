function [fsad,fi,fj]= endFind(Target,Reference,N,i,j,findi,findj,n)
     fsad=0;
     s=size(Target);
     fi=findi;
     fj=findj;
     %左上
     si=findi-n;
     sj=findj-n;
     ei=findi+n;
     ej=findj+n;
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
   if(si+N-1<s(1)+1 && sj+N-1<s(2)+1) 
     SAD_value_r1= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(si:si+N-1,sj:sj+N-1,1));
     SAD_value_g1= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(si:si+N-1,sj:sj+N-1,2));
     SAD_value_b1= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(si:si+N-1,sj:sj+N-1,3));
     SAD_value1=SAD_value_r1+SAD_value_g1+SAD_value_b1;
     if(fsad==0)
       fsad=SAD_value1;
       fi=si;
       fj=sj;
     else
       if(SAD_value1<fsad)
        fsad=SAD_value1;
        fi=si;
        fj=sj;
       end
     end
   end
     
     %上
   if(si+N-1<s(1)+1 && sj+N-1<s(2)+1) 
     SAD_value_r1= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(findi:findi+N-1,sj:sj+N-1,1));
     SAD_value_g1= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(findi:findi+N-1,sj:sj+N-1,2));
     SAD_value_b1= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(findi:findi+N-1,sj:sj+N-1,3));
     SAD_value1=SAD_value_r1+SAD_value_g1+SAD_value_b1;
     if(fsad==0)
       fsad=SAD_value1;
       fi=findi;
       fj=sj;
     else
       if(SAD_value1<fsad)
        fsad=SAD_value1;
        fi=findi;
        fj=sj;
       end
     end
   end
     
     %右上
   if(ei+N-1<s(1)+1 && sj+N-1<s(2)+1) 
     SAD_value_r1= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(ei:ei+N-1,sj:sj+N-1,1));
     SAD_value_g1= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(ei:ei+N-1,sj:sj+N-1,2));
     SAD_value_b1= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(ei:ei+N-1,sj:sj+N-1,3));
     SAD_value1=SAD_value_r1+SAD_value_g1+SAD_value_b1;
     if(fsad==0)
       fsad=SAD_value1;
       fi=ei;
       fj=sj;
     else
       if(SAD_value1<fsad)
        fsad=SAD_value1;
        fi=ei;
        fj=sj;
       end
     end
   end
     
     %左
   if(si+N-1<s(1)+1 && findj+N-1<s(2)+1) 
     SAD_value_r1= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(si:si+N-1,findj:findj+N-1,1));
     SAD_value_g1= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(si:si+N-1,findj:findj+N-1,2));
     SAD_value_b1= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(si:si+N-1,findj:findj+N-1,3));
     SAD_value1=SAD_value_r1+SAD_value_g1+SAD_value_b1;
     if(fsad==0)
       fsad=SAD_value1;
       fi=si;
       fj=findj;
     else
       if(SAD_value1<fsad)
        fsad=SAD_value1;
        fi=si;
        fj=findj;
       end
     end
   end
     
     %右
    if(ei+N-1<s(1)+1 && findj+N-1<s(2)+1) 
     SAD_value_r1= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(ei:ei+N-1,findj:findj+N-1,1));
     SAD_value_g1= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(ei:ei+N-1,findj:findj+N-1,2));
     SAD_value_b1= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(ei:ei+N-1,findj:findj+N-1,3));
     SAD_value1=SAD_value_r1+SAD_value_g1+SAD_value_b1;
     if(fsad==0)
       fsad=SAD_value1;
       fi=ei;
       fj=findj;
     else
       if(SAD_value1<fsad)
        fsad=SAD_value1;
        fi=ei;
        fj=findj;
       end
     end
    end
     
     %左下
   if(si+N-1<s(1)+1 && ej+N-1<s(2)+1) 
     SAD_value_r1= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(si:si+N-1,ej:ej+N-1,1));
     SAD_value_g1= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(si:si+N-1,ej:ej+N-1,2));
     SAD_value_b1= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(si:si+N-1,ej:ej+N-1,3));
     SAD_value1=SAD_value_r1+SAD_value_g1+SAD_value_b1;
     if(fsad==0)
       fsad=SAD_value1;
       fi=si;
       fj=ej;
     else
       if(SAD_value1<fsad)
        fsad=SAD_value1;
        fi=si;
        fj=ej;
       end
     end
   end
     
     %下
    if(findi+N-1<s(1)+1 && ej+N-1<s(2)+1) 
     SAD_value_r1= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(findi:findi+N-1,ej:ej+N-1,1));
     SAD_value_g1= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(findi:findi+N-1,ej:ej+N-1,2));
     SAD_value_b1= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(findi:findi+N-1,ej:ej+N-1,3));
     SAD_value1=SAD_value_r1+SAD_value_g1+SAD_value_b1;
     if(fsad==0)
       fsad=SAD_value1;
       fi=findi;
       fj=ej;
     else
       if(SAD_value1<fsad)
        fsad=SAD_value1;
        fi=findi;
        fj=ej;
       end
     end
    end
     
     %右下
   if(ei+N-1<s(1)+1 && ej+N-1<s(2)+1) 
     SAD_value_r1= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(ei:ei+N-1,ej:ej+N-1,1));
     SAD_value_g1= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(ei:ei+N-1,ej:ej+N-1,2));
     SAD_value_b1= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(ei:ei+N-1,ej:ej+N-1,3));
     SAD_value1=SAD_value_r1+SAD_value_g1+SAD_value_b1;
     if(fsad==0)
       fsad=SAD_value1;
       fi=ei;
       fj=ej;
     else
       if(SAD_value1<fsad)
        fsad=SAD_value1;
        fi=ei;
        fj=ej;
       end
     end
   end
     
     %中
   if(findi+N-1<s(1)+1 && findj+N-1<s(2)+1) 
     SAD_value_r1= SAD(Target(i:i+N-1,j:j+N-1,1),Reference(findi:findi+N-1,findj:findj+N-1,1));
     SAD_value_g1= SAD(Target(i:i+N-1,j:j+N-1,2),Reference(findi:findi+N-1,findj:findj+N-1,2));
     SAD_value_b1= SAD(Target(i:i+N-1,j:j+N-1,3),Reference(findi:findi+N-1,findj:findj+N-1,3));
     SAD_value1=SAD_value_r1+SAD_value_g1+SAD_value_b1;
     if(fsad==0)
       fsad=SAD_value1;
       fi=findi;
       fj=findj;
     else
       if(SAD_value1<fsad)
        fsad=SAD_value1;
        fi=findi;
        fj=findj;
       end
     end
   end
end
   