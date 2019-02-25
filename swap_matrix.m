function dna_out=swap_matrix(dna_in,p)
    dna_out=zeros(length(dna_in(:,1)),length(dna_in(1,:)));
    for i=1:length(dna_in(:,1))
        dna_out(i,:)=swap_vec(dna_in(i,:),p);
    end
end