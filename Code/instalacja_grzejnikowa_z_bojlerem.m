clear all;
close all;

czas = 2000000;
skok_czas = 500000;
skok_czas2 = 1500000;
delay = 1000;

cp = 1000;   %ciepło wlaściwe powietrza
pp = 1.2;    %gęstość powietrza
cpw = 4175;  %ciepło wlaściwe wody
pw = 960;    %gęstość wody
cps = 840;   %ciepło wlaściwe betonu komórkowego
ps = 800;    %gęstość betonu komórkowego
TzewN = -9; %°C nominalna
TwewN = 20;  %°C
TgzN = 45;   %°C
TkzN = 45;   %temp wody wyplywajacej z kotla nominalna
TrzN = TkzN;
TgpN = 35;   %°C 
TrpN = TgpN;
TkpN = 35;   %temp wody wplywajacej do kotla nominalna
TsN = 5;     %°C temp. ścian \
qgN = 7000;  %W zapotrzebowanie pokoju 
qbN = 2700;  %W bojlera
qkN = 1*qgN+1*qbN; %W moc kotla
qtN = 0;     %W
qtbN = 0;
qtb2N = 0;
TcwuN = 15; 

Vp = 7.5*10*2.5;      %objętość pokoju
Vs = (7.5+0.5)*10.5*3-Vp; %objętość ścian
Vg = 60*0.001;      %objętość grzejnika 60 litrów wody
Vk = 120*0.001;     %pojemność kotła 120l
Vb = 100*0.001; %objętość bojlera 100litrów
Vr = 3.14*(31.75*0.001)^2*2.6; % pojemność wody w wężownicy

fmgN = qgN/(cpw*(TgzN-TgpN));
% fmgN = qkN/(cpw*(TgzN-TgpN));
fmbN = qbN/(cpw*(TrzN-TrpN));
fmkN = fmgN + fmbN;

Kcw = (qgN+qtN)/(TwewN - TsN);
Kcs = (qgN+qtN)/(TsN-TzewN);
Kcg = qgN/(TgpN - TwewN);
Kcr = cpw*fmbN*(TrzN - TrpN)/(TrpN - TcwuN);


Cvw = cp*pp*Vp;   %pojemność cieplna powietrza w pomieszczeni7u
Cvg = cpw*pw*Vg;  %pojemność cieplna wody w grzejniku 
Cvk = cpw*pw*Vk;  %pojemność cieplna wody w kotle 
Cvs = cps*ps*Vs;
Cvr = cpw*pw*Vr;  %pojemność cieplna wody w wężownicy
Cvcwu = cpw*pw*Vb;  %pojemność cieplna wody w bojlerze 

Tgp0 = TgpN;
Twew0 = TwewN;
Tkz0 = TkzN;
Ts0 = TsN;
Tcwu0 = TcwuN;
Trp0 = TrpN;
Tset_cwu = 45; 

dqt = 0;
dTzew = 0;
dfmg = 0*fmgN;
dfmb = 0;
dqtb = 0; %ujemny skok symuluje utratę ciepła (wypływ ciepłej wody)
dqtb2 = 0;
dTset_cwu = 0;
qk_skok = 0*qgN;
dspr = 0;

dpoN1 = 10000;
dpoN = 1*dpoN1; % Pascali ciśnienie wytwarzane przez pompę
a = 0.1; % współczynnik
dpkN = a * dpoN; % Pascali spadek ciśnienia na pompie ciepła
zmiana_po = 0;
Rk = a * dpoN /fmkN; % opór kotła/pompy
Rg = (dpoN-dpkN)/fmgN;
Rb = (dpoN-dpkN)/fmbN;
RzN = 0; % zawór całkowicie otwarty
dRz_g = 0;
dRz_b = 0;

%tuned bojler
kp_klasyczna = -35608.4948;
ki_klasyczna = -5.8503;

kp_klasyczna = -11472.4628;
ki_klasyczna = -8.8876;

kp_zaw_bojler = kp_klasyczna;
ki_zaw_bojler = ki_klasyczna;

dTcwu = 0;

model = "sim_instalacja_grzejnikowa_z_bojlerem.slx";

sim(model,czas);
figure(1);
plot(ans.tout,ans.Twew,'r'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Identyfikacja po Twew - Rg = 30000');
legend('Twew');

figure(2);
plot(ans.tout,ans.Tcwu,'r'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Identyfikacja po Tcwu - Rg = 30000');
legend('Tcwu');
% figure(1);
% plot(ans.tout,ans.Twew,'r'),hold on, grid on;
% plot(ans.tout,ans.Tgp,'g'),hold on, grid on;
% plot(ans.tout,ans.Ts,'b'),hold on, grid on;
% plot(ans.tout,ans.Tkz,'m'),hold on, grid on;
% plot(ans.tout,ans.Trp,'k'),hold on, grid on;
% plot(ans.tout,ans.Tcwu,'c'),hold on, grid on;
% legend('Twew','Tgp','Ts','Tkz','Trp','Tcwu');
% 
% figure(2);
% plot(ans.tout,ans.qk),hold on, grid on;
% legend('qk');
% 
% figure(3);
% plot(ans.tout,ans.kw),hold on, grid on;
% legend('kw');
% 
% figure(4);
% plot(ans.tout,ans.COP),hold on, grid on;
% legend('COP');
% 
% figure(5);
% plot(ans.tout,ans.Tcwu),hold on, grid on;
% 
% figure(6);
% plot(ans.tout,ans.Rzb),hold on, grid on;
% legend('Rzb');
% 
% figure(7);
% plot(ans.tout,ans.f_bojler,'r'),hold on, grid on;
% plot(ans.tout,ans.f_dom,'b'),hold on, grid on;
% plot(ans.tout,ans.f_pompa,'g'),hold on, grid on;
% legend('f bojler','f dom', 'f pompa');

Dkwh = sum(ans.kw)/length(ans.kw);
fprintf('Nominal average energy consumption kwh: %i \n', Dkwh);

%% model grzejnika
% k = (18.2077-19.0207)/dRz_b;
% T_klasyczna = 5723.3;
% T0_klasyczna = 572.3;
% 
% sim("sim_grzejnikowa_model_bojlera.slx", czas);
% figure(2);
% plot(ans.tout,ans.kupfmuller,'b'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Identyfikacja po Tcwu - Rb = 30000');
% legend('Tcwu', 'Tcwu kupf');



% %1. metoda zinglera nicholsa
% a_klasyczna = k*T0_klasyczna/T_klasyczna;
% kp_klasyczna = 0.9/a_klasyczna;
% ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);
% 
% %tuned1
% kp_klasyczna = -49351.5732;
% ki_klasyczna = -17.7273;
% %tuned2
% kp_klasyczna = -66488.671;
% ki_klasyczna = -11.0462;
% %tuned3
% kp_klasyczna = -35608.4948;
% ki_klasyczna = -5.8503;
% 
% TcwuK = 44;
% czas = 860000;
% sim("sim_grzejnikowa_model_bojlera_pi.slx", czas);
% figure(8);
% plot(ans.tout,ans.kupfmuller),hold on, grid on;
% legend('Tcwu kupf');
% 
% figure(9);
% plot(ans.tout,ans.uchyb_klasyczna),hold on, grid on;
% legend('uchyb');

