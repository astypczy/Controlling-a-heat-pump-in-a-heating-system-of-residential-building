clear all;
% close all;

czas = 1600000;
skok_czas = 250000;
% delay = 1000;
delay = 0;

%% regulacja zawór pokoju
Twew0 = 20;
TwewK = 23;
dRz_g = 10000;
% k = (19.1038-20)/dRz_g;
k = (-19.1038+20)/dRz_g;
T_klasyczna = 2525.25;
T0_klasyczna = 252.5;

%1. metoda zinglera nicholsa
a_klasyczna = k*T0_klasyczna/T_klasyczna;
kp_klasyczna = 0.9/a_klasyczna;
ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);

fprintf('kp ZN: %i \n', kp_klasyczna);
fprintf('ki ZN: %i \n', ki_klasyczna);

sim("sim_grzejnikowa_modele_pi.slx",czas);
figure(11);
% plot(ans.tout(200001:600000),ans.kupfmuller(200001:600000),'g'),hold on, grid on;
plot(ans.tout,ans.kupfmuller,'r--'),hold on, grid on;

% %tuned przerobione

% kp_klasyczna = -63235.9139;
% ki_klasyczna = -19.3245;
% kp_klasyczna = -17141.5171;
% ki_klasyczna = -4.41364;

kp_klasyczna = -20608.4954;
ki_klasyczna =  -8.5117;
kp_klasyczna = 20608.4954;
ki_klasyczna =  8.5117;

sim("sim_grzejnikowa_modele_pi.slx",czas);
figure(11);
% plot(ans.tout(200001:600000),ans.kupfmuller(200001:600000),'b'),hold on, grid on;
plot(ans.tout,ans.kupfmuller,'m--'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Regulacja zaworem grzejnika - inst. grzej. ');
% legend('Twew obiekt', 'Twew ZN', 'Twew tuned');
legend('Twew ZN', 'Twew tuned','Twew ZN2', 'Twew tuned2');
% % %tuned nopminaslne
% kp_klasyczna = -14919.421;
% ki_klasyczna = -12.1516;
% 
% sim("sim_grzejnikowa_modele_pi.slx",czas);
% figure(30);
% plot(ans.tout,ans.kupfmuller,'m'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Regulacja zaworem grzejnika - inst. grzej. ');
% legend('Twew obiekt', 'Twew ZN', 'Twew tuned');
% legend('Twew ZN', 'Twew tuned1', 'Twew tuned2');