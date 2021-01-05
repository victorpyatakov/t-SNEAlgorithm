function ydata = t_sne_algoritm(P, no_dims,momentum,mu,T)
%% ����������

    n = size(P, 1);                                     % ���������� �����
    final_momentum = 0.8;                               
    momentum_iter_change = 250;                            
    stop_lying_iter = 100;                              % �� ������ ����� ������ ������ �������������                                    % �������� ��������
    min_gain = .01;                                     % ��������� �������� ��� ������-���-������
    
    
    P(1:n + 1:end) = 0;   % ��� ��� �������� � i|i=0 �� �� ����������� ���������� ����
    P = 0.5 * (P + P');                                 % ������� ��� ���������� ���.����������� ��� �=(�(j|i)+p(i|j))/2n
    P = max(P ./ sum(P(:)), realmin);                   %�=(�(j|i)+p(i|j))/2n, n=sum(P(:))
    divKL = sum(P(:) .* log(P(:)));                     % ������� ������ ������������ ��������-��������
   
     P = P * 4;                                      % ������ �������������, ����� ����� ������ ���������� ��������
    
    
%% �������������� �����������
    
        ydata = .0001 * randn(n, no_dims);% �������� ���� ����������� � ������� ����������� ������������
    
    y_incs  = zeros(size(ydata));% ���������� �����������
    gains = ones(size(ydata));% �������� ��� ��������� ���������
    
%% �������
    
    for iter=1:T
        
        % ���������� Q ����������� ���������� �� ������� 4 
        sum_ydata = sum(ydata .^ 2, 2);
       
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Matr=-2 * (ydata * ydata');
        
        for i=1: size(ydata,1)
            A(i,:)=sum_ydata'+ Matr(i,:);
        end
        
         for i=1: size(ydata,1)
            AA(:,i)=sum_ydata+ A(:,i);
          end
   
        t_rasp=1./(1+AA); % � ����� ������� ������������� ���������
        
      
        
        t_rasp(1:n+1:end) = 0;                                                
        Q = max(t_rasp ./ sum(t_rasp(:)), realmin);                   %�������� Q            
        
        % ���������� ��������� �� ������� 5
        L = (P - Q) .* t_rasp;% (P-Q)*(1+||yi-yj]]^2)^-1
        y_grads = 4 * (diag(sum(L, 1)) - L) * ydata;% ������� 5
            
        % ������-���-������ ����
        gains = (gains + .2) .* (sign(y_grads) ~= sign(y_incs)) ...         
              + (gains * .8) .* (sign(y_grads) == sign(y_incs));
        gains(gains < min_gain) = min_gain;
        
        y_incs = momentum * y_incs - mu * (gains .* y_grads);%���������� � � ������ ���� 
        ydata = ydata + y_incs; 
%          ydata = bsxfun(@minus, ydata, mean(ydata, 1));% �����������
        
          for i=1: size(ydata,1)%�������� �� ������ ������ �������
          
               ydata(i,:)=ydata(i,:)-mean(ydata, 1);
          
          end
        % �������� ������
        if iter == momentum_iter_change
            momentum = final_momentum;
        end
        %������� ��������������
        if iter == stop_lying_iter 
            P = P ./ 4;
        end
        
        % ����� �� ������ ������� ���������
        if ~rem(iter, 10)
            cost = divKL - sum(P(:) .* log(Q(:)));% ������� ��������� ��������-��������
            
            disp(['�������� ' num2str(iter) ': ����������� �-�: ' num2str(cost)]);
        end
        
        
    end
    