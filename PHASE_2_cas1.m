% Paramètres du problème
f = 893e6; % Fréquence de fonctionnement en Hz
c = 3e8; % Vitesse de la lumière en m/s
h_antenna = 1.5; % Hauteur des antennes en m
reflection_coefficient = -1; % Coefficient de réflexion du plancher

% Distance de 1m à 9m avec une incrémentation de 1cm
distances = 1:0.01:9; 

% Calcul de la puissance reçue normalisée en tenant compte de la réflexion sur le plancher
received_power_dB = zeros(size(distances));

for i = 1:length(distances)
    d = distances(i); % Distance entre les antennes
    lambda = c / f; % Longueur d'onde
    delta_l = d * sqrt(1 + (1/2) * ((2*h_antenna) / d)^2) - d * sqrt(1 + (1/2) * ((h_antenna-h_antenna) / d)^2);
    delta_phi = (2 * pi * delta_l) / lambda; % Angle de phase
    
    % Calculate the magnitude of e
    e0 = 1; % Pour une antenne omnidirectionnelle
    e = e0 * sqrt(1 + abs(reflection_coefficient)^2 + 2 * abs(reflection_coefficient) * cos(delta_phi + angle(reflection_coefficient))); % Module de e
    
    % Calculate the normalized received power in dB
    received_power_dB(i) = 10 * log10(abs(e)^2 / abs(e0)^2); % Puissance reçue en dB

    
end

% Dessiner le profil de la puissance reçue en fonction de la distance
figure;
plot(distances, received_power_dB, 'b', 'LineWidth', 2);
xlabel('Distance (m)');
ylabel('Puissance reçue (dB)');
title('Profil de la puissance reçue en fonction de la distance');
grid on;
