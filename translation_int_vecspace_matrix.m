function vecspace=translation_int_vecspace_matrix(integer)
    vecspace=zeros(3*length(integer(:,1)),length(integer(1,:)));
    for i=1:length(integer(:,1))
        vecspace(3*(i-1)+1:3*i,:)=translation_int_vecspace_vec(integer(i,:));
    end
end