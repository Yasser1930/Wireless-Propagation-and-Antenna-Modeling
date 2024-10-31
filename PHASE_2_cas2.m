% Paramètres du problème
f = 893e6; % Fréquence de fonctionnement en Hz
c = 3e8; % Vitesse de la lumière en m/s
h_antenna = 1.5; % Hauteur des antennes en m
reflection_coefficient = -1; % Coefficient de réflexion du plancher

% Distance de 1m à 9m avec une incrémentation de 1cm
distances = 1:0.01:9; 

% Calcul de la puissance reçue normalisée en tenant compte de la réflexion sur le plancher
received_power_dB_n1 = zeros(size(distances)); % Pour n = 1
received_power_dB_n3 = zeros(size(distances)); % Pour n = 3

for i = 1:length(distances)
    d = distances(i); % Distance entre les antennes
    lambda = c / f; % Longueur d'onde
    
    % Calcul de delta_l (différence de chemin)
    delta_l = d * sqrt(1 + (1/2) * ((2*h_antenna) / d)^2) - d * sqrt(1 + (1/2) * ((h_antenna-h_antenna) / d)^2);

    
    % Calcul de delta_theta (angle de phase)
    delta_phi = (2 * pi * delta_l) / lambda;
    
    % Diagramme de rayonnement
    psi = atan2(h_antenna, d/2); % Angle entre l'axe de l'antenne et le plan horizontal
    G_n1 = (cos(psi))^1; % Diagramme de rayonnement pour n = 1
    G_n3 = (cos(psi))^3; % Diagramme de rayonnement pour n = 3
    
    % Calcul de la magnitude de e pour n = 1
    e_n1_sur_e0 = (1 + G_n1 * reflection_coefficient * exp(-1i * delta_phi));
   
    
    % Calcul de la magnitude de e pour n = 3
    e_n3_sur_e0 = (1 + G_n3 * reflection_coefficient * exp(-1i * delta_phi));
    
    % Calcul de la puissance reçue normalisée en dB pour n = 1
    received_power_dB_n1(i) = 10 * log10(abs(e_n1_sur_e0)^2);
    
    % Calcul de la puissance reçue normalisée en dB pour n = 3
    received_power_dB_n3(i) = 10 * log10(abs(e_n3_sur_e0)^2);
end

% Dessiner le profil de la puissance reçue en fonction de la distance
figure;
plot(distances, received_power_dB_n1, 'b', 'LineWidth', 2);
hold on;
plot(distances, received_power_dB_n3, 'r', 'LineWidth', 2);
xlabel('Distance (m)');
ylabel('Puissance reçue (dB)');
title('Profil de la puissance reçue en fonction de la distance');
legend('n = 1', 'n = 3');
grid on;
hold off;
