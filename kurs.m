clear all;
close all;
clc;

% ��������� � ������������ �������� ������
load 'C:\mnist\mnist_train'

n=500;% ���������� ��������� � �������

ind = randperm(size(train_X, 1));%������������� ���� �������
train_X = train_X(ind(1:n),:);
train_labels = train_labels(ind(1:n))-1;

%% ����������� ������� ������, ������� ���, ���� �� �������� � ������� �������

 train_X = (train_X - min(train_X(:)))/ max(train_X(:));
    
      for i=1: size(train_X,1)%�������� �� ������ ������ �������
          
               train_X(i,:)=train_X(i,:)-mean(train_X, 1);
          
      end
      
%% ������� ��������� 

Dim_space = 2;   % ������ ������������� ������������
perplexity = 20; % ����������
T = 500;        % ���������� ��������
mu = 500;        % �������� ��������
momentum = 0.5;  % ������(�������)
numberplot=false;    %�������� ��� ������ ��� ���
%% ���������� ������� �������� ����������� �

      P = give_condi_P(train_X, perplexity, 1e-5);

%% ��������� ����������� � t-SNE

      ydata = t_sne_algoritm(P, Dim_space,momentum,mu,T);
        
%% ���������� ��������
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
        
