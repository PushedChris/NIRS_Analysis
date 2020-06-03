function ApEn_value = ApEn(signal,m,r_factor)
%
% �������ƣ�ApEn(ApproximateEntropy)
% �������ܣ����źŵĽ����� 
% �������룺����ʱ������   signal
%          ģʽά��       m : m=1 or m= 2 
% ���������������        ApEn_value
% ��д���ߣ� Rong
% ��дʱ�䣺 2012.10.18
% ����˵����N (signal length) between 75 and 5000;
%          r between 0.1*STD and 0.25*STD, where STD is the signal standard deviation
%
signal = signal(:)';
N = length(signal); 
% C computation for the "m" pattern.
[C_m] = C_m_computation(signal,m,r_factor);
% C computation for the "m+1" pattern.
[C_m_1] = C_m_computation(signal,m+1,r_factor);
% Phi��s computation.
phi_m = mean(log(C_m));
phi_m_1 = mean(log(C_m_1));
% Final ApEn computation.
ApEn_value = [phi_m-phi_m_1];

function [C_im] = C_m_computation(signal,m,r_factor)
X = [];
C_im = [];
n_im = [];
max_dif = [];
N = length(signal); 
% Construction of the X��s vectors.
for j = 1:N-m+1
    X(j,:) = signal(j:j+m-1);
end
% C computation.
for j = 1:N-m+1
    aux1 = repmat(X(j,:),N-m+1,1);
    dif_aux = abs(X-aux1);
    n_im = 0;
    for k = 1:N-m+1
        if max(abs(dif_aux(k,:))) < r_factor*std(signal)
            n_im = n_im+1;
        end;
    end
    C_im = [C_im; n_im/(N-m+1)];
end