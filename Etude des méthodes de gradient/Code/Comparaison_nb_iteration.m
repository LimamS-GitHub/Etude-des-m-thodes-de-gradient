clear all;
close all;

% Paramètres de la fonction quadratique
rho = 0.5;
A = [[2 -1]; [-1 2]];
b = A * [1; 2];
fp = @(x) A * x - b;
f = @(x) 1/2 * (A * x)' * x - b' * x;
tol = 10^-5;
Nmax = 1000;
N = 2;
for i = 1 : Nmax

  x0=rand(N,1)*100+5;
  fp = @(x) A * x - b;

  % Appliquer la méthode du gradient à pas constant pour minimiser la fonction
  [x_I_1, x_f_1, n_iter_1] = gradientPasConstant (fp,rho,x0,tol,2500);

  % Appliquer la méthode du gradient à pas optimal pour minimiser la fonction
  [x_I_2, x_f_2, n_iter_2] = gradientPasOptimal(A, fp, x0, tol, 2500);

  % Appliquer la méthode du gradient conjugué pour minimiser la fonction
  [x_I_3, x_f_3, n_iter_3] = gradientConjugue(A,b,x0,tol,2500);

  Nb_iter(i,1) = n_iter_1;
  Nb_iter(i,2) = n_iter_2;
  Nb_iter(i,3) = n_iter_3;
  i
end

figure 2;
plot (1:Nmax,Nb_iter(:,1),'r',1:Nmax,Nb_iter(:,2),'g',1:Nmax,Nb_iter(:,3),'b');
legend("Gradient Pas Constant", "Gradient Pas Optimal", "Gradient Conjugué");

Moy_nb_iter_1 = mean(Nb_iter(:,1))
Moy_nb_iter_2 = mean(Nb_iter(:,2))
Moy_nb_iter_3 = mean(Nb_iter(:,3))
%2>3>1>3
if Moy_nb_iter_1 > Moy_nb_iter_2
  if Moy_nb_iter_1 < Moy_nb_iter_3
    printf("gradient Optimal est meilleur que gradient Pas Constant est meilleur que gradient Conjugue");
  else
    if Moy_nb_iter_2 < Moy_nb_iter_3
      printf("gradient Pas Optimal est meilleur que gradient Conjugue est meilleur que gradient Pas Constant");
    else
      printf("gradient conjugue est meilleur que gradient Pas Optimal est meilleur que gradient Pas Constant\n");
    end
  end
else
  if Moy_nb_iter_2 < Moy_nb_iter_3
    printf("gradient Pas Constant est meilleur que gradient Pas Optimal est meilleur que gradient Conjugue");
  else
    if Moy_nb_iter_1 < Moy_nb_iter_3
      printf("gradient Pas constant est meilleur que gradient Conjugue est meilleur que gradient Pas Optimal");
    else
      printf("gradient Conjugue est meilleur que gradient Pas Constant est meilleur que gradient Pas Optimal");
    end

  end
end

