clear all;
close all;

czas = 3000000;
skok_czas = 1000000;
skok_czas2 = 179000;
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
dTzew = 0;
dfmg = 0*fmgN;
dfmb = 0;
dqtb = 0; %ujemny skok symuluje utratę ciepła (wypływ ciepłej wody)
dqtb2 = 0;
dTset_cwu = 0;
qk_skok = 0;
dspr = 0;

model = "sim_instalacja_grzejnikowa.slx";

sim(model,czas);
figure(1);
plot(ans.tout,ans.Twew,'r'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Identyfikacja po Twew - Skok o 10%');
legend('Twew');

figure(2);
plot(ans.tout,ans.Tcwu,'r'),hold on, grid on;
xlabel('t[s]');
ylabel('T[°C]');
title('Identyfikacja po Tcwu - Skok o 10%');
legend('Tcwu');


% figure(1);
% plot(ans.tout,ans.Twew,'r'),hold on, grid on;
% plot(ans.tout,ans.Tgp,'g'),hold on, grid on;
% plot(ans.tout,ans.Ts,'b'),hold on, grid on;
% plot(ans.tout,ans.Tkz,'m'),hold on, grid on;
% plot(ans.tout,ans.Trp,'k'),hold on, grid on;
% plot(ans.tout,ans.Tcwu,'c'),hold on, grid on;
% legend('Twew','Tgp','Ts','Tkz','Trp','Tcwu');

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

%% modele po skoku na mocy qk
% figure(1);
% plot(ans.tout,ans.Twew,'r'),hold on, grid on;
% % legend('Twew');
% 
% figure(5);
% plot(ans.tout,ans.Tkz,'r'),hold on, grid on;
% % legend('Tkz');
% 
% Dkwh = sum(ans.kw)/length(ans.kw);
% fprintf('Nominal average energy consumption kwh: %i \n', Dkwh);
% 
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


%% modele po wew
% dspr = 0.1;
% k = (21.2138-18.4671)/dspr;
% T_dwupunkt = 1.5*(29487.18-2564.1025);
% % T0_dwupunkt = 29487.18-T_dwupunkt;
% T0_dwupunkt = 40487.18-T_dwupunkt;
% T_klasyczna = 25641.03;
% % T0_klasyczna = 1000010;
% T0_klasyczna = 256;
% 
% % Dkwh = 0;
% % for i = 1:length(ans.COP)
% %     Dkwh = Dkwh + ans.qk(i)/ans.COP(i);
% % end
% % Dkwh = Dkwh/length(ans.COP);
% % fprintf('COP average energy consumption kwh: %i \n', Dkwh);
% 
% sim("sim_instalacja_grzejnikowa_modele.slx",czas);
% figure(1);
% plot(ans.tout,ans.kupfmuller,'b'),hold on, grid on;
% % plot(ans.tout,ans.dwupunktowa,'b'),hold on, grid on;
% xlabel('t[s]');
% ylabel('T[°C]');
% title('Identyfikacja po Twew - Skok o 10%');
% % legend('Twew', 'Twew kupf', 'Twew dwupkt');
% legend('Twew', 'Twew kupf');
% % legend('Twew');
% 
% 
% % % figure(1);
% % % plot(ans.tout,ans.Twew,'r'),hold on, grid on;
% % % % plot(ans.tout,ans.Tgp,'g'),hold on, grid on;
% % % % plot(ans.tout,ans.Ts,'b'),hold on, grid on;
% % % % plot(ans.tout,ans.Tkz,'m'),hold on, grid on;
% % % % legend('Twew','Tgp','Ts','Tkz');
% % % legend('Twew');
% % % figure(5);
% % % plot(ans.tout,ans.f_pompa),hold on, grid on;
% % % plot(ans.tout,ans.f_dom),hold on, grid on;
% % % legend('f pompa', 'f dom');
