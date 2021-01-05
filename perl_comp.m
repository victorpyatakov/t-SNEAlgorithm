function [PerInc, P] = perl_comp(D, gamma)
%������� 1
    P = exp(-D * gamma);%��������� ��� �� ���� �����
    sumP = sum(P);%�����������
    PerInc = log(sumP) + gamma * sum(D .* P) / sumP;%����������, ���� � (1) ���������� (2), �������� ��� ���(����)
    P = P / sumP;%������� 1 ��������� p(j|i)
end