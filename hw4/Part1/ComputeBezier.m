function [out]=ComputeBezier(ctrlPointList,N, LoD,c)
   for i=1:3:N
        for t=0:LoD:1
            p1=i;
            p2=i+1;
            p3=i+2;
            p4=i+3;
            if(p1>N) 
                p1=rem(p1,N);
            end
            if(p2>N) 
                p2=rem(p2,N);
            end
            if(p3>N) 
                p3=rem(p3,N);
            end
            if(p4>N) 
                p4=rem(p4,N);
            end    
            temp(c,1)=(1-t)^3*ctrlPointList(p1,1)+3*t*(1-t)^2*ctrlPointList(p2,1)
                      +3*t^2*(1-t)*ctrlPointList(p3,1)+t^3*ctrlPointList(p4,1);
            temp(c,2)=(1-t)^3*ctrlPointList(p1,2)+3*t*(1-t)^2*ctrlPointList(p2,2)
                      0+3*t^2*(1-t)*ctrlPointList(p3,2)+t^3*ctrlPointList(p4,2);     
            c=c+1;
        end
    end
    out = temp;
end
                    
    
    
    
    

   