function x_out=ATCG_detect(x_in)
    %x_out=zeros(1,length(x_in(:,1)));
    %num=[0,1,2,3];
    %vecpoints={"[0;0;sqrt(6)/4]","[sqrt(3)/3;0;-sqrt(6)/12]","[-sqrt(3)/6;1/2;-sqrt(6)/12]","[-sqrt(3)/6;-1/2;-sqrt(6)/12]"};
    %vec_inv=containers.Map(vecpoints,num);
    
    vec_ATCG=[0,sqrt(3)/3,-sqrt(3)/6,-sqrt(3/6);0,0,1/2,-1/2;sqrt(6)/4,-sqrt(6)/12,-sqrt(6)/12,-sqrt(6)/12].';
    closest=knnsearch(vec_ATCG,x_in,'K',1);
    x_out=(closest-1).';
    
    
end