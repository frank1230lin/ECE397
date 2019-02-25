function dna_out=swap_vec(dna_in,p)
    % dna_int: dna sequence in integer form
    % p: probability of remaining the same 
    
    
    dna_out=zeros(1,length(dna_in));
    for i=1:length(dna_in) 
        if rand<=p
            continue;
        else
            dna_out(1:i)=randi(4)-1;
        end
    end
end