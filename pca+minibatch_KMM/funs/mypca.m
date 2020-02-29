function result = mypca(X)
%用主成分分析方法对X进行降维
%   X初始是4维的数据矩阵，先求每个维度的协方差矩阵，再求协方差矩阵的特征值
[n m] = size(X);
covX = cov(X);
[V D] = eigs(covX);
meanX = mean(X);
tempX = repmat(meanX,n,1);
score = (X-tempX)*V;
result = score;
end

