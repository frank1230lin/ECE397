function [x,p]=inverse_map_ADMM(mean,cov1,cov2,cov3,L,s)
    % mean - mean matrix(3*s) with rows being sample mean of each coordinate
    % cov1 - sample covariance of first coordinate
    % cov2 - sample covariance of second coordinate
    % cov3 - sample covariance of third coordinate
    % L - length of entire sequence
    % s - segment length
    %-----------------------------------------Returns-------------------------------------------
    % x - original sequence
    % p - the shift distribution

    num=[1,2,3];
    mean_set={mean(1,:).',mean(2,:).',mean(3,:).'};
    Mean=containers.Map(num,mean_set);
    cov_set={cov1,cov2,cov3};
    Cov=containers.Map(num,cov_set);
    
    % Optmization hyper-parameters
    lambda1=1;
    lambda2=1;
    rho=1;
    iter_num=150;
    
    D=dftmtx(L)'/L;
    D(s+1:L,:)=[];
    
    % Initial values
    x=fft(rand(L,3));
    y=x;
    p=fft(rand(L,3));
    u=fft(rand(L,3));
    
    temp_A2=zeros(L,s);
    A2=zeros(s^2,L);
    temp_B1=zeros(s,L);
    B1=zeros(s^2,L);
    C2=zeros(s^2,L);
    C=zeros(L,L);
    error1=zeros(iter_num,3);
    error2=zeros(iter_num,3);
    error3=zeros(iter_num,3);
    error4=zeros(iter_num,3);
    
    % Loop over three dimensions
    for dim=1:3
    
        for i=1:L
            for j=1:L
                C(i,j)=p(abs(j-i)+1,dim);
            end
        end
        
        % Stopping Criterion
        for iter=1:iter_num
            A1=sqrt(lambda1)*D.*(ones(s,1)*p(:,dim)');
            
            for i=1:L
                for j=1:s
                    temp_A2(i,j)=(C(i,:).*conj(D(j,:)))*conj(y(:,dim));
                end
            end
            for i=1:s
                for j=1:s
                    A2(s*(i-1)+j,:)=temp_A2(:,i).'.*D(j,:);
                end
            end
            A2=sqrt(lambda2)*A2;
            
            A3=sqrt(rho/2)*eye(L);
            
            A=[A1;A2;A3];
            
            A1_est=sqrt(lambda1)*Mean(dim);
            A2_est=sqrt(lambda2)*reshape(Cov(dim),[s^2,1]);
            A3_est=sqrt(rho/2)*(y(:,dim)-u(:,dim));
            A_est=[A1_est;A2_est;A3_est];

            x(:,dim)=A\A_est;
            
            for i=1:s
                for j=1:L
                    temp_B1(i,j)=(D(i,:).*C(:,j).')*x(:,dim);
                end
            end    
            for i=1:s
                for j=1:s
                    B1(s*(i-1)+j,:)=temp_B1(j,:).*conj(D(i,:));
                end    
            end
            B1=sqrt(lambda2)*B1;
            
            B2=sqrt(rho/2)*eye(L);
            
            B=[B1;B2];
            
            B1_est=sqrt(lambda2)*reshape(Cov(dim),[s^2,1]);
            B2_est=sqrt(rho/2)*(conj(x(:,dim)+u(:,dim)));
            
            B_est=[B1_est;B2_est];
            
            y(:,dim)=conj(B\B_est);
            
            C1=conj(sqrt(lambda1)*D.*(ones(s,1)*x(:,dim).'));
            
            for i=1:s
                for j=1:s
                    for k=1:L
                        C2(s*(i-1)+j,k)=sum(D(j,:).*x(:,dim).'.*circshift(y(:,dim),1-k).'.*circshift(D(i,:),1-k));
                    end
                end
            end
            C2=sqrt(lambda2)*C2;
            
            C_all=[C1;C2];
            
            C1_est=conj(sqrt(lambda1)*Mean(dim));
            C2_est=sqrt(lambda2)*reshape(Cov(dim),[s^2,1]);
            
            C_est=[C1_est;C2_est];
            
            p(:,dim)=C_all\C_est;
            
            u(:,dim)=u(:,dim)+x(:,dim)-y(:,dim);
            
            for i=1:L
                for j=1:L
                    C(i,j)=p(abs(j-i)+1,dim);
                end
            end
            
            error1(iter,dim)=lambda1*norm(D*(x(:,dim).*conj(p))-Mean(dim))^2;
            error2(iter,dim)=lambda2*norm(D*((x(:,dim)*y(:,dim)').*C)*D'-Cov(dim),'fro')^2;
            error3(iter,dim)=rho/2*norm(x(:,dim)-y(:,dim)+u(:,dim))^2;
            error4(iter,dim)=error1(iter,dim)+error2(iter,dim)+error3(iter,dim);
        end   
    end
    figure(1);
    plot(1:iter_num,log10(error1));
    legend("1","2","3");
    figure(2);
    plot(1:iter_num,log10(error2));
    legend("1","2","3");
    figure(3);
    plot(1:iter_num,log10(error3));
    legend("1","2","3");
    figure(4);
    plot(1:iter_num,log10(error4));
    legend("1","2","3");
    x=ifft(x.');
    p=ifft(p.');
end