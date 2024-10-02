clear all;
% close all;

czas = 850000;
skok_czas = 600000;
% delay = 1000;
delay = 0;

%% regulacja bojlera grzejnik pokojowa
Tset_cwu = 45;
dTcwu = -3;
dRz_b = 20000;
k = (33.3706-33.8892)/dRz_b;
T_klasyczna = 5149.25;
T0_klasyczna = 514.9;

%1. metoda zinglera nicholsa
a_klasyczna = k*T0_klasyczna/T_klasyczna;
kp_klasyczna = 0.9/a_klasyczna;
ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);

fprintf('kp ZN: %i \n', kp_klasyczna);
fprintf('ki ZN: %i \n', ki_klasyczna);

sim("sim_grzejnikowa_model_bojlera_pi.slx",czas);
figure(15);
plot(ans.tout(110002:170000),ans.kupfmuller(110002:170000),'g'),hold on, grid on;

% %tuned przerobione
% 
% kp_klasyczna = -136039.74;
% ki_klasyczna = -43.2016;
% 
% sim("sim_grzejnikowa_model_bojlera_pi.slx",czas);
% figure(30);
% plot(ans.tout(110002:170000),ans.kupfmuller(110002:170000),'b'),hold on, grid on;
% 
% % kp_klasyczna = -51565.4601;
% % ki_klasyczna = -20.5965;

kp_klasyczna = -71228.0398;
ki_klasyczna =  -14.4269;

sim("sim_grzejnikowa_model_bojlera_pi.slx",czas);
figure(15);
plot(ans.tout(110002:170000),ans.kupfmuller(110002:170000),'m'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Regulacja zaworem bojlera - inst. podl. ');
legend('Twew obiekt', 'Twew ZN', 'Twew tuned');
% legend('Tcwu ZN', 'Tcwu tuned1', 'Tcwu tuned2');
