function [PerInc, P] = perl_comp(D, gamma)
%формула 1
    P = exp(-D * gamma);%числитель оно же ядро гауса
    sumP = sum(P);%знаменатель
    PerInc = log(sumP) + gamma * sum(D .* P) / sumP;%перплексия, если в (1) посставить (2), энтропия или лог(перп)
    P = P / sumP;%формула 1 вычисение p(j|i)
end