function d=sqdist(a,b)
% d*n
% SQDIST - computes squared Euclidean distance matrix
%          computes a rectangular matrix of pairwise distances
% between points in A (given in columns) and points in B

% NB: very fast implementation taken from Roland Bunschoten
aa = sum(a.*a,1); bb = sum(b.*b,1); ab = a'*b; %求列向量的和，.*要求a和a相同规格，对应点位置相乘
%aa是一行1000列的矩阵，bb是一行63列的矩阵，ab是1000行63列的矩阵
%求最小平方误差准则
d = abs(repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab);%1000行63列的矩阵之间进行运算
%repmat(A,n, m)相当于进行矩阵扩展变成size(A,1)*n, size(A,2)*m
%aa是1X1000， bb是1X63,repmat(aa',[1 size(bb,2)])是1000X63
%a'是1000*2, b是2*63

