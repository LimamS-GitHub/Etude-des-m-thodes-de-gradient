function A = Lap1D(N,h)
  A = diag(ones(1,N)*2/h^2);
  for i = 1:N-1
    A(i,i+1) = -1/h^2;
    A(i+1,i) = -1/h^2;
  endfor
end

