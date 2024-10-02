clear all;
% close all;

czas = 1500000;
skok_czas = 600000;
% delay = 1000;
delay = 0;

%% regulacja zawór pokoju
Twew0 = 20;
TwewK = 23;
dRz_p = 10000;
k = (19.1038-20)/dRz_p;
T_klasyczna = 33139.53;
T0_klasyczna = 331.14;

%1. metoda zinglera nicholsa
a_klasyczna = k*T0_klasyczna/T_klasyczna;
kp_klasyczna = 0.9/a_klasyczna;
ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);

fprintf('kp ZN: %i \n', kp_klasyczna);
fprintf('ki ZN: %i \n', ki_klasyczna);

sim("sim_grzejnikowa_modele_pi.slx",czas);
figure(20);
plot(ans.tout(110002:200000),ans.kupfmuller(110002:200000),'g'),hold on, grid on;

% % %tuned 1
% % kp_klasyczna = -157428.0727;
% % ki_klasyczna = -6.8784;
% kp_klasyczna = -11978.3307;
% ki_klasyczna = -1.0421;
% 
% kp_klasyczna = -114327.3541;
% ki_klasyczna = -12.0863;
% 
% sim("sim_grzejnikowa_modele_pi.slx",czas);
% figure(30);
% plot(ans.tout,ans.kupfmuller,'b'),hold on, grid on;

% %tuned 2
kp_zaw_podloga = 0;
ki_zaw_podloga = -1.1498;

kp_klasyczna = -199012.2254;
ki_klasyczna = -1.8719;

% kp_klasyczna = -59326.0324;
% ki_klasyczna = -0.02772;
kp_klasyczna = -11978.3307;
ki_klasyczna = -1.0421;


sim("sim_grzejnikowa_modele_pi.slx",czas);
figure(20);
plot(ans.tout(110002:200000),ans.kupfmuller(110002:200000),'m'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Regulacja zaworem podlogowki - zmiana zadanej Twew');
legend('Twew obiekt', 'Twew ZN', 'Twew tuned');
% legend('Twew ZN', 'Twew tuned1', 'Twew tuned2');