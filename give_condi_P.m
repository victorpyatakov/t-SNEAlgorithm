function [P, gamma] = give_condi_P(X, u, tol)

    
    %% ����������
    n = size(X, 1);                     % ���������� ��������� � ������� �������� ������������
    P = zeros(n, n);                    % ������� ������������
    gamma = ones(n, 1);                  % ��� �� ��� ��������, ������� �����
    logU = log(u);                      % log of perplexity (= entropy)
    
    %% ���������� �������� ���������
    
    sum_X = sum(X .^ 2, 2);
      Matr=-2 * X * X';% ��� ��� �� ����� ����� � �� ����� , �� 2 � ��������� ��������
      
     for i=1: size(sum_X,1)
          A(i,:)=sum_X'+ Matr(i,:);
     end
      
      for i=1: size(sum_X,1)
          D(:,i)=sum_X+ A(:,i);%������� ���������� �������
      end
      
    %% ������� �� ���� ������
    
    for i=1:n
        
        
        % ��� � ���� �������� ��� ���� �����
        gammamin = -Inf; 
        gammamax = Inf;
        
        % ���������� ���� � �������� ��� ������� �����
        Di = D(i, [1:i-1 i+1:end]);
        [PerInc, thisP] = perl_comp(Di, gamma(i));
        
        % � �������� ����������� �������� ���������� ��� ���
        Perldiff = PerInc - logU;
        tries = 0;
        while abs(Perldiff) > tol && tries < 50
            
            % �������� ����� �����
            if Perldiff > 0
                gammamin = gamma(i);
                if isinf(gammamax)
                    gamma(i) = gamma(i) * 2;
                else
                    gamma(i) = (gamma(i) + gammamax) / 2;
                end
            else
                gammamax = gamma(i);
                if isinf(gammamin) 
                    gamma(i) = gamma(i) / 2;
                else
                    gamma(i) = (gamma(i) + gammamin) / 2;
                end
            end
            
            % ����������� �������� ���������� � �����������
            [PerInc, thisP] = perl_comp(Di, gamma(i));
            Perldiff = PerInc - logU;
            tries = tries + 1;
        end
        
        % ������� �������� �������� �����������
        P(i, [1:i - 1, i + 1:end]) = thisP;
    end    
end
    





