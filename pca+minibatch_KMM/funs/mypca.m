function result = mypca(X)
%�����ɷַ���������X���н�ά
%   X��ʼ��4ά�����ݾ�������ÿ��ά�ȵ�Э�����������Э������������ֵ
[n m] = size(X);
covX = cov(X);
[V D] = eigs(covX);
meanX = mean(X);
tempX = repmat(meanX,n,1);
score = (X-tempX)*V;
result = score;
end

