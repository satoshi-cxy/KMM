function means = meanInd(X, label, c, Z) %X是2行1000列的，meanInd(X, StartIndZ,m,BiGraph)，BiGraph是n*m矩阵
% X:d*n, Z:n*c
n=size(X,2);
%StartIndZ=kmeans(X',m),所以length(unique(label))==c
if length(unique(label))~=c %unique(label)获取矩阵label中不同元素构成的向量
	label = kmeans(X',c); %X'是1000X2, 将n*d矩阵分成c个聚类，lalel是n*1的矩阵，每行存储的是每个点的聚类标号
	Z = ones(n,c);
% 	fprintf('n ')
end
%X(:,sub_idx)*Z(sub_idx,i)/sum(Z(sub_idx,i))是求原型ai的公式，
%
%
%
for i=1:c
    sub_idx=find(label==i); %find()函数返回labeln*1矩阵中等于i的元素的位置索引， sub_idx是1*find（label=i）的矩阵
    %将属于第i类的x乘以z中对应的值再求和再求平均值，该平均值就是原型aj，总共有63个原型，每个原型是2维
    means(:,i)=X(:,sub_idx)*Z(sub_idx,i)/sum(Z(sub_idx,i)); %sum是计算Z矩阵第i列之和，means是2*63的矩阵
end

end