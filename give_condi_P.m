function [P, gamma] = give_condi_P(X, u, tol)

    
    %% переменные
    n = size(X, 1);                     % количество состо€ний в матрице условных веро€тностей
    P = zeros(n, n);                    % матрица веро€тностей
    gamma = ones(n, 1);                  % что то про точность, наверно сигма
    logU = log(u);                      % log of perplexity (= entropy)
    
    %% вычисление попарных расто€ний
    
    sum_X = sum(X .^ 2, 2);
      Matr=-2 * X * X';% так как мы берем гамму а не сигму , то 2 в числитель перейдет
      
     for i=1: size(sum_X,1)
          A(i,:)=sum_X'+ Matr(i,:);
     end
      
      for i=1: size(sum_X,1)
          D(:,i)=sum_X+ A(:,i);%матрица рассто€ний евклида
      end
      
    %% ѕройдем по всем точкам
    
    for i=1:n
        
        
        % мин и макс значени€ дл€ €дра гауса
        gammamin = -Inf; 
        gammamax = Inf;
        
        % ¬ычислени€ €дра и ентропии дл€ текущей гаммы
        Di = D(i, [1:i-1 i+1:end]);
        [PerInc, thisP] = perl_comp(Di, gamma(i));
        
        % ¬ предалах доспустимых значений перплекси€ или нет
        Perldiff = PerInc - logU;
        tries = 0;
        while abs(Perldiff) > tol && tries < 50
            
            % бинарный посик гаммы
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
            
            % ѕересчитаем значени€ перплексии и веро€тности
            [PerInc, thisP] = perl_comp(Di, gamma(i));
            Perldiff = PerInc - logU;
            tries = tries + 1;
        end
        
        % «апишем итоговые условные веро€тности
        P(i, [1:i - 1, i + 1:end]) = thisP;
    end    
end
    





