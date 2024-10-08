clear all;
% close all;

czas = 2000000;
skok_czas = 1000000;
skok_czas0 = 500000; %czas skoku Tzew
skok_czas2 = 5000;
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
qtbN = -100;
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
Tset_cwu = 30;
% Tset_cwu = 43.1454; 

az=(TgzN-TzewN)/(TwewN-TzewN);
bz=(TgzN-TwewN)/(TwewN-TzewN);

ap=(TgpN-TzewN)/(TwewN-TzewN);
bp=(TgpN-TwewN)/(TwewN-TzewN);

az_bojlera =(TrzN-TzewN)/(TcwuN-TzewN);
bz_bojlera =(TrzN-TcwuN)/(TcwuN-TzewN);

ap_bojlera =(TrpN-TzewN)/(TcwuN-TzewN);
bp_bojlera =(TrpN-TcwuN)/(TcwuN-TzewN);

dqt = 0;
dTzew = 5;
dfmp = 0;
dTgz = 0;
dfmb = 0;
dfmk = 0;
dqtb = 0;
dqtb2 = 0;
qp_skok = 0*qgN;
dspr = 0;
Tzadana0 = 20;
TwewK = 20;
dRz_b = 0;
dRz_p = 0;
dTcwu = 5;

dpoN1 = 10000;
dpoN = 1*dpoN1; % Pascali ciśnienie wytwarzane przez pompę
a = 0.1; % współczynnik
dpkN = a * dpoN; % Pascali spadek ciśnienia na pompie ciepła
zmiana_po = 0;
Rk = a * dpoN /fmkN; % opór kotła/pompy
Rp = (dpoN-dpkN)/fmpN;
Rb = (dpoN-dpkN)/fmbN;
RzN = 0; % zawór całkowicie otwarty

model = "sim_instalacja_podlogowa_krzywe_pogodowe.slx";
%bojler test
kp_zaw_bojler = -71228.0398;
ki_zaw_bojler = -14.4269;

%podlogowka test
kp_zaw_podloga = -199012.2254;
ki_zaw_podloga = -1.8719;
% kp_zaw_podloga = -11978.3307;
% ki_zaw_podloga = -1.0421;



sim(model,czas);
figure(1);
plot(ans.tout(100100:110000),ans.Twew(100100:110000),'m'),hold on, grid on;

figure(2);
plot(ans.tout(100100:110000),ans.Tcwu(100100:110000),'m'),hold on, grid on;

figure(3);
plot(ans.tout(100100:110000),ans.Tkz(100100:110000),'m'),hold on, grid on;

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