function d=sqdist(a,b)
% d*n
% SQDIST - computes squared Euclidean distance matrix
%          computes a rectangular matrix of pairwise distances
% between points in A (given in columns) and points in B

% NB: very fast implementation taken from Roland Bunschoten
aa = sum(a.*a,1); bb = sum(b.*b,1); ab = a'*b; %���������ĺͣ�.*Ҫ��a��a��ͬ��񣬶�Ӧ��λ�����
%aa��һ��1000�еľ���bb��һ��63�еľ���ab��1000��63�еľ���
%����Сƽ�����׼��
d = abs(repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab);%1000��63�еľ���֮���������
%repmat(A,n, m)�൱�ڽ��о�����չ���size(A,1)*n, size(A,2)*m
%aa��1X1000�� bb��1X63,repmat(aa',[1 size(bb,2)])��1000X63
%a'��1000*2, b��2*63

