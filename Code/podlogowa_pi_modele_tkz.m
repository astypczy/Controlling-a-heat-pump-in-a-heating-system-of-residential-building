clear all;
% close all;

czas = 2000000;
skok_czas = 1000000;

Tkz0 = 45;
TkzK = 50.5853;
dspr = 0.1;
k=(47.2601-42.1482)/dspr;
T_klasyczna = 54794.52;
T0_klasyczna = 547.9;

a_klasyczna = k*T0_klasyczna/T_klasyczna;
kp_klasyczna = 0.9/a_klasyczna;
ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);

fprintf('kp ZN: %i \n', kp_klasyczna);
fprintf('ki ZN: %i \n', ki_klasyczna);

sim("sim_podlogowa_model_tkz_pi.slx",czas);
figure(9);
plot(ans.tout,ans.kupfmuller,'g'),hold on, grid on;
% legend('Twew obiekt ', 'Twew ZN',  'Twew tuned');
%% tuned
kp_klasyczna = 0.00067503;
ki_klasyczna = 2.1388e-06;


% kp_klasyczna = 0.021;
% ki_klasyczna = 1.1049e-06;


sim("sim_podlogowa_model_tkz_pi.slx",czas);
figure(9);
plot(ans.tout,ans.kupfmuller,'b'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Regulacja pogodowa - inst. podlogowa - wykres Tkz');
legend('Tkz obiekt','Tkz-wyliczone','Tkz ZN', 'Tkz tuned');