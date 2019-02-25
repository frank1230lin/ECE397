function vecspace=translation_int_vecspace(integer)
    intrepresentation=[0,1,2,3];
    vecpoints={[0;0;sqrt(6)/4],[sqrt(3)/3;0;-sqrt(6)/12],[-sqrt(3)/6;1/2;-sqrt(6)/12],[-sqrt(3)/6;-1/2;-sqrt(6)/12]};
    M=containers.Map(intrepresentation,vecpoints);
    vecspace=M(integer);
end