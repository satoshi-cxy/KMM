function dist = lapldist(f, n, m)
%LAPLDIST 此处显示有关此函数的摘要
%   此处显示详细说明

for i = 1:n
    for j = 1:m
        Ke(i,j) = sum((f(:,i)-f(:,n+j)).^2);
%        Ke(i,j) = exp(-sum((a(:,i)-b(:,j)).^2)); % Gaussian
%         Ke(n,n2) = a(n,:)*a(n2,:)'; % Linear
%         Ke(n,n2) = sum(a(n,:).^2)-sum(a(n2,:).^2); % Point Distances
    end
end
dist = Ke;
end

