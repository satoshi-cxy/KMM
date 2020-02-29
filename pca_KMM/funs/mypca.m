function result = mypca(X)
%MYPCA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[n m] = size(X);
covX = cov(X);
[V D] = eigs(covX);
meanX = mean(X);
tempX = repmat(meanX,n,1);
score = (X-tempX)*V;
result = score;
end

