clear all;
close all;

czas = 4000000;
skok_czas = 1000000;
skok_czas2 = 2500000;
czas_skoku_10pro = 1000000;
% delay = 1000;
delay = 3000;

cp = 1000;   %ciepło wlaściwe powietrza
pp = 1.2;    %gęstość powietrza
cpw = 4175;  %ciepło wlaściwe wody
pw = 960;    %gęstość wody
cps = 840;   %ciepło wlaściwe betonu komórkowego
ps = 800;    %gęstość betonu komórkowego
cpp = 1000;   %ciepło wlaściwe podłogówki
TzewN = -9; %°C nominalna
TwewN = 20;  %°C
TgzN = 45;   %°C
TkzN = 45;   %temp wody wyplywajacej z kotla nominalna
TgpN = 35;   %°C 
TkpN = 35;   %temp wody wplywajacej do kotla nominalna
TsN = 5;     %°C temp. ścian \
TpN = 28;    %°C temp podłogówki
% qgN = 5000;  %W zapotrzebowanie pokoju 
qgN = 7000;  %W zapotrzebowanie pokoju 
qbN = 2700;  %W bojlera
qkN = 1*qgN+1*qbN; %W moc kotla
qtN = 0;     %W
qtbN = 0;
qtb2N = 0;
TcwuN = 15; 
TrzN = TkzN;
TrpN = TgpN;

Vp = 7.5*10*2.5;      %objętość pokoju
Vs = (7.5+0.5)*10.5*3-Vp; %objętość ścian
Vgp = 7.5*10*1.8*0.001; %objętość wody podłogówki 1.8l wody na m2
Vk = 120*0.001;     %pojemność kotła 120l
Vb = 100*0.001; %objętość bojlera 100litrów
Vr = 3.14*(31.75*0.001)^2*2.6; % pojemność wody w wężownicy

fmpN= qgN/(cpw*(TgzN-TgpN));
% fmpN= qkN/(cpw*(TgzN-TgpN));
fmbN = qbN/(cpw*(TrzN-TrpN));
fmkN = fmpN + fmbN;

Kcw = qgN/(TwewN - TsN);
Kcs = qgN/(TsN-TzewN);
Kcp1 = qgN/(TgpN-TpN);
Kcp2 = qgN/(TpN-TwewN);
Kcr = cpw*fmbN*(TrzN - TrpN)/(TrpN - TcwuN);

Cvgp = cpw*pw*Vgp;  %pojemność cieplna wody w podłogówce
% Cvp = Cvgp + cpp*7.5*10*6.5*21;  %pojemność cieplna podłogówki [20kg] tutaj 20kg na 1m2 grubość 1cm posadzka betonowa tutaj 6.5cm grubości
% %masa posadzki: 7.5*10*6.5*26
Cvp = cpp*7.5*10*0.065*2600;  %pojemność cieplna podłogówki [2600kg na 1m3] 
%masa posadzki: 7.5*10*6.5*21

Cvw = cp*pp*Vp;   %pojemność cieplna powietrza w pomieszczeni7u
Cvk = cpw*pw*Vk;  %pojemność cieplna wody w kotle 
Cvs = cps*ps*Vs;
Cvr = cpw*pw*Vr;  %pojemność cieplna wody w wężownicy
Cvcwu = cpw*pw*Vb;  %pojemność cieplna wody w bojlerze 

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


Tgp0 = TgpN;
Twew0 = TwewN;
Tkz0 = TkzN;
Ts0 = TsN;
Tcwu0 = TcwuN;
Trp0 = TrpN;
Tp0 = TpN;
Tset_cwu = 45;

dqt = 0;
dTzew = 0;
dfmp = 0;
dTgz = 0;
dfmb = 0;
dfmk = 0;
dqtb = 0;
dqtb2 = 0;
dTset_cwu = 0;
qp_skok = 0*qgN;
dspr = 0;
dRz_b = 30000;
dRz_p = 0;

dpoN1 = 10000;
dpoN = 1*dpoN1; % Pascali ciśnienie wytwarzane przez pompę
a = 0.1; % współczynnik
dpkN = a * dpoN; % Pascali spadek ciśnienia na pompie ciepła
zmiana_po = 0;
Rk = a * dpoN /fmkN; % opór kotła/pompy
Rp = (dpoN-dpkN)/fmpN;
Rb = (dpoN-dpkN)/fmbN;
RzN = 0; % zawór całkowicie otwarty


model = "sim_instalacja_podlogowa.slx";

sim(model,czas);

% figure(1);
% plot(ans.tout,ans.Twew,'k'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Identyfikacja Twew - Skok o 10%');
% legend('Twew');
% 
% figure(2);
% plot(ans.tout,ans.Tkz,'k'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Identyfikacja Tkz- Skok o 10%');
% legend('Tkz');

% figure(1);
% plot(ans.tout,ans.Twew,'r'),hold on, grid on;
% plot(ans.tout,ans.Tgp,'g'),hold on, grid on;
% plot(ans.tout,ans.Ts,'b'),hold on, grid on;
% plot(ans.tout,ans.Tp,'m'),hold on, grid on;
% plot(ans.tout,ans.Tkz,'k'),hold on, grid on;
% legend('Twew','Tgp','Ts','Tp','Tkz');

% figure(2);
% plot(ans.tout,ans.qk),hold on, grid on;
% legend('qk');
% 
% figure(3);
% plot(ans.tout,ans.kw),hold on, grid on;
% % plot(ans.tout,ans.kw_q_grz),hold on, grid on;
% legend('kw');
% 
% figure(6);
% plot(ans.tout,ans.COP),hold on, grid on;
% % plot(ans.tout,ans.kw_q_grz),hold on, grid on;
% legend('COP');


% figure(5);
% plot(ans.tout,ans.f_pompa),hold on, grid on;
% plot(ans.tout,ans.f_bojler),hold on, grid on;
% plot(ans.tout,ans.f_dom),hold on, grid on;
% legend('f pompa', 'f bojler', 'f dom');

Dkwh = sum(ans.kw)/length(ans.kw);
fprintf('Nominal average energy consumption kwh: %i \n', Dkwh);

% Dkwh = 0;
% for i = 1:length(ans.COP)
%     Dkwh = Dkwh + ans.qk(i)/ans.COP(i);
% end
% Dkwh = Dkwh/length(ans.COP);
% fprintf('COP average energy consumption kwh: %i \n', Dkwh);
figure(1);
plot(ans.tout,ans.Twew,'k'),hold on, grid on;

figure(2);
plot(ans.tout,ans.Tkz,'k'),hold on, grid on;

% figure(3);
% plot(ans.tout,ans.Tcwu,'k'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Identyfikacja po Tcwu - Rb = 30000');
% legend('Tcwu');
% 
%%  modele twew
% dspr = 0.1;
% k=(21.2138-18.4692)/dspr;
% T_klasyczna = 156666.67;
% % T0_klasyczna = 1001040;
% T0_klasyczna = 3420;
% T_dwupunkt = 1.5*(93396.2-25471.65);
% % T0_dwupunkt = 93396.2 - T_dwupunkt;
% T0_dwupunkt = 102396.2 - T_dwupunkt;
% 
% figure(1);
% sim("sim_instalacja_podlogowa_modele.slx",czas);
% plot(ans.tout,ans.kupfmuller,'g'),hold on, grid on;
% % plot(ans.tout,ans.dwupunktowa,'b'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Identyfikacja Twew - Skok o 10%');
% legend('Twew', 'Twew kupf');
% % legend('Twew', 'Twew kupf', 'Twew dwupkt');

%%  modele Tkz
% dspr = 0.1;
% k=(47.2601-42.1482)/dspr;
% T_klasyczna = 54794.52;
% T0_klasyczna = 547.9;
% 
% 
% figure(2);
% sim("sim_podlogowa_model_tkz.slx",czas);
% plot(ans.tout,ans.kupfmuller,'g'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Identyfikacja Tkz- Skok o 10%');
% legend('Tkz', 'Tkz kupf');
% 
% a_klasyczna = k*T0_klasyczna/T_klasyczna;
% kp_klasyczna = 0.9*a_klasyczna;
% ki_klasyczna = kp_klasyczna/(3*T0_klasyczna);
% 
% TkzK = 45;
% sim("sim_podlogowa_model_tkz_pi.slx",czas);
% figure(10);
% plot(ans.tout,ans.kupfmuller,'r'),hold on, grid on;
% 
% kp_klasyczna = 0.084326;
% ki_klasyczna = 1.2496e-06;
% sim("sim_podlogowa_model_tkz_pi.slx",czas);
% 
% plot(ans.tout,ans.kupfmuller,'b'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Skok Tkz do 45°C - PI');
% legend('Tkz - ZN', 'Tkz - tuned');


%% model po Rb
dRz_b = 30000;
k=(18.2441-19.0205)/dRz_b;
T_klasyczna = 10736.34;
T0_klasyczna = 107.4;

figure(3);
plot(ans.tout,ans.Tcwu,'k'),hold on, grid on;
sim("sim_instalacja_podlogowa_modele_bojler.slx",czas);
plot(ans.tout,ans.kupfmuller,'g'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Identyfikacja po Tcwu - Rb = 30000');
legend('Tcwu', 'Tcwu kupf');
