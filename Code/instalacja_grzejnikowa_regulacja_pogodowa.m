clear all;
% close all;

czas = 2000000;
skok_czas = 1000000;
skok_czas0 = 500000; %czas skoku Tzew
% skok_czas2 = 10000;
skok_czas2 = 250000;
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
qtbN = -100;
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
% Tset_cwu = 43.1454; 
Tset_cwu = 30; 

% Tgp0 = fmgN/fmkN*qkN*(1/Kcg+1/Kcw+1/(Kcs+1-Kcw))+Kcs/(Kcs+1-Kcw)*TzewN;
% Tkz0 = (qkN+cpw*fmkN*Tgp0)/(cpw*fmkN); %może do poprawy
% Ts0 = (cpw*fmgN*(Tkz0-Tgp0)+Kcs*TzewN)/(Kcs+1-Kcw);
% Twew0 = (cpw*fmgN*(Tkz0-Tgp0)+Kcw*Ts0)/Kcw;

% Tgp0 = qgN*(1/Kcg+1/Kcw+1/(Kcs+1-Kcw))+Kcs/(Kcs+1-Kcw)*TzewN;
% Tkz0 = (qgN)/(cpw*fmgN) +Tgp0; %może do poprawy
% Ts0 = (cpw*fmgN*(Tkz0-Tgp0)+Kcs*TzewN)/(Kcs+1-Kcw);
% Twew0 = (cpw*fmgN*(Tkz0-Tgp0)+Kcw*Ts0)/Kcw;
% Tcwu0 = TcwuN;
% Trp0 = TrpN;

dqt = 0;
dTzew = 5;
dfmg = 0*fmgN;
dfmb = 0;
dqtb = 0; %ujemny skok symuluje utratę ciepła (wypływ ciepłej wody)
dqtb2 = 0;
dTset_cwu = 0;
qk_skok = 0*qgN;
dspr = 0;
dRz_g = 0;
dRz_b = 0;
Tzadana0 = 20;
TwewK = 20;
dTcwu = 5;

az=(TgzN-TzewN)/(TwewN-TzewN);
bz=(TgzN-TwewN)/(TwewN-TzewN);

ap=(TgpN-TzewN)/(TwewN-TzewN);
bp=(TgpN-TwewN)/(TwewN-TzewN);

az_bojlera =(TrzN-TzewN)/(TcwuN-TzewN);
bz_bojlera =(TrzN-TcwuN)/(TcwuN-TzewN);

ap_bojlera =(TrpN-TzewN)/(TcwuN-TzewN);
bp_bojlera =(TrpN-TcwuN)/(TcwuN-TzewN);

dpoN1 = 10000;
dpoN = 1*dpoN1; % Pascali ciśnienie wytwarzane przez pompę
a = 0.1; % współczynnik
dpkN = a * dpoN; % Pascali spadek ciśnienia na pompie ciepła
zmiana_po = 0;
Rk = a * dpoN /fmkN; % opór kotła/pompy
Rg = (dpoN-dpkN)/fmgN;
Rb = (dpoN-dpkN)/fmbN;
RzN = 0; % zawór całkowicie otwarty

model = "sim_instalacja_grzejnikowa_regulacja_pogodowa.slx";

%ostateczne
kp_main = 0.025797;
ki_main = 1.9551e-06;

%tuned bojler
%tuned bojler
kp_klasyczna = -71228.0398;
ki_klasyczna =  -14.4269;

kp_zaw_bojler = kp_klasyczna;
ki_zaw_bojler = ki_klasyczna;

%tuned domek
kp_klasyczna = -20608.4954;
ki_klasyczna =  -8.5117;

kp_zaw_grzejnik = kp_klasyczna;
ki_zaw_grzejnik = ki_klasyczna;

sim(model,czas);
figure(1);
plot(ans.tout(100100:110000),ans.Twew(100100:110000),'b'),hold on, grid on;

figure(2);
plot(ans.tout(100100:110000),ans.Tcwu(100100:110000),'b'),hold on, grid on;

figure(3);
plot(ans.tout(100100:110000),ans.Tkz(100100:110000),'b'),hold on, grid on;

Dkwh = sum(ans.kw)/length(ans.kw);
fprintf('Nominal average energy consumption kwh: %i \n', Dkwh);

Dkwh = sum(ans.kw+ans.kw_q_grz)/length(ans.kw);
fprintf('heat pump and heater: Average energy consumption kwh: %i \n', Dkwh);

Dkwh = 0;
for i = 100100:110000
    Dkwh = Dkwh + ans.qk(i)/ans.COP(i);
end
Dkwh = Dkwh/length(100100:110000);
fprintf('COP: heat pump: Average energy consumption kwh: %i \n', Dkwh);

Dkwh = Dkwh + sum(ans.kw_q_grz(100100:110000))/length(ans.kw(100100:110000));
fprintf('COP: heat pump and heater: Average energy consumption kwh: %i \n', Dkwh);
%% modele po tkz
% dspr = 0.1;
% k = (47.2603-42.1458)/dspr;
% 
% T_klasyczna = 29629.6;
% % T_klasyczna = 59629.6;
% % T0_klasyczna = 800010;
% T0_klasyczna = 296.3;
% 
% sim("sim_instalacja_grzejnikowa_modele_Tkz.slx",czas);
% figure(5);
% plot(ans.tout,ans.kupfmuller,'b'),hold on, grid on;
% % plot(ans.tout,ans.dwupunktowa,'b'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Identyfikacja po Tkz - Skok o 10%');
% % legend('Twew', 'Twew kupf', 'Twew dwupkt');
% legend('Tkz', 'Tkz kupf');
% % legend('Tkz');


%% model bojera
% dRz_b = 30000;
% k = (25.4256-26.2157)/dRz_b;
% T_klasyczna = 6400;
% T0_klasyczna = 640;
% 
% sim("sim_grzejnikowa_model_bojlera.slx", czas);
% figure(8);
% plot(ans.tout,ans.kupfmuller,'b'),hold on, grid on;
% legend('Tcwu', 'Tcwu kupf');
% 
% %1. metoda zinglera nicholsa
% a_klasyczna = k*T0_klasyczna/T_klasyczna;
% kp_klasyczna = 0.9/a_klasyczna;
% ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);
% 
% % %tuned1
% kp_klasyczna = -80107.7694;
% ki_klasyczna = -6.9753;
% 
% %tuned 2
% kp_klasyczna = -50769.7405;
% ki_klasyczna = -16.3153;
% 
% kp_klasyczna = -174031.4641;
% ki_klasyczna = -2.1291;
% 
% TcwuK = 44;
% czas = 1200000;
% sim("sim_grzejnikowa_model_bojlera_pi.slx", czas);
% figure(12);
% plot(ans.tout,ans.kupfmuller),hold on, grid on;
% legend('Tcwu kupf');
% 
% figure(13);
% plot(ans.tout,ans.uchyb_klasyczna),hold on, grid on;
% legend('uchyb');

%% model domu