function [x,xN,n] = gradientPasOptimal2 (A,fp,x0,tol,Nmax,solution)
  n = 1;
  x(:,n) = x0;
  while norm(x(:,n)-solution)>tol && n<Nmax

    rho_n = norm(fp(x(:,n)))^2/(fp(x(:,n))'*(A*fp(x(:,n))));
    x(:,n+1) = x(:,n) - rho_n * fp(x(:,n));
    n = n+1;

  end
  xN = x(:,end);
end
