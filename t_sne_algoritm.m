function ydata = t_sne_algoritm(P, no_dims,momentum,mu,T)
%% переменные

    n = size(P, 1);                                     % количество точек
    final_momentum = 0.8;                               
    momentum_iter_change = 250;                            
    stop_lying_iter = 100;                              % до какого будем делать раннее гиперусиление                                    % скорость обучения
    min_gain = .01;                                     % начальное уселение для дельта-бар-дельта
    
    
    P(1:n + 1:end) = 0;   % так как условные в i|i=0 то по диалогонали встраеваем нули
    P = 0.5 * (P + P');                                 % формула для вычисления без.вероятности как Р=(р(j|i)+p(i|j))/2n
    P = max(P ./ sum(P(:)), realmin);                   %Р=(р(j|i)+p(i|j))/2n, n=sum(P(:))
    divKL = sum(P(:) .* log(P(:)));                     % функция потерь дивергениция Кульбака-Лейблера
   
     P = P * 4;                                      % раннее гиперусиление, чтобы лучше искать глобальные минимумы
    
    
%% инициализиурем отображение
    
        ydata = .0001 * randn(n, no_dims);% рандомим наши отображения с помощью нормального распрееления
    
    y_incs  = zeros(size(ydata));% приращение отображений
    gains = ones(size(ydata));% усиление для ускорения градиента
    
%% погнали
    
    for iter=1:T
        
        % вычисоение Q безусловной вероятнсти по формуле 4 
        sum_ydata = sum(ydata .^ 2, 2);
       
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Matr=-2 * (ydata * ydata');
        
        for i=1: size(ydata,1)
            A(i,:)=sum_ydata'+ Matr(i,:);
        end
        
         for i=1: size(ydata,1)
            AA(:,i)=sum_ydata+ A(:,i);
          end
   
        t_rasp=1./(1+AA); % в итоге получим распределение стъюдента
        
      
        
        t_rasp(1:n+1:end) = 0;                                                
        Q = max(t_rasp ./ sum(t_rasp(:)), realmin);                   %получили Q            
        
        % вычисление градиента по формуле 5
        L = (P - Q) .* t_rasp;% (P-Q)*(1+||yi-yj]]^2)^-1
        y_grads = 4 * (diag(sum(L, 1)) - L) * ydata;% ФОРМУЛА 5
            
        % дельта-бар-дельиа типа
        gains = (gains + .2) .* (sign(y_grads) ~= sign(y_incs)) ...         
              + (gains * .8) .* (sign(y_grads) == sign(y_incs));
        gains(gains < min_gain) = min_gain;
        
        y_incs = momentum * y_incs - mu * (gains .* y_grads);%приращение У с учетом град 
        ydata = ydata + y_incs; 
%          ydata = bsxfun(@minus, ydata, mean(ydata, 1));% нормализуем
        
          for i=1: size(ydata,1)%вычитаем их каждой строки среднее
          
               ydata(i,:)=ydata(i,:)-mean(ydata, 1);
          
          end
        % изменяем момент
        if iter == momentum_iter_change
            momentum = final_momentum;
        end
        %убираем гиперсусиление
        if iter == stop_lying_iter 
            P = P ./ 4;
        end
        
        % чтобы не уснуть смотрим результат
        if ~rem(iter, 10)
            cost = divKL - sum(P(:) .* log(Q(:)));% функция стоймости кульбака-Лейблера
            
            disp(['Итерация ' num2str(iter) ': дивергенция К-Л: ' num2str(cost)]);
        end
        
        
    end
    