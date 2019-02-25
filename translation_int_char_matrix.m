function character=translation_int_char_matrix(integer)
    character=char(zeros(length(integer(:,1)),length(integer(1,:))));
    for i=1:length(integer(:,1))
        character(i,:)=translation_int_char_vec(integer(i,:));
    end
end