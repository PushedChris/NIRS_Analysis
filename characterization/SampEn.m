function SampEnVal = SampEn(data, m, r)
% SampEn  计算时间序列data的样本熵
% 输入：data是数据一维行向量
%      m重构维数，一般选择1或2，优先选择2，一般不取m>2
%      r 阈值大小，一般选择r=0.1~0.25*Std(data)
% 输出：SampEnVal样本熵值大小

data = data(:)';
N = length(data);
Nkx1 = 0;
Nkx2 = 0;

for k = N - m:-1:1
    x1(k, :) = data(k:k + m - 1);
    x2(k, :) = data(k:k + m);
end

for k = N - m:-1:1
    x1temprow = x1(k, :);
    x1temp    = ones(N - m, 1)*x1temprow;   
    dx1(k, :) = max(abs(x1temp - x1), [], 2)';   
    Nkx1 = Nkx1 + (sum(dx1(k, :) < r) - 1)/(N - m - 1);    
    x2temprow = x2(k, :);
    x2temp    = ones(N - m, 1)*x2temprow;
    dx2(k, :) = max(abs(x2temp - x2), [], 2)';
    Nkx2      = Nkx2 + (sum(dx2(k, :) < r) - 1)/(N - m - 1);
end
Bmx1 = Nkx1/(N - m);
Bmx2 = Nkx2/(N - m);
SampEnVal = -log(Bmx2/Bmx1);
end
