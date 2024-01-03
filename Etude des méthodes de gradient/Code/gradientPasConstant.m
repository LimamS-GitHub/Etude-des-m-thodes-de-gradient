function [x,xN,n] = gradientPasConstant (fp,rho,x0,tol,Nmax)
  n = 1;
  x(:,n) = x0;

  while norm(fp(x(:,n)))>tol && n<Nmax
    x(:,n+1) = x(:,n) - rho*fp(x(:,n));
    n = n+1;
  endwhile

  xN = x(:,end);
end
