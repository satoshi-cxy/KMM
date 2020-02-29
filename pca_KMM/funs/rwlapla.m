function [Bigraph, F, evc] = rwlapla(Z,c)
%RWLAPLA 此处显示有关此函数的摘要
%   此处显示详细说明
Bigraph = Z;
Z = full(Z);
[n,m] = size(Z);
block1 = zeros(n,n);
block2 = zeros(m,m);
left = [block1;Z'];
right = [Z;block2];
Z = [left, right];
z1 = sum(Z,2);
D = spdiags(z1,0,n+m,n+m);
D1 = spdiags(1./z1,0,n+m,n+m);
LS = D1*(D-Z);
B = eye(size(LS,1));
[v, d] = eig(LS, B);
d = diag(d);
d = abs(d);
[d1, idx] = sort(d,'descend');

idx1 = idx(1:c+1);
V= d(idx1);%特征值从小到大
evc = v(:,idx1); %特征向量
F = v

end

