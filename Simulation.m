clc
clear all

% Entire sequence length
L=100;
% Segment length
s=20;
% Number of segments collected
s_num=15;
% Probability of remaining the same dna alphapet after swapping
p=1;

% Data structure to tranform dna characters to vector points
dna={'A','T','C','G'};
vecpoints={[0;0;sqrt(6)/4],[sqrt(3)/3;0;-sqrt(6)/12],[-sqrt(3)/6;1/2;-sqrt(6)/12],[-sqrt(3)/6;-1/2;-sqrt(6)/12]};
M=containers.Map(dna,vecpoints);

% Generating dna sequence using {0,1,2,3} as representation of {'A','T','C','G'}
sequence=randi([0,3],1,L);

sequence_dna=translation_int_char_vec(sequence);
disp(sequence_dna);

% Randomly sample obsevations
sample_sequence=zeros(s_num,s);
for i=1:s_num
    sample_sequence(i,:)=randsequentialsample(sequence,s);
end

% Translate the samples into dna format
sample_sequence_dna=translation_int_char_matrix(sample_sequence);
disp(sample_sequence_dna);

% Translate the samples into vector space format
sample_sequence_vecspace=translation_int_vecspace_matrix(sample_sequence);
disp(sample_sequence_vecspace);

% Estimate mean and covariance in vecspace format
[sample_mean,sample_cov1,sample_cov2,sample_cov3]=estimate_mean_cov(sample_sequence_vecspace);

% Introduce the "swap" pertrubation and estimate mean and covariance
swap_sample_sequence=swap_matrix(sample_sequence,p);
swap_sample_sequence_vecspace=translation_int_vecspace_matrix(swap_sample_sequence);
[swap_sample_mean,swap_sample_cov1,swap_sample_cov2,swap_sample_cov3]=estimate_mean_cov(swap_sample_sequence_vecspace);


