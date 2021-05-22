function [F,X,Y,P] = SphereDipPotential(XYZ,Q,D,R,r0,a,b,Dx,Dy,Nxy);
N = length(Q);
c = cross(a,b)/norm(cross(a,b));
a = a / norm(a);
b = b / norm(b);
X = zeros(Nxy(1), Nxy(2));
Y = zeros(Nxy(1), Nxy(2));
dx = (Dx(2) - Dx(1)) / (Nxy(1)-1);
dy = (Dy(2) - Dy(1)) / (Nxy(2)-1);
for i = 1:Nxy(1)
    for j = 1:Nxy(2)
        X(i,j) = Dx(1) + dx * (i-1);
        Y(i,j) = Dy(1) + dy * (j-1);
    end
end
P = [a, c, -b] * ([1/dx, 0, 0; 0, 1/dy, 0; 0, 0, 1]') ^ (-1);
P = P(:,1:2);
r = zeros(3, 1);
F = zeros(Nxy(1), Nxy(2));
for i = 1:Nxy(1)
    for j = 1:Nxy(2)
        r = P * [X(i,j); Y(i, j)] + r0;
        for k = 1:N
            if (R(k) < abs(r-XYZ(:,k)))
                F(i,j) = F(i,j) + Q(k)/abs(r-XYZ(:,k));
                F(i,j) = F(i,j) + D(k,:)'*(r-XYZ(:,k))/(abs(r-XYZ(:,k)))^3;
            else
                F(i,j) = F(i,j) + Q(k) / R(k);
            end
        end
        
    end
end
end