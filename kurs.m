clear all;
close all;
clc;

% загружаем и обрабатываем исходные данные
load 'C:\mnist\mnist_train'

n=500;% количество элементов в выборке

ind = randperm(size(train_X, 1));%рандомизируем нашу выборку
train_X = train_X(ind(1:n),:);
train_labels = train_labels(ind(1:n))-1;

%% нормализуем входные данные, вычитая мин, деля на максимум и вычитая среднее

 train_X = (train_X - min(train_X(:)))/ max(train_X(:));
    
      for i=1: size(train_X,1)%вычитаем их каждой строки среднее
          
               train_X(i,:)=train_X(i,:)-mean(train_X, 1);
          
      end
      
%% входные параметры 

Dim_space = 2;   % размер отображающего пространства
perplexity = 20; % перплексия
T = 500;        % количество итераций
mu = 500;        % скорость обучения
momentum = 0.5;  % момент(инерция)
numberplot=false;    %выводить мне график или нет
%% вычисление матрицы условных вероятнотей Р

      P = give_condi_P(train_X, perplexity, 1e-5);

%% понижение размерности с t-SNE

      ydata = t_sne_algoritm(P, Dim_space,momentum,mu,T);
        
%% построение графиков
if Dim_space == 2
    
      figure(1)
      gscatter(ydata(:,1), ydata(:,2), train_labels(:));
if numberplot==1
      figure(2)
      plotin2D( ydata,train_labels )
end

else
    
      figure(1)
      scatter3(ydata(:,1), ydata(:,2), ydata(:,3), 40, train_labels, 'filled');

      figure(2)
      plotin3d( ydata,train_labels );

end 
        
