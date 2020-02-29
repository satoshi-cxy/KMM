function [eigvec, eigval, eigval_full] = eig1(A, c, isMax, B) %[V, evc, ~]=eig1(LZ,c+1);c=5
% The optimal solution F to the problem is formed by the c eigenvectors of
% L corresponding to the c smallest eigenvalues
if nargin < 2
    c = size(A,1);
    isMax = 1;
elseif c > size(A,1)
    c = size(A,1);
end;

if nargin < 3
    isMax = 1;
end;

if nargin < 4
    B = eye(size(A,1));
end;

A = (A+A')/2;   % 这
[v d] = eig(A); %eig()求矩阵特征值和特征向量，特征值保存至d的对角线上，特征向量按列存在v
d = diag(d);
d = abs(d);
if isMax == 0
    [d1, idx] = sort(d );
else
    [d1, idx] = sort(d,'descend');
end;

idx1 = idx(1:c);
eigval = d(idx1);%特征值从小到大
eigvec = v(:,idx1); %特征向量

eigval_full = d(idx);