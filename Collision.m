function collision(XYZ, R)
bool = 1;
n = length(R);
for i = 1:n-1
    for j = i+1:n
        if abs(XYZ(:,i) - XYZ(:,j)) < R(i) + R(j)
            bool = 0;
        end
    end
end
if bool
    disp('Нет наложений');
else
    disp('Есть наложение');
end
end