function character=translation_int_char(integer)
    num=[0,1,2,3];
    dna={'A','T','C','G'};
    M=containers.Map(num,dna);
    character=M(integer);
end