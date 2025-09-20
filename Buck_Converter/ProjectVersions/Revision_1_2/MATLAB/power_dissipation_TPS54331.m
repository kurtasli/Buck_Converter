%{

This code aims to calculate a buck converters power dissipation

%}

V_out = 3.3;                                            % Output Voltage - 3.3V
V_in = 3.5:0.5:28;                                      % from 3.5V to 28V, step value is 0.1V
I_out = 3;                                              % Output Current - 3A
f_sw = 570e3;                                           % Switching Frequency - 570kHz
R_ds_on = 0.05;                                         % MOSFET on-resistance - 50mohm


Efficiency = zeros( size( V_in ) );                     % Efficiency = η
% Create zeros matrix for each V_in value


for i = 1:length(V_in)
    % Power Loss Calculation

    P_con = (I_out)^2 * R_ds_on * (V_out / V_in(i));    % Conduction Loss
    P_sw  = 0.5e-9 * (V_in(i))^2 * I_out * f_sw;        % Switching Loss
    P_gc  = 22.8e-9 * f_sw;                             % Gate Charge Loss
    P_qc  = 0.11e-3 * V_in(i);                          % Quiescent Current Loss
    P_tot = P_con + P_sw + P_gc + P_qc;                 % Total Loss


    P_out = V_out * I_out;                              % Output Power
    % P = V*I

    Efficiency(i) = P_out / (P_out + P_tot) * 100;      % Efficiency = η%
    % η = (P_out) / (P_out + P_tot)
end

%Plot Settings
figure;
grid on;
plot(V_in, Efficiency, 'LineWidth', 2);           % Plot efficiency graph
xlabel('Input Voltage VIN (V)', 'FontSize', 12, 'FontWeight', 'bold');                        % Set x-axis label
ylabel('Efficiency (%)', 'FontSize', 12, 'FontWeight', 'bold');                               % Set y-axis label 
title('VIN-Efficiency', 'FontSize', 14, 'FontWeight', 'bold');                                % Set title


