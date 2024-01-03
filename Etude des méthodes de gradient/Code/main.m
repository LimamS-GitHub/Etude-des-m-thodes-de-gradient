% Ce script MATLAB applique trois méthodes d'optimisation pour minimiser une fonction quadratique.

clear all;
close all;

% Paramètres de la fonction quadratique
rho = 0.5;
x0 = rand(2, 1) + 3;
A = [[2 -1]; [-1 2]];
b = A * [1; 2];
fp = @(x) A * x - b;
f = @(x) 1/2 * (A * x)' * x - b' * x;
tol = 10^-5;
Nmax = 100;

% Appliquer la méthode du gradient à pas constant pour minimiser la fonction
[x_I_1, x_f_1, n_iter_1] = gradientPasConstant(fp, rho, x0, tol, Nmax);

% Appliquer la méthode du gradient à pas optimal pour minimiser la fonction
[x_I_2, x_f_2, n_iter_2] = gradientPasOptimal(A, fp, x0, tol, Nmax);

% Appliquer la méthode du gradient conjugué pour minimiser la fonction
[x_I_3, x_f_3, n_iter_3] = gradientConjugue(A,b,x0,tol,Nmax);

% Générer une grille pour évaluer la fonction sur un ensemble de points
x1 = linspace(0, 4, 40);
y1 = linspace(1, 4, 40);
for i = 1:length(x1)
    for j = 1:length(y1)
        x = [x1(i); y1(j)];
        tab_f(i, j) = f(x);
    end
end

% Créer une surface 3D représentant la fonction
[X1, Y1] = meshgrid(x1, y1);
surf(X1, Y1, tab_f')

% Calculer les valeurs de la fonction objectif pour les points obtenus
for i = 1:n_iter_1
    f_xI_1(i) = f(x_I_1(:, i));
end
for i = 1:n_iter_2
    f_xI_2(i) = f(x_I_2(:, i));
end
for i = 1:n_iter_3
    f_xI_3(i) = f(x_I_3(:, i));
end

% Utiliser plot3 pour afficher le chemin de convergence en rouge, bleu et vert
hold on;
plot3(x_I_1(1, :), x_I_1(2, :), f_xI_1, "r", "LineWidth", 2);

plot3(x_I_2(1, :), x_I_2(2, :), f_xI_2, "b", "LineWidth", 2);

plot3(x_I_3(1, :), x_I_3(2, :), f_xI_3, "g", "LineWidth", 2);

% Modification des paramètres initiales pour tester les algorithmes sur la matrice A = -Laplacien
N=50;
h=1/(N+1);
A = Lap1D(N,h);
solution_exacte=ones(N,1);
b = A*solution_exacte;
x_0=zeros(N,1);
fp = @(x) A * x - b;
erreur_initial = norm(x_0-solution_exacte)
tol = erreur_initial/10^(5)

% Appliquer la méthode du gradient à pas optimal
[Iter_solution, final_solution, nb_Itere] = gradientPasOptimal2(A, fp, x_0, tol, Inf,solution_exacte);

% Appliquer la méthode du gradient conjugué
[Iter_solution2, final_solution2, nb_Itere2] = gradientConjugue2(A, b, x_0, tol, Inf,solution_exacte);
[Iter_solution1, final_solution1, nb_Itere1] = gradientPasConstant(fp, rho, x_0, tol, Nmax);
% Afficher les résultats pour les deux méthodes
printf("\nle nombre d'itération pour que l'erreur initiale soit divisé par 10^5 pour la methode du gradientPasOptimal est %d \n",nb_Itere)
printf("le nombre d'itération pour que l'erreur initiale soit divisé par 10^5 pour la méthode du gradientConjugue est %d\n",nb_Itere2)

erreur_gradientConjugue = norm(final_solution2-solution_exacte,2)
erreur_gradientPasOptimal = norm(final_solution2-solution_exacte,2)
