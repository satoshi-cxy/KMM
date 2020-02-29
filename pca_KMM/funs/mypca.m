function result = mypca(X)
%MYPCA 此处显示有关此函数的摘要
%   此处显示详细说明
[n m] = size(X);
covX = cov(X);
[V D] = eigs(covX);
meanX = mean(X);
tempX = repmat(meanX,n,1);
score = (X-tempX)*V;
result = score;
end

