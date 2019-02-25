function [sample_mean,sample_cov1,sample_cov2,sample_cov3]=estimate_mean_cov(sample_sequence_vecspace)
    % Calculate estimated mean (each dimension of vector space is independent)
    s_num=length(sample_sequence_vecspace(:,1))/3;
    s=length(sample_sequence_vecspace(1,:));
    
    temp_s_num=(1:3*s_num).';
    temp_s_num1=(mod(temp_s_num,3)==1);
    temp_s_num2=(mod(temp_s_num,3)==2);
    temp_s_num3=(mod(temp_s_num,3)==0);

    sample_mean=zeros(3,s);
    sample_mean(1,:)=sum(sample_sequence_vecspace(temp_s_num1,:))/s_num;
    sample_mean(2,:)=sum(sample_sequence_vecspace(temp_s_num2,:))/s_num;
    sample_mean(3,:)=sum(sample_sequence_vecspace(temp_s_num3,:))/s_num;

    % Calculate estimated covariance (no cross dimension correlation)
    sample_cov_temp1_1=sample_sequence_vecspace(temp_s_num1,:).';
    sample_cov_temp1_2=sample_sequence_vecspace(temp_s_num1,:);
    sample_cov_temp2_1=sample_sequence_vecspace(temp_s_num2,:).';
    sample_cov_temp2_2=sample_sequence_vecspace(temp_s_num2,:);
    sample_cov_temp3_1=sample_sequence_vecspace(temp_s_num3,:).';
    sample_cov_temp3_2=sample_sequence_vecspace(temp_s_num3,:);

    sample_cov1=sample_cov_temp1_1*sample_cov_temp1_2/s_num;
    sample_cov2=sample_cov_temp2_1*sample_cov_temp2_2/s_num;
    sample_cov3=sample_cov_temp3_1*sample_cov_temp3_2/s_num;
end