function [Q,D] = ElectroStaticDipoles(XYZ,R,F);
collision(XYZ, R);
n = length(R);
A = zeros(4*n, 4*n);
for i=1:n
    for j = 1:n
        if i~=j
            A(i,j) = 1/abs(XYZ(:,i) - XYZ(:,j));
        else
            A(i,j) = 1/R(i);
        end
    end
    for j = n+1:2*n
        if j-n~=i
            A(i,j) = (XYZ(1, i)-XYZ(1,j-n)) / abs(XYZ(:,i) - XYZ(:, j-n))^3;
        end
    end
    for j = 2*n+1:3*n
        if j-2*n~=i
            A(i,j) = (XYZ(2, i)-XYZ(2,j-n)) / abs(XYZ(:,i) - XYZ(:, j-n))^3;
        end
    end
    for j = 3*n+1:4*n
        if j-3*n~=i
            A(i,j) = (XYZ(3, i)-XYZ(3,j-n)) / abs(XYZ(:,i) - XYZ(:, j-n))^3;
        end
    end
end

for i = n+1:2*n
    for j = 1:n
        if i-n~=j
            A(i,j) = R(i-n)^3 * (XYZ(1,i-n) - XYZ(1,j)) / abs(XYZ(:,i-n) - XYZ(:,j)) ^ 3;
        end
    end
    for j = n+1:2*n
        if i-n~=j-n
            A(i,j) = (XYZ(1,i-n) - XYZ(1,j-n)) ^ 2 / abs(XYZ(:,i-n) - XYZ(:,j-n))^5 - 1/abs(XYZ(:,i-n) - XYZ(:,j-n))^3;
        else
            A(i,j) = -R(i-n)^3;
        end
    end
    for j = 2*n+1:3*n
        if i-n~=j-2*n
            A(i,j) = -1/abs(XYZ(:,i-n) - XYZ(:,j-2*n))^3;
        else
            A(i,j) = -R(i-n)^3;
        end
    end
    for j = 3*n+1:4*n
        if i-n~=j-3*n
            A(i,j) = -1/abs(XYZ(:,i-n) - XYZ(:,j-3*n))^3;
        else
            A(i,j) = -R(i-n)^3;
        end
    end
end

for i = 2*n+1:3*n
    for j = 1:n
        if i-2*n~=j
            A(i,j) = XYZ(2,i-2*n) - XYZ(2,j) / abs(XYZ(:,i-2*n) - XYZ(:,j)) ^ 3;
        end
    end
    for j = n+1:2*n
        if i-2*n~=j-n
            A(i,j) = -1/abs(XYZ(:,i-2*n) - XYZ(:,j-n))^3;
        else
            A(i,j) = -R(i-2*n)^3;
        end
    end
    for j = 2*n+1:3*n
        if i-2*n~=j-2*n
            A(i,j) = (XYZ(2,i-2*n) - XYZ(2,j-n)) ^ 2 / abs(XYZ(:,i-2*n) - XYZ(:,j-n))^5-1/abs(XYZ(:,i-2*n) - XYZ(:,j-2*n))^3;
        else
            A(i,j) = -R(i-2*n)^3;
        end
    end
    for j = 3*n+1:4*n
        if i-2*n~=j-3*n
            A(i,j) = -1/abs(XYZ(:,i-2*n) - XYZ(:,j-3*n))^3;
        else
            A(i,j) = -R(i-2*n)^3;
        end
    end
end

for i = 3*n+1:4*n
    for j = 1:n
        if i-3*n~=j
            A(i,j) = XYZ(3,i-3*n) - XYZ(3,j) / abs(XYZ(:,i-3*n) - XYZ(:,j)) ^ 3;
        end
    end
    for j = n+1:2*n
        if i-3*n~=j-n
            A(i,j) = -1/abs(XYZ(:,i-3*n) - XYZ(:,j-n))^3;
        else
            A(i,j) = -R(i-3*n)^3;
        end
    end
    for j = 2*n+1:3*n
        if i-3*n~=j-2*n
            A(i,j) = -1/abs(XYZ(:,i-3*n) - XYZ(:,j-2*n))^3;
        else
            A(i,j) = -R(i-3*n)^3;
        end
    end
    for j = 3*n+1:4*n
        if i-3*n~=j-3*n
            A(i,j) = (XYZ(3,i-3*n) - XYZ(3,j-n)) ^ 2 / abs(XYZ(:,i-3*n) - XYZ(:,j-n))^5-1/abs(XYZ(:,i-3*n) - XYZ(:,j-3*n))^3;
        else
            A(i,j) = -R(i-3*n)^3;
        end
    end
end

F0 = zeros(4*n, 1);
F0(1:n,1) = F;
X = A^(-1) * F0;
Q = X(1:n);
D(1:n,1) = X(n+1:2*n);
D(1:n,2) = X(2*n+1:3*n);
D(1:n,3) = X(3*n+1:4*n);


end