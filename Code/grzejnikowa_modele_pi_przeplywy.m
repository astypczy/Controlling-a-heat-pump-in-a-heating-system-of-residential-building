clear all;
% close all;

czas = 600000;
skok_czas = 250000;
% delay = 1000;
delay = 0;

%% regulacja bojlera grzejnik pokojowa
% Tset_cwu = 45.402;
% dTcwu = 2.8860;
Tset_cwu = 45;
dTcwu = -3;
dRz_b = 20000;
k = (-33.3706+33.8892)/dRz_b;
% k = (33.3706-33.8892)/dRz_b;
T_klasyczna = 5149.25;
T0_klasyczna = 514.9;

%1. metoda zinglera nicholsa
a_klasyczna = k*T0_klasyczna/T_klasyczna;
kp_klasyczna = 0.9/a_klasyczna;
ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);

fprintf('kp ZN: %i \n', kp_klasyczna);
fprintf('ki ZN: %i \n', ki_klasyczna);

sim("sim_grzejnikowa_model_bojlera_pi.slx",czas);
figure(9);
plot(ans.tout(40005:100000),ans.kupfmuller(40005:100000),'r'),hold on, grid on;

% tuned przerobione
kp_klasyczna = -71228.0398;
ki_klasyczna =  -14.4269;
kp_klasyczna = 71228.0398;
ki_klasyczna =  14.4269;
sim("sim_grzejnikowa_model_bojlera_pi.slx",czas);
figure(9);
plot(ans.tout(40005:100000),ans.kupfmuller(40005:100000),'m'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Regulacja zaworem bojlera - inst. grzej. ');
% legend('Twew obiekt', 'Twew ZN', 'Twew tuned');
legend( 'Twew ZN1', 'Twew tuned1','Twew ZN2', 'Twew tuned2');
% legend('Tcwu ZN', 'Tcwu tuned');

%% regulacja bojlera grzejnik pogodowa
