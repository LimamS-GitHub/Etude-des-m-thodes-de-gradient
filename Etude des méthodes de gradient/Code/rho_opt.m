clear all;
close all;
x0 = zeros(2,1);
A = [[2 -1];[-1 2]];
b = A*[1;2];
fp = @(x) A*x-b;
tol = 10^-5;
Nmax = 100;
x_s = [1;2];
rho = linspace(0,1,100);
i = 0;
for rho_i = rho
  i = i+1;
  [xp,xN] = gradientPasConstant (fp,rho_i,x0,tol,Nmax);
  R(i) = norm(x_s-xN,2)/norm(x_s-xp(:,end-1),2);
end

plot(rho,R);
min(R)