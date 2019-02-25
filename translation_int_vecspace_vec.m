function vecspace=translation_int_vecspace_vec(integer)
    vecspace=zeros(3,length(integer));
    for i=1:length(integer)
        vecspace(:,i)=translation_int_vecspace(integer(:,i));
    end
end