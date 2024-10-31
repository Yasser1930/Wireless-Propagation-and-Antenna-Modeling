% Paramètres du problème
f = 893e6; % Fréquence de fonctionnement en Hz
c = 3e8; % Vitesse de la lumière en m/s
h_antenna = 1.5; % Hauteur des antennes en m
wall_antenna = 2; % Distance de l'antenne aux murs latéraux en m
epsilon_floor = 12; % Permittivité relative du plancher
epsilon_wall = 3; % Permittivité relative des murs
%%%%%%%%%%%%%%%%%

% Distance de 1m à 9m avec une incrémentation de 1cm
distances = 1:0.01:9; 

% Calcul de la puissance reçue normalisée en tenant compte de la réflexion sur le plancher et les murs
received_power_dB_n1 = zeros(size(distances)); % Pour n = 1
received_power_dB_n3 = zeros(size(distances)); % Pour n = 3

for i = 1:length(distances)
    d = distances(i); % Distance entre les antennes
    lambda = c / f; % Longueur d'onde
    
    % Calcul de delta_l_floor (différence de chemin avec le plancher)
    delta_l_floor = d * sqrt(1 + (1/2) * ((2*h_antenna) / d)^2) - d * sqrt(1 + (1/2) * ((h_antenna-h_antenna) / d)^2);

    
    % Calcul de delta_phi_floor (angle de phase avec le plancher)
    delta_phi_floor = (2 * pi * delta_l_floor) / lambda;
    
    % Calcul de psi_floor (angle entre l'axe de l'antenne et le plan horizontal au niveau du plancher)
    psi_floor = atan2(h_antenna, d/2);
    G_n1_floor = (cos(psi_floor))^1; % Diagramme de rayonnement pour n = 1
    G_n3_floor = (cos(psi_floor))^3; % Diagramme de rayonnement pour n = 3
    
    % Calcul de theta_floor (angle d'incidence avec le plancher)
    theta_floor = pi/2 - psi_floor;
    
    % Calcul du coefficient de réflexion avec le plancher (R_floor)
    R_floor = ((epsilon_floor * cos(theta_floor)) - sqrt(epsilon_floor - (sin(theta_floor))^2)) / ...
              ((epsilon_floor * cos(theta_floor)) + sqrt(epsilon_floor - (sin(theta_floor))^2));
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Calcul de delta_l_wall (différence de chemin avec les murs)
    delta_l_wall1 = d * sqrt(1 + (1/2) * ((2*wall_antenna) / d)^2) - d * sqrt(1 + (1/2) * ((wall_antenna-wall_antenna) / d)^2);
    
    % Calcul de delta_phi_wall (angle de phase avec les murs)
    delta_phi_wall1 = (2 * pi * delta_l_wall1) / lambda;
    
    % Calcul de psi_wall (angle entre l'axe de l'antenne et le plan horizontal au niveau des murs)
    psi_wall1 = atan2(wall_antenna, d/2);
    G_n1_wall1 = (cos(psi_wall1))^1; % Diagramme de rayonnement pour n = 1
    G_n3_wall1 = (cos(psi_wall1))^3; % Diagramme de rayonnement pour n = 3
    
    % Calcul de theta_wall (angle d'incidence avec les murs)
    theta_wall1 = pi/2 - psi_wall1;
    
    % Calcul des coefficients de réflexion avec les murs (R_wall)
    R_wall1 = ((cos(theta_wall1)) - sqrt(epsilon_wall - (sin(theta_wall1))^2)) / ...
             ((cos(theta_wall1)) + sqrt(epsilon_wall - (sin(theta_wall1))^2));
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calcul de delta_l_wall (différence de chemin avec les murs)
    %delta_l_wall2 = 2 * (wall_antenna * wall_antenna) / d;
    delta_l_wall2 = d * sqrt(1 + (1/2) * ((2*wall_antenna) / d)^2) - d * sqrt(1 + (1/2) * ((wall_antenna-wall_antenna) / d)^2);
    
    % Calcul de delta_phi_wall (angle de phase avec les murs)
    delta_phi_wall2 = (2 * pi * delta_l_wall2) / lambda;
    
    % Calcul de psi_wall (angle entre l'axe de l'antenne et le plan horizontal au niveau des murs)
    psi_wall2 = atan2(wall_antenna, d/2);
    G_n1_wall2 = (cos(psi_wall2))^1; % Diagramme de rayonnement pour n = 1
    G_n3_wall2 = (cos(psi_wall2))^3; % Diagramme de rayonnement pour n = 3
    
    % Calcul de theta_wall (angle d'incidence avec les murs)
    theta_wall2 = pi/2 - psi_wall2;
    
    % Calcul des coefficients de réflexion avec les murs (R_wall)
    R_wall2 = ((cos(theta_wall2)) - sqrt(epsilon_wall - (sin(theta_wall2))^2)) / ...
             ((cos(theta_wall2)) + sqrt(epsilon_wall - (sin(theta_wall2))^2));
    
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Calcul de la magnitude de e
    e_n1_sur_e0 = (1 + G_n1_floor * R_floor * exp(-1i * delta_phi_floor) + G_n1_wall1 * R_wall1 * exp(-1i * delta_phi_wall1) + ...
    G_n1_wall2 * R_wall2 * exp(-1i * delta_phi_wall2)) ;

    e_n3_sur_e0 = (1 + G_n3_floor * R_floor * exp(-1i * delta_phi_floor) + G_n3_wall1 * R_wall1 * exp(-1i * delta_phi_wall1) + ...
    G_n3_wall2 * R_wall2 * exp(-1i * delta_phi_wall2)) ;
    
    % Calcul de la puissance reçue normalisée en dB pour n = 3
    received_power_dB_n1(i) = 10 * log10(abs(e_n1_sur_e0)^2);
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
