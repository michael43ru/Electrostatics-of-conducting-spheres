function Q = ElectroStaticBalls(XYZ, R, F)
collision(XYZ, R);
n = length(R);
A = zeros(n, n);
for i=1:n
    for j = 1:n
        if i~=j
            A(i,j) = 1/abs(XYZ(:,i) - XYZ(:,j));
        else
            A(i,j) = 1/R(i);
        end
    end
end
Q = A^(-1) * F;
end