function sampleseq=randsequentialsample(sequence,sampleLength)
    totalLength=length(sequence);
    sampleseqstart=randi(totalLength);
    sampleseq=zeros(1,sampleLength);
    
    if sampleseqstart<=(totalLength-sampleLength+1)
       sampleseq=sequence(sampleseqstart:sampleseqstart+sampleLength-1);
    else
        sampleseq(1:totalLength-sampleseqstart+1)=sequence(sampleseqstart:totalLength);
        sampleseq(totalLength-sampleseqstart+2:sampleLength)=sequence(1:sampleLength-totalLength+sampleseqstart-1);
    end
end