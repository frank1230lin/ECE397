function sampleseq=randsequentialsample(sequence,sampleLength,distribution)
    totalLength=length(sequence);
    seed=RandStream('mlfg6331_64');
    sampleseqstart=datasample(seed,1:totalLength,1,'Weights',distribution);
    %sampleseqstart=randi(totalLength);
    sampleseq=zeros(1,sampleLength);
    
    if sampleseqstart<=(totalLength-sampleLength+1)
       sampleseq=sequence(sampleseqstart:sampleseqstart+sampleLength-1);
    else
        sampleseq(1:totalLength-sampleseqstart+1)=sequence(sampleseqstart:totalLength);
        sampleseq(totalLength-sampleseqstart+2:sampleLength)=sequence(1:sampleLength-totalLength+sampleseqstart-1);
    end
end