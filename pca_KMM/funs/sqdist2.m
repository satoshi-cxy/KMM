function d2 = sqdist2(a,b)
%SQDIST2 此处显示有关此函数的摘要
%   此处显示详细说明n
n = size(a,2);
m = size(b,2);
Ke = zeros(n, m);

%Ke = (a'*b)/norm(a)/norm(b);
for i = 1:n
    for j = 1:m
        Ke(i,j) = sum((a(:,i)-b(:,j)).^2);
%        Ke(i,j) = exp(-sum((a(:,i)-b(:,j)).^2)); % Gaussian
%         Ke(n,n2) = a(n,:)*a(n2,:)'; % Linear
%         Ke(n,n2) = sum(a(n,:).^2)-sum(a(n2,:).^2); % Point Distances
    end
end
d2 = Ke;
end

