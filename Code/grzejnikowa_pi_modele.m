clear all;
% close all;

czas = 400000;
skok_czas = 200000;
% delay = 1000;
delay = 0;

%% regulacja pokojowa
% modele po skoku na mocy qk

dspr = 0.1;
k = (21.2138-18.4671)/dspr;
T_klasyczna = 25641.03;
T0_klasyczna = 256;
TwewK = 23;


%1. metoda zinglera nicholsa
a_klasyczna = k*T0_klasyczna/T_klasyczna;
kp_klasyczna = 0.9/a_klasyczna;
ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);

% fprintf('kp ZN: %i \n', kp_klasyczna);
% fprintf('ki ZN: %i \n', ki_klasyczna);

sim("sim_grzejnikowa_modele_pi.slx",czas);
figure(9);
plot(ans.tout,ans.kupfmuller,'g'),hold on, grid on;

%tuned przerobione

% kp_klasyczna = 0.064245;
% ki_klasyczna = 2.5015e-06;

kp_klasyczna = 0.077475;
ki_klasyczna = 9.5776e-06;

sim("sim_grzejnikowa_modele_pi.slx",czas);
figure(9);
plot(ans.tout,ans.kupfmuller,'b'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Regulacja pokojowa - inst. grzej. ');
legend('Twew obiekt', 'Twew ZN', 'Twew tuned');

%% regulacja pogodowa
