function means = meanInd(X, label, c, Z) %X��2��1000�еģ�meanInd(X, StartIndZ,m,BiGraph)��BiGraph��n*m����
% X:d*n, Z:n*c
n=size(X,2);
%StartIndZ=kmeans(X',m),����length(unique(label))==c
if length(unique(label))~=c %unique(label)��ȡ����label�в�ͬԪ�ع��ɵ�����
	label = kmeans(X',c); %X'��1000X2, ��n*d����ֳ�c�����࣬lalel��n*1�ľ���ÿ�д洢����ÿ����ľ�����
	Z = ones(n,c);
% 	fprintf('n ')
end
%X(:,sub_idx)*Z(sub_idx,i)/sum(Z(sub_idx,i))����ԭ��ai�Ĺ�ʽ��
%
%
%
for i=1:c
    sub_idx=find(label==i); %find()��������labeln*1�����е���i��Ԫ�ص�λ�������� sub_idx��1*find��label=i���ľ���
    %�����ڵ�i���x����z�ж�Ӧ��ֵ���������ƽ��ֵ����ƽ��ֵ����ԭ��aj���ܹ���63��ԭ�ͣ�ÿ��ԭ����2ά
    means(:,i)=X(:,sub_idx)*Z(sub_idx,i)/sum(Z(sub_idx,i)); %sum�Ǽ���Z�����i��֮�ͣ�means��2*63�ľ���
end

end