function x_out=align_sequence(x_in,x_ref)
    shift=1;
    shift_diff=sum(x_ref~=circshift(x_in,shift));
    for i=2:length(x_ref)
        if shift_diff>sum(x_ref~=circshift(x_in,i))
            shift=i;
            shift_diff=sum(x_ref~=circshift(x_in,shift));
        end
    end

    x_out=circshift(x_in,shift);
end