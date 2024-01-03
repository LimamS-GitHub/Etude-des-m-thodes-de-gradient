clear all;
close all;

% Initialiser les paramètres du problème
rho = 0.5;
x0 = 2 * rand(2, 1); % Initialiser x0 avec des valeurs aléatoires
A = [[2 -1]; [-1 2]];
b = A * [1; 2];
fp = @(x) A * x - b; % Définir la fonction à minimiser
tol = 10^-14; % Tolérance pour la convergence
Nmax = 100; % Nombre maximal d'itérations
x_s = [1; 2]; % Solution cible

% Appliquer la méthode du gradient à pas constant pour minimiser la fonction
[x_I_1, x_f_1, n_iter_1] = gradientPasConstant(fp, rho, x0, tol, Nmax);

% Appliquer la méthode du gradient à pas optimal pour minimiser la fonction
[x_I_2, x_f_2, n_iter_2] = gradientPasOptimal(A, fp, x0, tol, Nmax);

% Appliquer la méthode du gradient conjugué pour minimiser la fonction
[x_I_3, x_f_3, n_iter_3] = gradientConjugue(A, b, x0, tol, Nmax);

% Calculer les erreurs de chaque méthode par rapport à la solution cible
for i = 1 : n_iter_1
    E1(i) = norm(x_I_1(:, i) - x_s, 2);
end

for i = 1 : n_iter_2
    E2(i) = norm(x_I_2(:, i) - x_s, 2);
end

for i = 1 : n_iter_3
    E3(i) = norm(x_I_3(:, i) - x_s, 2);
end

% Tracer les erreurs en échelle logarithmique avec les noms des axes
figure;
semilogy(1:n_iter_1, E1, 'r', 1:n_iter_2, E2, 'b', 1:n_iter_3, E3, 'g');
legend("Gradient Pas Constant", "Gradient Pas Optimal", "Gradient Conjugué");
xlabel('Nombre d''itérations');
ylabel('Erreur (échelle logarithmique)');
title('Convergence des méthodes de gradient');

