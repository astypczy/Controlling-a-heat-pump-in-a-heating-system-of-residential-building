clear all;
% close all;

czas = 2000000;
skok_czas = 1000000;

dspr = 0.1;
TwewK = 23;

k=(21.2138-18.4692)/dspr;
T_klasyczna = 156666.67;
% T0_klasyczna = 1001040;
T0_klasyczna = 3420;
T_dwupunkt = 1.5*(93396.2-25471.65);
% T0_dwupunkt = 93396.2 - T_dwupunkt;
T0_dwupunkt = 102396.2 - T_dwupunkt;

a_klasyczna = k*T0_klasyczna/T_klasyczna;
kp_klasyczna = 0.9/a_klasyczna;
ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);

% fprintf('kp ZN: %i \n', kp_klasyczna);
% fprintf('ki ZN: %i \n', ki_klasyczna);

sim("sim_podlogowa_modele_pi.slx",czas);
figure(9);
plot(ans.tout,ans.kupfmuller,'g'),hold on, grid on;

% %tuned2
kp_klasyczna = 0.089526;
ki_klasyczna = 1.4872e-06;

sim("sim_podlogowa_modele_pi.slx",czas);
figure(9);
plot(ans.tout,ans.kupfmuller,'b'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Regulacja pokojowa - inst. podłogowa. ');
legend('Twew obiekt ', 'Twew ZN',  'Twew tuned');