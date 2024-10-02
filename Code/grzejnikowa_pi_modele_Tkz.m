clear all;
% close all;
% czas = 500000;
czas = 700000;
skok_czas = 300000;
% delay = 1000;
delay = 0;
% modele po skoku na mocy qk
% qk_skok = 700;
Tkz0 = 45;
TkzK = 50.5862;
dspr = 0.1;
k = (47.2603-42.1458)/dspr;

T_klasyczna =29629.6;
T0_klasyczna = 296.3;

%1. metoda zinglera nicholsa
a_klasyczna = k*T0_klasyczna/T_klasyczna;
kp_klasyczna = 0.9/a_klasyczna;
ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);

sim("sim_grzejnikowa_modele_piTkz.slx",czas);
figure(7);
plot(ans.tout,ans.kupfmuller,'g'),hold on, grid on;
% 
% %% tuned 
% kp = 0.025797;
% ki = 1.9551e-06;
% 
% kp_klasyczna = kp;
% ki_klasyczna = ki;
% 
% sim("sim_grzejnikowa_modele_piTkz.slx",czas);
% figure(7);
% plot(ans.tout,ans.kupfmuller,'b'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Regulacja pogodowa - inst. grzej. - wykres Tkz');
% % legend('Tkz real','Tkz wyliczone', 'Tkz ZN', 'Tkz tuned 1', 'Tkz tuned 2');
% legend('Tkz','Tkz - wyliczone','Tkz ZN', 'Tkz tuned');
% 
% 
% 
% 
% 
