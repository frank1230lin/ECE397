% Translate row vector
function character=translation_int_char_vec(integer)
    L=length(integer);
    character=char(zeros(1,L));
    for i=1:L
        character(1,i)=translation_int_char(integer(1,i));
    end
end