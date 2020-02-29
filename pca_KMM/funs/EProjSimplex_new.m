function [x ft] = EProjSimplex_new(v, k)

%
%% Problem
%
%  min  1/2 || x - v||^2 就是论文中第20个式子，x即是si
%  s.t. x>=0, 1'x=1
%

if nargin < 2
    k = 1;
end;

ft=1;
n = length(v);

v0 = v-mean(v) + k/n;
%vmax = max(v0);
vmin = min(v0);
if vmin < 0
    f = 1;
    lambda_m = 0;
    while abs(f) > 10^-10
        v1 = v0 - lambda_m;
        posidx = v1>0;%即是v1中大于0 的元素的位置显示为1
        npos = sum(posidx);%v1中大于0的元素的个数
        g = -npos;
        f = sum(v1(posidx)) - k;%大于0的元素之和-k
        lambda_m = lambda_m - f/g;
       ft=ft+1;
        if ft > 100
            x = max(v1,0);
            break;
        end;
    end;
    x = max(v1,0);
else
    x = v0;
end;